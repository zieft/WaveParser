wavefront_filepath = './testdataset/simple/texturedMesh.obj'
texture_filepath = './testdataset/simple/texture_1001.png'
#
# wavefront_filepath = './testdataset/console_one_piece_output/Texturing/LSCM/texturedMesh.obj'
# texture_filepath = './testdataset/console_one_piece_output/Texturing/LSCM/texture_1001.png'

import math
import random
from collections import deque

import cv2
import matplotlib.pyplot as plt
import numpy as np


class TPixel:
    __slots__ = [
        'intensity',  # The intensity of the pixel
        'UV',  # the UV coordinates of the pixel
        'coor',  # the corresponding spatial coordinates of the pixel in the 3D model
        'face',  # the face to which the pixel belongs
        'uv_pixel_index'  # the index of the pixel in the texture image
    ]

    def __init__(self, intensity, uv):
        self.intensity = intensity
        self.UV = uv

        self.coor = None
        self.face = None

        self.uv_pixel_index = None

    def __repr__(self):
        return str(self.intensity)

    def __str__(self):
        return str(self.intensity)


class TextureObj:
    __slots__ = [
        'filepath',  # path of the texture file
        'img',  # texture stored as ndarray
        'pixelated_img',  # pixelated image
        'image_size',  # image should be a square
    ]

    def __init__(self, filepath):
        self.filepath = filepath
        self.img = self.img_read()
        self.pixelated_img = self.init_pixels()

    def img_read(self):
        img = cv2.imread(self.filepath, cv2.IMREAD_GRAYSCALE)
        self.image_size = img.shape[0]
        return img

    def init_pixels(self):
        img = np.zeros((self.image_size, self.image_size), dtype='O')
        for i in range(img.shape[0]):
            for j in range(img.shape[1]):
                u = j / self.img.shape[0]
                v = 1 - i / self.img.shape[1]  # wavefront里1表示顶部，0表示底部
                pix = TPixel(
                    intensity=self.img[i][j],
                    uv=(u, v)
                )
                pix.uv_pixel_index = (i, j)
                img[i][j] = pix
        return img


class WVertex:
    __slots__ = [
        'coor',  # coordinates in 3d model
        'ver_index',  # index of vertex, the line number of a line starting with "v"
        'uv_index',  # index of vertex in Blender
        'UVs',  # a list of UV coordinate(s)
        'neighbors',  # list of neighbor Vertices
        'faces',  # list of faces, in which the vertex belongs to
        'valid_uv_index_for_face',
        'ref_edge'
    ]

    def __init__(self, coor):
        self.coor = coor  # tuple
        self.ver_index = 0
        self.uv_index = []  # blender里的顶点索引，实际上为uv_index - 1 （blender索引从0起始）
        self.UVs = []  # list of  uv indices, 一个顶点有可能对应不同的uv坐标
        self.neighbors = []  # list of WVertex objects.
        self.faces = []  # list of WFace objects. 表示此顶点属于哪些面
        self.valid_uv_index_for_face = -1
        self.ref_edge = None

    def __str__(self):
        return 'Ver：' + str(self.ver_index)

    def __repr__(self):
        return 'Ver：' + str(self.ver_index)

    def ver_index_setter(self, index):
        self.ver_index = index

    def uv_index_setter(self, index):
        self.uv_index.append(index)

    def UVs_setter(self, UV):
        if UV not in self.UVs:
            self.UVs.append(UV)

    def neighbor_setter(self, neighbors):
        self.neighbors = list(set(self.neighbors + neighbors))

    def faces_setter(self, face):
        self.faces.append(face)


class WEdge:
    existent = {}
    __slots__ = [
        'eindex',  # index of the edge
        'vertices',  # WVert instance
        'mid_point_UV',  # UV coordinate of the middle point of the edge
        'angle',  # The angle swept by the edge from the horizontal line, counterclockwise.
        'faces',  # WFace instance
        'length_uv',  # the length of the edge in UV space
        'length_3d'  # the length of the edge in 3D space
    ]

    def __init__(self):
        self.eindex = None
        self.vertices = []
        self.mid_point_UV = {}  # 边在不同面中的中心点是不同的
        self.angle = {}  # 从水平线逆时针旋转到该边所扫过的夹角,degrees
        self.faces = []  # TODO：重构faces成字典，用来记录该条边在每个面中使用哪种UV坐标
        self.length_uv = {}  # 在不同面中的长度可能不同
        self.length_3d = None

    def __repr__(self):
        return "Edge: {} with vertices {}".format(self.eindex, self.vertices)

    def __str__(self):
        return "Edge: {} with vertices {}".format(self.eindex, self.vertices)

    def find_mid_point_and_angle(self, face):
        A = self.vertices[0].UVs[face.valid_UV_index['vertex_{}'.format(self.vertices[0].ver_index)]]
        B = self.vertices[1].UVs[face.valid_UV_index['vertex_{}'.format(self.vertices[1].ver_index)]]

        self.mid_point_UV['face_{}'.format(face.findex)] = ((A[0] + B[0]) / 2, (A[1] + B[1]) / 2)

        x1, y1 = A
        x2, y2 = B

        length_ab = math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)

        direction_ab = [(x2 - x1) / length_ab, (y2 - y1) / length_ab]

        rotation_angle = math.degrees(math.atan2(direction_ab[1], direction_ab[0]))

        self.angle['face_{}'.format(face.findex)] = rotation_angle

    def cal_length(self, face):
        ver1 = self.vertices[0].UVs[face.valid_UV_index['vertex_{}'.format(self.vertices[0].ver_index)]]
        ver2 = self.vertices[1].UVs[face.valid_UV_index['vertex_{}'.format(self.vertices[1].ver_index)]]
        self.length_uv[face.findex] = math.sqrt((ver1[0] - ver2[0]) ** 2 + (ver1[1] - ver2[1]) ** 2)


class WFace:
    existent = {}
    __slots__ = [
        'findex',  # index of this face
        'vertices',  # WVert instances
        'area',  # area of this face
        'pixels',  # TPixel instances
        'mapping_matrix',  # UV to 3D
        'edges',  # WEdge instances
        'already_drawn',  # Flag
        'valid_UV_index'  # valid uv index of vertices
    ]

    def __init__(self):
        """
        vertices: list of 3 WVertex objects.
        """
        self.findex = 0
        self.vertices = None
        self.area = None
        self.pixels = None
        self.mapping_matrix = None  # UV map to 3D
        self.edges = []
        self.already_drawn = False
        self.valid_UV_index = {}
        # self.texture_uv = [(), ()]  不需要额外记录uv，因为vertex自带uv

    def __str__(self):
        return 'Face:' + str(self.findex) + '，Vertices：' + str(self.vertices)

    def __repr__(self):
        return 'Face:' + str(self.findex) + '，Vertices：' + str(self.vertices)

    def cal_area(self, texture_shape):
        p1 = tuple(int(round(x * texture_shape[0])) for x in
                   self.vertices[0].UVs[self.valid_UV_index['vertex_{}'.format(self.vertices[0].ver_index)]])
        p2 = tuple(int(round(x * texture_shape[0])) for x in
                   self.vertices[1].UVs[self.valid_UV_index['vertex_{}'.format(self.vertices[1].ver_index)]])
        p3 = tuple(int(round(x * texture_shape[0])) for x in
                   self.vertices[2].UVs[self.valid_UV_index['vertex_{}'.format(self.vertices[2].ver_index)]])

        vertices = sorted([p1, p2, p3], key=lambda p: p[1])

        # 提取三个点的坐标和纵坐标范围
        y_min = vertices[0][1]
        y_max = vertices[2][1]

        x1, y1 = vertices[0]
        x2, y2 = vertices[1]
        x3, y3 = vertices[2]

        self.area = 0.5 * abs((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)))

    @staticmethod
    def _cross_product(v1, v2):
        # 计算向量 v1 和向量 v2 的叉积
        return v1[0] * v2[1] - v1[1] * v2[0]

    def _point_in_triangle(self, p, p1, p2, p3):
        # 判断点 p 是否在由 p1、p2、p3 围成的三角形内部
        # 使用叉积法判断

        # 计算三角形的边向量
        v1 = (p2[0] - p1[0], p2[1] - p1[1])
        v2 = (p3[0] - p2[0], p3[1] - p2[1])
        v3 = (p1[0] - p3[0], p1[1] - p3[1])

        # 计算点 p 到三个顶点的向量
        vp1 = (p[0] - p1[0], p[1] - p1[1])
        vp2 = (p[0] - p2[0], p[1] - p2[1])
        vp3 = (p[0] - p3[0], p[1] - p3[1])

        # 计算叉积
        c1 = self._cross_product(vp1, v1)
        c2 = self._cross_product(vp2, v2)
        c3 = self._cross_product(vp3, v3)

        # 判断点 p 是否在三角形内部
        return (c1 >= 0 and c2 >= 0 and c3 >= 0) or (c1 <= 0 and c2 <= 0 and c3 <= 0)

    @staticmethod
    def _cross_product_vec(v1, v2):
        # 计算向量的叉积
        return v1[..., 0] * v2[..., 1] - v1[..., 1] * v2[..., 0]

    def _point_in_triangle_vec(self, X, Y, p1, p2, p3):
        # 判断网格点坐标数组中的点是否在由 p1、p2、p3 围成的三角形内部
        # 使用叉积法判断
        # 矢量化
        # 计算三角形的边向量
        v1 = np.array([p2[0] - p1[0], p2[1] - p1[1]])
        v2 = np.array([p3[0] - p2[0], p3[1] - p2[1]])
        v3 = np.array([p1[0] - p3[0], p1[1] - p3[1]])

        # 计算点到三个顶点的向量
        vp1 = np.stack([X - p1[0], Y - p1[1]], axis=-1)
        vp2 = np.stack([X - p2[0], Y - p2[1]], axis=-1)
        vp3 = np.stack([X - p3[0], Y - p3[1]], axis=-1)

        # 计算叉积
        c1 = self._cross_product_vec(vp1, v1)
        c2 = self._cross_product_vec(vp2, v2)
        c3 = self._cross_product_vec(vp3, v3)

        # 判断点是否在三角形内部
        mask = (c1 >= 0) & (c2 >= 0) & (c3 >= 0) | (c1 <= 0) & (c2 <= 0) & (c3 <= 0)

        return mask

    def find_pixels_crossproduct_vec(self, pixelized_img, image_size):
        i = self.valid_UV_index['vertex_{}'.format(self.vertices[0].ver_index)]
        j = self.valid_UV_index['vertex_{}'.format(self.vertices[1].ver_index)]
        k = self.valid_UV_index['vertex_{}'.format(self.vertices[2].ver_index)]
        p1 = (
            round(self.vertices[0].UVs[i][0] * image_size), image_size - round(self.vertices[0].UVs[i][1] * image_size))
        p2 = (
            round(self.vertices[1].UVs[j][0] * image_size), image_size - round(self.vertices[1].UVs[j][1] * image_size))
        p3 = (
            round(self.vertices[2].UVs[k][0] * image_size), image_size - round(self.vertices[2].UVs[k][1] * image_size))

        min_x = np.min([p1[0], p2[0], p3[0]])
        max_x = np.max([p1[0], p2[0], p3[0]])
        min_y = np.min([p1[1], p2[1], p3[1]])
        max_y = np.max([p1[1], p2[1], p3[1]])

        X, Y = np.meshgrid(np.arange(min_x, max_x + 1), np.arange(min_y, max_y + 1))

        # 创建三角形内的掩码
        mask = self._point_in_triangle_vec(X, Y, p1, p2, p3)

        # 提取在三角形内的像素坐标
        triangle_pixel_UV = np.column_stack((X[mask], Y[mask]))
        triangle_pixels = []
        for i in triangle_pixel_UV:
            try:
                pixel_instance = pixelized_img[i[1], i[0]]
            except IndexError:
                continue
            uv = list(pixel_instance.UV) + [1]
            pixel_instance.coor = np.dot(self.mapping_matrix, np.array(uv))
            pixel_instance.face = self
            triangle_pixels.append(pixel_instance)

        self.pixels = triangle_pixels

    def determine_mapping_matrix_2d_to_3d(self):
        # 三维空间中三个点的坐标
        A = np.array(self.vertices[0].coor)
        B = np.array(self.vertices[1].coor)
        C = np.array(self.vertices[2].coor)

        # 构造常数矩阵
        const_matrix = np.vstack((A, B))
        const_matrix = np.vstack((const_matrix, C))

        # 二维平面上的映射点坐标
        P = list(self.vertices[0].UVs[self.valid_UV_index['vertex_{}'.format(self.vertices[0].ver_index)]])
        Q = list(self.vertices[1].UVs[self.valid_UV_index['vertex_{}'.format(self.vertices[1].ver_index)]])
        W = list(self.vertices[2].UVs[self.valid_UV_index['vertex_{}'.format(self.vertices[2].ver_index)]])
        P += [1]
        Q += [1]
        W += [1]

        # 构造系数矩阵
        coeff_matrix = np.vstack((P, Q))
        coeff_matrix = np.vstack((coeff_matrix, W))

        # 求解矩阵
        self.mapping_matrix = np.linalg.solve(coeff_matrix, const_matrix)

    def determine_valid_UV_index(self, image_size):
        """ determine the distances between 3 vertices """
        # todo: 已经采用了新方法，但是还没有经过测试，设计一个单元测试来测试一下。
        threshold = image_size / 5
        for i in range(len(self.vertices[0].UVs)):
            for j in range(len(self.vertices[1].UVs)):
                for k in range(len(self.vertices[2].UVs)):
                    try:
                        ver1 = (self.vertices[0].UVs[i][0] * image_size, self.vertices[0].UVs[i][1] * image_size)
                    except IndexError:
                        continue
                    try:
                        ver2 = (self.vertices[1].UVs[j][0] * image_size, self.vertices[1].UVs[j][1] * image_size)
                    except IndexError:
                        continue
                    try:
                        ver3 = (self.vertices[2].UVs[k][0] * image_size, self.vertices[2].UVs[k][1] * image_size)
                    except IndexError:
                        continue

                    dis1 = math.sqrt((ver2[0] - ver1[0]) ** 2 + (ver2[1] - ver1[1]) ** 2)
                    dis2 = math.sqrt((ver3[0] - ver1[0]) ** 2 + (ver3[1] - ver1[1]) ** 2)
                    dis3 = math.sqrt((ver2[0] - ver3[0]) ** 2 + (ver2[1] - ver3[1]) ** 2)

                    if dis1 < threshold and dis2 < threshold and dis3 < threshold:
                        self.valid_UV_index = {
                            'vertex_{}'.format(self.vertices[0].ver_index): i,
                            'vertex_{}'.format(self.vertices[1].ver_index): j,
                            'vertex_{}'.format(self.vertices[2].ver_index): k,
                        }
                        return

        raise TypeError("未找到合适的ijk")


class WavefrontObj:
    _instance = None

    def __new__(cls, *args, **kwargs):
        if not isinstance(cls._instance, cls):
            cls._instance = super().__new__(cls)
        return cls._instance

    __slots__ = [
        'texture',  # TextureObj instance
        'filepath',  # filepath to the texture image
        'vertices_dict',  # dict format of all vertices
        'UVs_dict',  # dict format of all UV coordinates
        'edges_dict',  # dict format of all edges
        'faces_dict'  # dict format of all faces
    ]

    def __init__(self, wavefront_path, texture_path):
        self.texture = TextureObj(texture_path)
        self.filepath = wavefront_path
        self.vertices_dict = self.parse_vertices_dict()
        self.UVs_dict = self.parse_uvs_dict()
        self.edges_dict = {}
        self.faces_dict = self.parse_faces_edges()

    def parse_vertices_dict(self):
        import pywavefront

        scene = pywavefront.Wavefront(
            self.filepath,
            strict=False,
            encoding="iso-8859-1",
            parse=False,
        )
        scene.parse()

        vertices_dict = dict(enumerate(scene.vertices, 1))
        # 在这里原地修改字典，使字典的值为WVert实例，后面用到WVert时，直接引用即可
        for i in vertices_dict:
            vertices_dict[i] = WVertex(vertices_dict[i])
        return vertices_dict

    def parse_uvs_dict(self):
        import pywavefront

        scene = pywavefront.Wavefront(
            self.filepath,
            strict=False,
            encoding="iso-8859-1",
            parse=False,
        )
        scene.parse()

        UVs_dict = dict(enumerate(scene.parser.tex_coords, 1))

        return UVs_dict

    def parse_faces_edges(self):
        with open(self.filepath, 'r') as f:
            line = f.readline()
            face_index = 1
            edge_index = 1
            faces_dict = {}
            while line:
                if line.startswith('f'):
                    if face_index == 7083:
                        print('no')
                    line = line.strip()
                    elements = line.split()
                    vertex_indices = [int(x.split('/')[0]) for x in elements[1:]]
                    uv_indices = [int(x.split('/')[1]) for x in elements[1:]]
                    wvertices = []
                    face = WFace()
                    face.findex = face_index
                    # WFace.existent[
                    #     '{},{},{}'.format(vertex_indices[0], vertex_indices[1], vertex_indices[2])] = face.findex
                    # 处理顶点，并加入到面中
                    if '{},{},{}'.format(vertex_indices[0], vertex_indices[1], vertex_indices[2]) not in WFace.existent:
                        for i in range(3):  # a face_A is always a triangle, therefore iterate 3 times.
                            ver = self.vertices_dict[vertex_indices[i]]
                            # ver.uv_index_setter(uv_indices[i])
                            # ver.valid_uv_index_for_face = -1
                            if uv_indices[i] not in ver.uv_index:
                                ver.ver_index_setter(vertex_indices[i])
                                ver.uv_index_setter(uv_indices[i])
                                ver.UVs_setter(self.UVs_dict[uv_indices[i]])
                                ver.valid_uv_index_for_face += 1
                            face.valid_UV_index['vertex_{}'.format(vertex_indices[i])] = ver.valid_uv_index_for_face
                            neighbors = [x for x in vertex_indices if x != vertex_indices[i]]
                            ver.neighbor_setter(neighbors)
                            wvertices.append(ver)
                            if face not in ver.faces:
                                ver.faces_setter(face)
                        WFace.existent[
                            '{},{},{}'.format(vertex_indices[0], vertex_indices[1], vertex_indices[2])] = face.findex
                        face.vertices = wvertices
                        # face.determine_valid_UV_index(self.texture.image_size)

                        # 生成并处理边，并加入到面中
                        for i in range(len(face.vertices)):
                            for j in range(i + 1, len(face.vertices)):
                                ver_index_i = face.vertices[i].ver_index
                                ver_index_j = face.vertices[j].ver_index
                                if '{},{}'.format(ver_index_i, ver_index_j) not in WEdge.existent:
                                    edge = WEdge()
                                    edge.eindex = edge_index
                                    WEdge.existent['{},{}'.format(ver_index_i, ver_index_j)] = edge.eindex
                                    WEdge.existent['{},{}'.format(ver_index_j, ver_index_i)] = edge.eindex
                                    self.edges_dict[edge.eindex] = edge
                                    edge.vertices.append(self.vertices_dict.get(ver_index_i))
                                    edge.vertices.append(self.vertices_dict.get(ver_index_j))
                                    edge_index += 1
                                else:
                                    edge = self.edges_dict[WEdge.existent['{},{}'.format(ver_index_i, ver_index_j)]]
                                edge.faces.append(face)
                                edge.find_mid_point_and_angle(face)
                                edge.cal_length(face)
                                face.edges.append(edge)

                        texture_shape = self.texture.img.shape
                        face.determine_mapping_matrix_2d_to_3d()
                        face.cal_area(texture_shape)
                        face.find_pixels_crossproduct_vec(self.texture.pixelated_img, self.texture.image_size)
                        faces_dict[face_index] = face
                        face_index += 1

                line = f.readline()
        return faces_dict


class NewUVUnwrap:
    def __init__(self, wavefront_obj: WavefrontObj):
        self.wavefront_obj = wavefront_obj
        self.img = np.zeros((self.wavefront_obj.texture.image_size * 2, self.wavefront_obj.texture.image_size * 2))


class StaticHandler:
    counter = 0

    @staticmethod
    def get_vertices(index, image_size):
        ver = obj.vertices_dict[index]

        print(ver.UVs[0][0] * image_size, image_size - ver.UVs[0][1] * image_size)

    @staticmethod
    def get_edge(ver1, ver2):
        index = WEdge.existent["{},{}".format(ver1, ver2)]
        edge = obj.edges_dict[index]
        print(edge, edge.mid_point_UV)

    @staticmethod
    def dfs_recursive(face: WFace):
        """ causing stack overflow """
        edge_1 = face.edges[0]
        edge_2 = face.edges[1]
        edge_3 = face.edges[2]

        if face.already_drawn:
            return

        face.already_drawn = True

        for edge in face.edges:
            if len(edge.faces) == 2:
                adjacent_face_1 = edge.faces[0]
                adjacent_face_2 = edge.faces[1]
                if not adjacent_face_1.already_drawn and adjacent_face_1 != face:
                    StaticHandler.dfs_recursive(adjacent_face_1)
                if not adjacent_face_2.already_drawn and adjacent_face_2 != face:
                    StaticHandler.dfs_recursive(adjacent_face_2)
            else:
                continue
        return

    @staticmethod
    def determine_line_with_2_points(point1, point2):
        """y-y1=(y2-y1)(x-x1)/(x2-x1)"""
        try:
            if point1[0] == point2[0]:  # Check for vertical line
                return f"x = {point1[0]}"
        except ValueError:
            print(type(point1[0]), point1[0], point1)
            print(type(point2[0]), point2[0], point2)
        slope = (point2[1] - point1[1]) / (point2[0] - point1[0])  # Calculate slope
        y_intercept = point1[1] - slope * point1[0]  # Calculate y-intercept
        print(f"y = {slope}x + {y_intercept}")
        return slope, y_intercept

    @staticmethod
    def normal_vector_towards_point(slop, ref_point, c):
        # Possible normal vectors
        n1 = np.array([-slop, 1])
        n2 = np.array([slop, -1])

        # Point on the line when x=ref_point[0]
        point_on_line = np.array([ref_point[0], slop * ref_point[0] + c])

        # Vector from A to point on the line
        v = point_on_line - np.array([ref_point[0], ref_point[1]])

        # Determine which normal vector forms an acute angle with v
        if np.dot(n1, v) > 0:
            return n1, n2
        else:
            return n2, n1

    @staticmethod
    def get_unit_vector(x1, y1, x2, y2, x3, y3):
        if x2 - x1:
            # Calculate the slope of AB
            m_AB = (y2 - y1) / (x2 - x1)

            # Calculate the perpendicular slope
            m_l = -1 / m_AB

            # Equation of line l: y - y3 = m_l(x - x3)
            # Equation of line AB: y - y1 = m_AB(x - x1)

            # Solving for x4
            x4 = (y3 - y1 + m_AB * x1 + x3 * m_l) / (m_l + m_AB)
            y4 = m_AB * (x4 - x1) + y1


        else:
            m_AB = math.inf
            m_l = 0

            # Equation of line l: y = y3
            # Equation of line AB: x = x1 = x2
            x4 = x1
            y4 = y3

        DC_x = x3 - x4
        DC_y = y3 - y4

        magnitude_DC = (DC_x ** 2 + DC_y ** 2) ** 0.5

        unit_DC_x = DC_x / magnitude_DC
        unit_DC_y = DC_y / magnitude_DC

        return unit_DC_x, unit_DC_y

    @staticmethod
    def cal_rot_mat(
            Ax1, Ay1, Ax2, Ay2, Ax3, Ay3,
            Bx1, By1, Bx2, By2, Bx3, By3,
    ):
        # Store coordinates as column vectors
        A = np.array([[Ax1, Ax2, Ax3], [Ay1, Ay2, Ay3]])
        B = np.array([[Bx1, Bx2, Bx3], [By1, By2, By3]])

        # Find angle between the arrowed edges in A and B
        vec_A = A[:, 1] - A[:, 0]
        vec_B = B[:, 1] - B[:, 0]
        angle_A = np.arctan2(vec_A[1], vec_A[0])
        angle_B = np.arctan2(vec_B[1], vec_B[0])
        theta = angle_B - angle_A

        theta_list = [theta, -theta, math.pi - theta, theta - math.pi]

        R_list = []
        for theta in theta_list:
            R = np.array([[np.cos(theta), -np.sin(theta)],
                          [np.sin(theta), np.cos(theta)]])
            R_list.append(R)

        ref_norm_unit_u, ref_norm_unit_v = StaticHandler.get_unit_vector(Bx1, By1, Bx2, By2, Bx3, By3)
        R = None
        for R_tmp in R_list:
            rotated_Ax1, rotated_Ay1 = R_tmp.dot(np.array([Ax1, Ay1]))
            rotated_Ax2, rotated_Ay2 = R_tmp.dot(np.array([Ax2, Ay2]))
            rotated_Ax3, rotated_Ay3 = R_tmp.dot(np.array([Ax3, Ay3]))

            rotated_norm_unit_u, rotated_norm_unit_v = StaticHandler.get_unit_vector(rotated_Ax1, rotated_Ay1,
                                                                                     rotated_Ax2, rotated_Ay2,
                                                                                     rotated_Ax3, rotated_Ay3
                                                                                     )

            # check if this two unit vector have opposite direction
            dot_product = ref_norm_unit_u * rotated_norm_unit_u + ref_norm_unit_v * rotated_norm_unit_v
            print(dot_product)
            if abs(dot_product + 1) < 1e-1:  # 这里的阈值需要进行讨论，1e-15是false， 1e-16是true
                R = R_tmp
        if R is not None:
            return R
        else:
            raise ValueError("Rotation matrix not found!")

    @staticmethod
    def find_common_edge(face_A, face_B):
        for a in face_A.edges:
            for b in face_B.edges:
                if a == b:
                    return a
        # print('No common edge.')

    @staticmethod
    def get_point_not_in_common_edge(face, common_edge):
        vertex1, vertex2 = common_edge.vertices
        for vertex in face.vertices:
            if vertex != vertex1 and vertex != vertex2:
                return vertex

    @staticmethod
    def cal_len(x1, y1, x2, y2):
        return math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)

    @staticmethod
    def cal_R_t_s(
            face_A,
            face_B,
    ):
        common_edge = StaticHandler.find_common_edge(face_A, face_B)
        A1, A2 = common_edge.vertices
        A3 = StaticHandler.get_point_not_in_common_edge(face_A, common_edge)
        Ax1, Ay1 = A1.UVs[face_A.valid_UV_index['vertex_{}'.format(A1.ver_index)]]
        Ax2, Ay2 = A2.UVs[face_A.valid_UV_index['vertex_{}'.format(A2.ver_index)]]
        Ax3, Ay3 = A3.UVs[face_A.valid_UV_index['vertex_{}'.format(A3.ver_index)]]
        A_x_coords = [Ax1, Ax2, Ax3, Ax1]
        A_y_coords = [Ay1, Ay2, Ay3, Ay1]

        ver_A = (A1, A2, A3)

        B1, B2 = common_edge.vertices
        # 这里找到的B3是变换前的face2里B3的坐标
        B3 = StaticHandler.get_point_not_in_common_edge(face_B, common_edge)

        # Bx1, By1 = B1.UVs[face_B.valid_UV_index['vertex_{}'.format(B1.ver_index)]]
        # Bx2, By2 = B2.UVs[face_B.valid_UV_index['vertex_{}'.format(B2.ver_index)]]
        # Bx3, By3 = B3.UVs[face_B.valid_UV_index['vertex_{}'.format(B3.ver_index)]]
        Bx1, By1 = B1.UVs[face_B.valid_UV_index['ref0']]
        Bx2, By2 = B2.UVs[face_B.valid_UV_index['ref1']]
        Bx3, By3 = B3.UVs[face_B.valid_UV_index['ref2']]

        rotation_matrix = StaticHandler.cal_rot_mat(
            Ax1, Ay1, Ax2, Ay2, Ax3, Ay3,
            Bx1, By1, Bx2, By2, Bx3, By3
        )
        # Rotate the vertices of Triangle A
        A_rotated = np.dot(rotation_matrix, np.array([A_x_coords[:-1], A_y_coords[:-1]]))

        # Find midpoint of the arrowed edge for the blue triangle
        midpoint_B = np.array([(Bx1 + Bx2) / 2, (By1 + By2) / 2])

        # Find midpoint of the arrowed edge for the rotated yellow triangle
        midpoint_A_rotated = np.array(
            [(A_rotated[0][0] + A_rotated[0][1]) / 2, (A_rotated[1][0] + A_rotated[1][1]) / 2])

        # Compute the translation vector
        translation_vector = midpoint_B - midpoint_A_rotated

        # Calculate length of the common edge in B
        length_B = StaticHandler.cal_len(Bx1, By1, Bx2, By2)

        # Translate the rotated yellow triangle
        A_translated = A_rotated + np.reshape(translation_vector, (2, 1))

        # Calculate length of the arrowed edge for the green triangle
        length_A_translated = StaticHandler.cal_len(A_translated[0][0], A_translated[1][0], A_translated[0][1],
                                                    A_translated[1][1])

        # Calculate scaling factor s
        scale_factor = length_B / length_A_translated

        A_scaled = A_translated * scale_factor

        midpoint_A_scaled = np.array([(A_scaled[0][0] + A_scaled[0][1]) / 2, (A_scaled[1][0] + A_scaled[1][1]) / 2])

        # Compute the new translation vector
        translation_vector_scaled = midpoint_B - midpoint_A_scaled

        A_translated_scaled = A_scaled + np.reshape(translation_vector_scaled, (2, 1))

        return rotation_matrix, translation_vector, scale_factor, translation_vector_scaled, A_translated_scaled, ver_A

    @staticmethod
    def draw_face(
            face_A: WFace = None,
            face_B=None,
            UV_obj=None,
            img_size=None,
            init=False):

        rotation_matrix, \
        translation_vector, \
        scale_factor, \
        translation_vector_scaled, \
        A_translated_scaled, \
        ver_A = StaticHandler.cal_R_t_s(face_A, face_B)

        for pixel in face_A.pixels:
            # copy a new pixel instance from current pixel.
            new_pixel = TPixel(int(pixel.intensity), tuple(list(pixel.UV)))
            new_pixel.coor = list(tuple(pixel.coor))

            new_pixel_uv = np.array(pixel.UV)
            # rotation
            rotated_uv = rotation_matrix.dot(new_pixel_uv)

            # translation
            translated_uv = rotated_uv + translation_vector

            # scaling
            scaled_uv = translated_uv * scale_factor

            # Translate the scaled triangle
            translated_scaled_uv = scaled_uv + translation_vector_scaled
            translated_scaled_uv_list = translated_scaled_uv.tolist()
            # translated_scaled_uv_list = translated_scaled_uv_list[0]

            new_pixel.UV = tuple(translated_scaled_uv_list)
            new_u_pixel_index = round(translated_scaled_uv_list[0] * img_size)
            new_v_pixel_index = round(translated_scaled_uv_list[1] * img_size)
            intensity = new_pixel.intensity
            UV_obj.img[new_u_pixel_index][new_v_pixel_index] = intensity
        face_A.already_drawn = True

        # 将变换后的顶点UV坐标，添加到每个顶点的UVs集合里，并更新该面的valid_UV_index
        if 'ref1' not in face_A.valid_UV_index.keys():
            for i in range(3):
                # TODO: 这里顶点和顶点索引的值 对应有错误
                ver_A[i].UVs.append(tuple(A_translated_scaled[:, i].tolist()))
                for ver in face_A.vertices:
                    if ver.ver_index == ver_A[i].ver_index:
                        face_A.valid_UV_index['ref' + str(i)] = len(face_A.vertices[i].UVs) - 1

    @staticmethod
    def bfs_iteration(
            face_A: WFace,
            face_B: WFace,
            newUV,
    ):
        ref_edge = StaticHandler.find_common_edge(face_A, face_B)
        image_size = newUV.wavefront_obj.texture.image_size
        queue = deque()
        init_condition = [(face_A, ref_edge, face_B)]
        queue.append(init_condition)
        stack_len = 0
        visited_edges = [ref_edge.eindex]
        while queue:
            edges_list = queue.popleft()
            for i in range(len(edges_list)):
                face_A, ref_edge, ref_face = edges_list[i]
                # print(face_A.findex)
                if not face_A.already_drawn:
                    StaticHandler.draw_face(
                        UV_obj=newUV,
                        face_A=face_A,
                        face_B=ref_face,
                        img_size=image_size,
                    )
                    face_A.already_drawn = True
                    StaticHandler.counter += 1
                    print(StaticHandler.counter)
                    plt.figure(dpi=300)
                    plt.imshow(newUV.img)
                    plt.savefig('output' + str(StaticHandler.counter) + '.jpg')
                    print('done!')

            ref_face = face_A  # TODO: 这行代码放这里不合适，因为下面的循环添加了两个依赖face_A的面，而前面的while循环只处理了1个就又更换ref了
            # 将下面的循环添加的元素打包入队，出队的时候可以一同出队

            # TODO: 新思路，用变换过的顶点生成一个假面，把假面和下一个真面压入队列，然后，每次只弹出1组 真假面
            edges_from_face_A = []
            for edge in ref_face.edges:
                if len(edge.faces) == 2 and edge.eindex not in visited_edges:
                    visited_edges.append(edge.eindex)
                    for adjacent_face in edge.faces:
                        if not adjacent_face.already_drawn:
                            edges_from_face_A.append((adjacent_face, edge, ref_face))
            queue.append(edges_from_face_A)

            stack_len = max(stack_len, len(queue))

        return stack_len

    @staticmethod
    def check_if_all_faces_drawn(obj: WavefrontObj):
        status = np.array([face.already_drawn for face in obj.faces_dict.values()], dtype=bool)
        return status


if __name__ == '__main__':
    obj = WavefrontObj(wavefront_filepath, texture_filepath)

    # init condition
    init_index = 1
    first_face_A = obj.faces_dict[init_index]

    init_face_B = WFace()
    init_face_B.findex = 0
    init_face_B.already_drawn = True

    init_ver1 = first_face_A.edges[0].vertices[0]
    init_ver2 = first_face_A.edges[0].vertices[1]

    init_ver3 = WVertex((0, 0, 0))
    init_ver3.ver_index = 0
    init_ver3.UVs = [(random.random(), random.random())]

    init_face_B.vertices = [init_ver1, init_ver2, init_ver3]
    # init_face_B.valid_UV_index = {
    #     'vertex_{}'.format(init_ver1.ver_index): 0,
    #     'vertex_{}'.format(init_ver2.ver_index): 0,
    #     'vertex_0': 0,
    # }
    init_face_B.valid_UV_index = {
        'ref0'.format(init_ver1.ver_index): 0,
        'ref1'.format(init_ver2.ver_index): 0,
        'ref2': 0,
    }
    # 真实数据集中的edges0不一定对应的是那两个点
    # 用一个for循环来判断一下
    init_face_B.edges = [first_face_A.edges[0], ]

    # 实例化空白画板
    newUV = NewUVUnwrap(obj)

    stack_len = StaticHandler.bfs_iteration(
        face_A=first_face_A,
        face_B=init_face_B,
        newUV=newUV
    )
    status = StaticHandler.check_if_all_faces_drawn(obj)
    number_of_not_drawn_face = np.count_nonzero(status == False)

    # cv2.imshow('1', newUV.img)
    # cv2.waitKey(0)
    plt.figure(dpi=1200)
    plt.imshow(newUV.img)
    plt.savefig('output.jpg')
    print('done!')
