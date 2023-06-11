wavefront_filepath = r'C:\Users\zieft\Desktop\testdataset\smallTexture\texturedMesh.obj'
texture_filepath = r'C:\Users\zieft\Desktop\testdataset\smallTexture\texture_1001.png'
import numpy as np
import cv2


class TPixel:
    def __init__(self, intensity, uv):
        self.intensity = intensity
        self.UV = uv

        self.coor = None
        self.face = None

    def __repr__(self):
        return str(self.intensity)

    def __str__(self):
        return str(self.intensity)


class TextrueObj:
    def __init__(self, filepath):
        self.filepath = filepath
        self.img = self.img_read()
        self.pixelized_img = self.init_pixels()

    def img_read(self):
        img = cv2.imread(self.filepath, cv2.IMREAD_GRAYSCALE)
        return img

    def init_pixels(self):
        img = np.zeros((4096, 4096), dtype='O')
        for i in range(img.shape[0]):
            for j in range(img.shape[1]):
                u = j / self.img.shape[0]
                v = i / self.img.shape[1]
                pix = TPixel(
                    intensity=self.img[i][j],
                    uv=(u, v)
                )
                pix.uv_pixel_index = (i, j)
                img[i][j] = pix
        return img


class WVertex:
    def __init__(self, coor):
        self.coor = coor  # tuple
        self.ver_index = 0
        self.uv_index = 0  # blender里的顶点索引，实际上为uv_index - 1 （blender索引从0起始）
        self.UVs = []  # list of  uv indices, 一个顶点有可能对应不同的uv坐标
        self.neighbors = []  # list of WVertex objects.
        self.faces = []  # list of WFace objects. 表示此顶点属于哪些面

    def __str__(self):
        return '顶点：' + str(self.ver_index)

    def __repr__(self):
        return '顶点：' + str(self.ver_index)

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


class WFace:
    def __init__(self):
        """
        vertices: list of 3 WVertex objects.
        """
        self.findex = 0
        self.vertices = None
        self.area = None
        self.pixels = None
        self.mapping_matrix = None
        # self.texture_uv = [(), ()]  不需要额外记录uv，因为vertex自带uv

    def __str__(self):
        return '面:' + str(self.findex) + '，顶点为：' + str(self.vertices)

    def cal_area(self, texture_shape):
        p1 = tuple(int(round(x * texture_shape[0])) for x in self.vertices[0].UVs[0])
        p2 = tuple(int(round(x * texture_shape[0])) for x in self.vertices[1].UVs[0])
        p3 = tuple(int(round(x * texture_shape[0])) for x in self.vertices[2].UVs[0])

        vertices = sorted([p1, p2, p3], key=lambda p: p[1])

        # 提取三个点的坐标和纵坐标范围
        y_min = vertices[0][1]
        y_max = vertices[2][1]

        x1, y1 = vertices[0]
        x2, y2 = vertices[1]
        x3, y3 = vertices[2]

        self.area = 0.5 * abs((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)))

    def find_pixels(self, texture_shape):
        # 对三个点按照纵坐标从小到大排序
        p1 = tuple(int(round(x * texture_shape[0])) for x in self.vertices[0].UVs[0])
        p2 = tuple(int(round(x * texture_shape[0])) for x in self.vertices[1].UVs[0])
        p3 = tuple(int(round(x * texture_shape[0])) for x in self.vertices[2].UVs[0])

        vertices = sorted([p1, p2, p3], key=lambda p: p[1])

        # 提取三个点的坐标和纵坐标范围
        y_min = vertices[0][1]
        y_max = vertices[2][1]

        x1, y1 = vertices[0]
        x2, y2 = vertices[1]
        x3, y3 = vertices[2]

        # 计算斜率的倒数
        try:
            m12 = (x2 - x1) / (y2 - y1)
        except ZeroDivisionError:
            m12 = 99999999999999999
        try:
            m13 = (x3 - x1) / (y3 - y1)
        except ZeroDivisionError:
            m13 = 99999999999999999
        try:
            m23 = (x3 - x2) / (y3 - y2)
        except ZeroDivisionError:
            m23 = 99999999999999999

        # 初始化结果集合
        pixels = set()

        # 扫描线算法
        for y in range(y_min, y_max + 1):
            # 判断是否在三角形内部的条件
            if y1 <= y <= y2:
                x_left = x1 + (y - y1) * m12
            else:
                x_left = x1 + (y - y1) * m13

            if y2 <= y <= y3:
                x_right = x2 + (y - y2) * m23
            else:
                x_right = x1 + (y - y1) * m13
            try:
                x_left = int(x_left)
                x_right = int(x_right)
            except ValueError:
                continue

            # 将当前扫描线上的像素坐标加入结果集合
            for x in range(x_left, x_right + 1):
                pixels.add((x, y))

        self.pixels = pixels

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
        p1 = (round(self.vertices[0].UVs[0][0] * 4096), round(self.vertices[0].UVs[0][1] * 4096))
        p2 = (round(self.vertices[1].UVs[0][0] * 4096), round(self.vertices[1].UVs[0][1] * 4096))
        p3 = (round(self.vertices[2].UVs[0][0] * 4096), round(self.vertices[2].UVs[0][1] * 4096))
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
        p1 = (round(self.vertices[0].UVs[0][0] * 4096), 4096 - round(self.vertices[0].UVs[0][1] * 4096))
        p2 = (round(self.vertices[1].UVs[0][0] * 4096), 4096 - round(self.vertices[1].UVs[0][1] * 4096))
        p3 = (round(self.vertices[2].UVs[0][0] * 4096), 4096 - round(self.vertices[2].UVs[0][1] * 4096))

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

    def determine_mapping_matrix_3d_to_2d(self):
        # 三维空间中三个点的坐标
        A = np.array(self.vertices[0].coor)
        B = np.array(self.vertices[1].coor)
        C = np.array(self.vertices[2].coor)

        # 构造系数矩阵
        coeff_matrix = np.vstack((A, B))
        coeff_matrix = np.vstack((coeff_matrix, C))

        # 二维平面上的映射点坐标
        P = self.vertices[0].UVs[0]
        Q = self.vertices[1].UVs[0]
        W = self.vertices[2].UVs[0]

        # 构造常数矩阵
        const_matrix = np.vstack((P, Q))
        const_matrix = np.vstack((const_matrix, W))

        # 求解矩阵
        self.mapping_matrix = np.linalg.solve(coeff_matrix, const_matrix)

    def determine_mapping_matrix_2d_to_3d(self):
        # 三维空间中三个点的坐标
        A = np.array(self.vertices[0].coor)
        B = np.array(self.vertices[1].coor)
        C = np.array(self.vertices[2].coor)

        # 构造常数矩阵
        const_matrix = np.vstack((A, B))
        const_matrix = np.vstack((const_matrix, C))

        # 二维平面上的映射点坐标
        P = list(self.vertices[0].UVs[0])
        Q = list(self.vertices[1].UVs[0])
        W = list(self.vertices[2].UVs[0])
        P += [1]
        Q += [1]
        W += [1]

        # 构造系数矩阵
        coeff_matrix = np.vstack((P, Q))
        coeff_matrix = np.vstack((coeff_matrix, W))

        # 求解矩阵
        self.mapping_matrix = np.linalg.solve(coeff_matrix, const_matrix)

class WavefrontObj:
    def __init__(self, wavefront_path, texture_path):
        self.texture = TextrueObj(texture_path)
        self.filepath = wavefront_path
        self.vertices_dict = self.parse_vertices_dict()
        self.UVs_dict = self.parse_uvs_dict()
        self.faces_dict = self.parse_faces()

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

    def parse_faces(self):
        with open(self.filepath, 'r') as f:
            line = f.readline()
            face_index = 1
            faces_dict = {}
            while line:
                if line.startswith('f'):
                    line = line.strip()
                    elements = line.split()
                    vertex_indices = [int(x.split('/')[0]) for x in elements[1:]]
                    uv_indices = [int(x.split('/')[1]) for x in elements[1:]]
                    wvertices = []
                    for i in range(3):  # a face is always a triangle, therefore iterate 3 times.
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
                    texture_shape = self.texture.img.shape
                    face.determine_mapping_matrix_2d_to_3d()
                    face.cal_area(texture_shape)
                    face.find_pixels_crossproduct_vec(self.texture.pixelized_img)
                    faces_dict[face_index] = face
                    face_index += 1

                line = f.readline()
        return faces_dict


if __name__ == '__main__':
    obj = WavefrontObj(wavefront_filepath, texture_filepath)
