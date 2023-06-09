wavefront_filepath = './testdataset/smallTexture/texturedMesh.obj'
texture_filepath = './testdataset/smallTexture/texture_1001.png'
import math
import cv2
import numpy as np
import copy
import matplotlib.pyplot as plt


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
        'pixelated_img'  # pixelated image
    ]

    def __init__(self, filepath):
        self.filepath = filepath
        self.img = self.img_read()
        self.pixelated_img = self.init_pixels()

    def img_read(self):
        img = cv2.imread(self.filepath, cv2.IMREAD_GRAYSCALE)
        return img

    def init_pixels(self):
        img = np.zeros((4096, 4096), dtype='O')
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
        'faces'  # list of faces, in which the vertex belongs to
    ]

    def __init__(self, coor):
        self.coor = coor  # tuple
        self.ver_index = 0
        self.uv_index = 0  # blender里的顶点索引，实际上为uv_index - 1 （blender索引从0起始）
        self.UVs = []  # list of  uv indices, 一个顶点有可能对应不同的uv坐标
        self.neighbors = []  # list of WVertex objects.
        self.faces = []  # list of WFace objects. 表示此顶点属于哪些面

    def __str__(self):
        return 'Ver：' + str(self.ver_index)

    def __repr__(self):
        return 'Ver：' + str(self.ver_index)

    def ver_index_setter(self, index):
        self.ver_index = index

    def uv_index_setter(self, index):
        self.uv_index = index

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
        'eindex',       # index of the edge
        'vertices',     # WVert instance
        'mid_point_UV', # UV coordinate of the middle point of the edge
        'angle',        # The angle swept by the edge from the horizontal line, counterclockwise.
        'faces',        # WFace instance
        'length_uv',    # the length of the edge in UV space
        'length_3d'     # the length of the edge in 3D space
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
        self.valid_UV_index = None
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

    def find_pixels_crossproduct(self):
        i = self.valid_UV_index['vertex_{}'.format(self.vertices[0].ver_index)]
        j = self.valid_UV_index['vertex_{}'.format(self.vertices[1].ver_index)]
        k = self.valid_UV_index['vertex_{}'.format(self.vertices[2].ver_index)]
        p1 = (round(self.vertices[0].UVs[i][0] * 4096), round(self.vertices[0].UVs[i][1] * 4096))
        p2 = (round(self.vertices[1].UVs[j][0] * 4096), round(self.vertices[1].UVs[j][1] * 4096))
        p3 = (round(self.vertices[2].UVs[k][0] * 4096), round(self.vertices[2].UVs[k][1] * 4096))
        min_x = min(p1[0], p2[0], p3[0])
        max_x = max(p1[0], p2[0], p3[0])
        min_y = min(p1[1], p2[1], p3[1])
        max_y = max(p1[1], p2[1], p3[1])

        triangle_pixels = set()

        # 对于每个像素点 (x, y) 在最小和最大坐标范围内
        for x in range(min_x, max_x + 1):
            for y in range(min_y, max_y + 1):
                # 判断当前像素点是否在三角形内部
                if self._point_in_triangle((x, y), p1, p2, p3):
                    triangle_pixels.add((x, y))

        self.pixels = triangle_pixels

    def find_pixels_crossproduct_vec(self, pixelized_img):
        i = self.valid_UV_index['vertex_{}'.format(self.vertices[0].ver_index)]
        j = self.valid_UV_index['vertex_{}'.format(self.vertices[1].ver_index)]
        k = self.valid_UV_index['vertex_{}'.format(self.vertices[2].ver_index)]
        p1 = (round(self.vertices[0].UVs[i][0] * 4096), 4096 - round(self.vertices[0].UVs[i][1] * 4096))
        p2 = (round(self.vertices[1].UVs[j][0] * 4096), 4096 - round(self.vertices[1].UVs[j][1] * 4096))
        p3 = (round(self.vertices[2].UVs[k][0] * 4096), 4096 - round(self.vertices[2].UVs[k][1] * 4096))

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
            pixel_instance = pixelized_img[i[0], i[1]]
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

    def determine_valid_UV_index(self):
        """ determine the distances between 3 vertices """
        for i in range(len(self.vertices[0].UVs)):
            for j in range(len(self.vertices[1].UVs)):
                for k in range(len(self.vertices[2].UVs)):
                    try:
                        ver1 = (self.vertices[0].UVs[i][0] * 4096, self.vertices[0].UVs[i][1] * 4096)
                    except IndexError:
                        continue
                    try:
                        ver2 = (self.vertices[1].UVs[j][0] * 4096, self.vertices[1].UVs[j][1] * 4096)
                    except IndexError:
                        continue
                    try:
                        ver3 = (self.vertices[2].UVs[k][0] * 4096, self.vertices[2].UVs[k][1] * 4096)
                    except IndexError:
                        continue

                    dis1 = math.sqrt((ver2[0] - ver1[0]) ** 2 + (ver2[1] - ver1[1]) ** 2)
                    dis2 = math.sqrt((ver3[0] - ver1[0]) ** 2 + (ver3[1] - ver1[1]) ** 2)
                    dis3 = math.sqrt((ver2[0] - ver3[0]) ** 2 + (ver2[1] - ver3[1]) ** 2)

                    if dis1 < 100 and dis2 < 100 and dis3 < 100:
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
            cls._instance = super().__new__(cls, *args, **kwargs)
        return cls._instance

    __slots__ = [
        'texture',          # TextureObj instance
        'filepath',         # filepath to the texture image
        'vertices_dict',    # dict format of all vertices
        'UVs_dict',         # dict format of all UV coordinates
        'edges_dict',       # dict format of all edges
        'faces_dict'        # dict format of all faces
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
                    line = line.strip()
                    elements = line.split()
                    vertex_indices = [int(x.split('/')[0]) for x in elements[1:]]
                    uv_indices = [int(x.split('/')[1]) for x in elements[1:]]
                    wvertices = []
                    for i in range(3):  # a new_face is always a triangle, therefore iterate 3 times.
                        ver = self.vertices_dict[vertex_indices[i]]
                        ver.ver_index_setter(vertex_indices[i])
                        ver.uv_index_setter(uv_indices[i])
                        ver.UVs_setter(self.UVs_dict[uv_indices[i]])
                        neighbors = [x for x in vertex_indices if x != vertex_indices[i]]
                        ver.neighbor_setter(neighbors)
                        wvertices.append(ver)
                        if face_index not in ver.faces:
                            ver.faces_setter(face_index)
                    face = WFace()
                    face.findex = face_index
                    face.vertices = wvertices
                    face.determine_valid_UV_index()

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
                    face.find_pixels_crossproduct_vec(self.texture.pixelated_img)
                    faces_dict[face_index] = face
                    face_index += 1

                line = f.readline()
        return faces_dict


class NewUVUnwrap:
    def __init__(self, wavefront_obj):
        self.wavefront_obj = wavefront_obj
        self.img = np.zeros((4096 + 2000, 4096 + 2000))


def get_vertices(index):
    ver = obj.vertices_dict[index]

    print(ver.UVs[0][0] * 4096, 4096 - ver.UVs[0][1] * 4096)


def get_edge(ver1, ver2):
    index = WEdge.existent["{},{}".format(ver1, ver2)]
    edge = obj.edges_dict[index]
    print(edge, edge.mid_point_UV)


def dfs_recursive(face: WFace):
    """ causing stack overflow """
    edge_1 = face.edges[0]
    edge_2 = face.edges[1]
    edge_3 = face.edges[2]

    if face.already_drawn:
        return

    # todo: draw new_face
    face.already_drawn = True

    for edge in face.edges:
        if len(edge.faces) == 2:
            dfs_recursive(edge.faces[0])
            dfs_recursive(edge.faces[1])
        else:
            continue
    return


def cal_trans_matrix(Ax1, Ay1, Ax2, Ay2, Bx1, By1, Bx2, By2):
    # 计算边A和边B的长度
    LA = np.sqrt((Ax2 - Ax1) ** 2 + (Ay2 - Ay1) ** 2)
    LB = np.sqrt((Bx2 - Bx1) ** 2 + (By2 - By1) ** 2)

    # 计算边A和边B的中点坐标
    Axm, Aym = (Ax1 + Ax2) / 2, (Ay1 + Ay2) / 2
    Bxm, Bym = (Bx1 + Bx2) / 2, (By1 + By2) / 2

    # 计算边A和边B的向量表示
    VA = np.array([Ax2 - Ax1, Ay2 - Ay1])
    VB = np.array([Bx2 - Bx1, By2 - By1])

    # 计算边A到边B的缩放比例
    scale = LB / LA
    if scale > 2:  # todo: delete after debug
        scale = 2
    S = np.array([[1 - scale, 0, 0],
                  [0, 1 - scale, 0],
                  [0, 0, 1]])

    # 计算边A和边B的旋转角度
    tmp = np.dot(VA, VB) / (LA * LB)
    if tmp > 1:
        tmp = 1
    elif tmp < -1:
        tmp = -1
    theta = np.arccos(tmp)

    # 计算边A到边B的旋转矩阵
    R = np.array([[np.cos(theta), -np.sin(theta)],
                  [np.sin(theta), np.cos(theta)]])

    # 计算边A到边B的平移矩阵
    T = np.array([[Bxm - Axm],
                  [Bym - Aym]])

    # 计算边A到边B的变换矩阵
    M = np.concatenate((np.concatenate((R, T), axis=1), np.array([[0, 0, 1]])), axis=0)
    if np.isnan(M).any():
        raise ("NaN detected")
    return S, M


def draw_face(new_face: WFace, UV_obj, init_M=None, ref_edge: WEdge = None, ref_face: WFace = None, ):
    """"""
    if not ref_face:
        ref_face = new_face

    if not init_M:
        # 计算边A和边B的向量表示
        vertex0 = ref_edge.vertices[0]
        vertex1 = ref_edge.vertices[1]

        ref_ver0_u, ref_ver0_v = vertex0.UVs[ref_face.valid_UV_index["vertex_{}".format(vertex0.ver_index)]]
        ref_ver1_u, ref_ver1_v = vertex1.UVs[ref_face.valid_UV_index["vertex_{}".format(vertex1.ver_index)]]

        new_ver0_u, new_ver0_v = vertex0.UVs[new_face.valid_UV_index["vertex_{}".format(vertex0.ver_index)]]
        new_ver1_u, new_ver1_v = vertex1.UVs[new_face.valid_UV_index["vertex_{}".format(vertex1.ver_index)]]

        S, M = cal_trans_matrix(ref_ver0_u, ref_ver0_v,
                                ref_ver1_u, ref_ver1_v,
                                new_ver0_u, new_ver0_v,
                                new_ver1_u, new_ver1_v)
    else:
        M = init_M[0]
        S = np.eye(3)

    ref_point_u = ref_edge.mid_point_UV['face_{}'.format(ref_face.findex)][0]
    ref_point_v = ref_edge.mid_point_UV['face_{}'.format(ref_face.findex)][1]

    ref_point = np.array([ref_point_u, ref_point_v, 0])

    for pixel in new_face.pixels:
        new_pixel = copy.copy(pixel)
        UV_list = list(new_pixel.UV)
        UV_list.append(0)
        UV_np = np.array(UV_list)
        new_UV_np = S.dot(ref_point) + (1 - S[0][0]) * UV_np
        new_UV_np = M.dot(new_UV_np)
        new_UV_list = new_UV_np.tolist()
        new_UV_list.pop()
        new_pixel.UV = tuple(new_UV_list)
        new_u_pixel_index = round(new_UV_list[0] * 4096)
        new_v_pixel_index = round(new_UV_list[1] * 4096)
        intensity = new_pixel.intensity
        UV_obj.img[new_u_pixel_index][new_v_pixel_index] = intensity

    # 更新ref_edge, ref_face


def dfs_iteration(new_face: WFace, ref_edge: WEdge, newUV, init_M):
    """

    :param new_face:
    :return:
    """
    draw_face(new_face, newUV, init_M, ref_edge)
    stack = [(new_face, ref_edge, None)]
    stack_len = 0
    while stack:
        new_face, ref_edge, ref_face = stack.pop()

        if not new_face.already_drawn:
            draw_face(new_face, newUV, ref_edge=ref_edge, ref_face=ref_face)
            new_face.already_drawn = True

        ref_face = new_face
        for edge in ref_face.edges:
            if len(edge.faces) == 2:
                for adjacent_face in edge.faces:
                    if not adjacent_face.already_drawn:
                        stack.append((adjacent_face, edge, ref_face))
        stack_len = max(stack_len, len(stack))

    return stack_len


def check_if_all_faces_drawn(obj: WavefrontObj):
    status = np.array([face.already_drawn for face in obj.faces_dict.values()], dtype=bool)
    return status


if __name__ == '__main__':
    obj = WavefrontObj(wavefront_filepath, texture_filepath)

    # Face drawn initialization
    new_face = obj.faces_dict[1]
    new_edge = new_face.edges[0]
    new_edge_mid = new_edge.mid_point_UV['face_1']

    ref_edge = WEdge()
    ref_edge.mid_point_UV = {"face_1": (0.1, 0.1)}
    ref_edge.length_uv = {0: new_edge.length_uv[1]}
    ref_edge.angle = {"face_1": new_edge.angle["face_1"]}
    ref_edge.vertices = new_edge.vertices
    ref_edge.eindex = 0
    init_M = np.array([[1, 0, -(new_edge_mid[0] - 0.5)],
                       [0, 1, -(new_edge_mid[1] - 0.5)],
                       [0, 0, 1]])

    # 实例化空白画板
    newUV = NewUVUnwrap(obj)

    stack_len = dfs_iteration(new_face, ref_edge, newUV, [init_M])
    status = check_if_all_faces_drawn(obj)
    cv2.imshow('1', newUV.img)
    cv2.waitKey(0)
    number_of_not_drawn_face = np.count_nonzero(status == False)

    plt.figure(dpi=1200)
    plt.imshow(newUV.img)
    plt.savefig('test.jpg')
