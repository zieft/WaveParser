wavefront_filepath = r'C:\Users\zieft\Desktop\testdataset\smallTexture\texturedMesh.obj'
texture_filepath = r'C:\Users\zieft\Desktop\testdataset\smallTexture\texture_1001.png'
import numpy as np
import cv2


class TPixel:
    def __init__(self, intensity, uv):
        self.intensity = intensity
        self.UV = uv
        self.uv_index = None
        self.coor = None

    def __repr__(self):
        return str(self.intensity)

    def __str__(self):
        return str(self.intensity)


class TFace:
    def __init__(self):
        self.edge = []


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
                if self.img[i][j] == 0:
                    img[i][j] = 0
                else:
                    img[i][j] = TPixel(
                        intensity=self.img[i][j],
                        uv=(u, v)
                    )
        return img


class WVertex:
    def __init__(self, coor):
        self.coor = coor  # tuple
        self.vindex = 0
        self.UVs = []  # list of  uv indices, 一个顶点有可能对应不同的uv坐标
        self.neighbors = []  # list of WVertex objects.
        self.faces = []  # list of WFace objects. 表示此顶点属于哪些面

    def __str__(self):
        return '顶点：' + str(self.vindex)

    def __repr__(self):
        return '顶点：' + str(self.vindex)

    def index_setter(self, index):
        self.vindex = index

    def UVs_setter(self, UV):
        if UV not in self.UVs:
            self.UVs.append(UV)

    def neighbor_setter(self, neighbors):
        self.neighbors = list(self.neighbors + neighbors)

    def faces_setter(self, face):
        self.faces.append(face)


class WFace:
    def __init__(self):
        """
        vertices: list of 3 WVertex objects.
        """
        self.findex = 0
        self.vertieces = []
        # self.texture_uv = [(), ()]  不需要额外记录uv，因为vertex自带uv

    def __str__(self):
        return '面:' + str(self.findex) + '，顶点为：' + str(self.vertieces)


class WavefrontObj:
    def __init__(self, obj_filepath):
        self.filepath = obj_filepath
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
                        ver.index_setter(vertex_indices[i])
                        ver.UVs_setter(self.UVs_dict[uv_indices[i]])
                        neighbors = [x for x in vertex_indices if x != vertex_indices[i]]
                        ver.neighbor_setter(neighbors)
                        wvertices.append(ver)
                        if face_index not in ver.faces:
                            ver.faces_setter(face_index)
                    face = WFace()
                    face.findex = face_index
                    face.vertieces = wvertices

                    faces_dict[face_index] = face
                    face_index += 1

                line = f.readline()
        return faces_dict


# import pywavefront
#
# scene = pywavefront.Wavefront(
#     wavefront_filepath,
#     strict=False,
#     encoding="iso-8859-1",
#     parse=False,
# )
# scene.parse()
#
# vertices_dict = dict(enumerate(scene.vertices, 1))
# UVs_dict = dict(enumerate(scene.parser.tex_coords, 1))
# faces_dict = {}
# for i in vertices_dict:
#     vertices_dict[i] = WVertex(vertices_dict[i])
# with open(wavefront_filepath, 'r') as f:
#     line = f.readline()
#     face_index = 1
#     while line:
#         if line.startswith('f'):
#             line = line.strip()
#             elements = line.split()
#             vertex_indices = [int(x.split('/')[0]) for x in elements[1:]]
#             uv_indices = [int(x.split('/')[1]) for x in elements[1:]]
#             wvertices = []
#             for i in range(3):
#                 ver = WVertex()
#                 ver.index_setter(vertex_indices[i])
#                 ver.coor_setter(vertices_dict[vertex_indices[i]])
#                 ver.UVs_setter(UVs_dict[uv_indices[i]])
#                 neighbors = [x for x in vertex_indices if x != vertex_indices[i]]
#                 ver.neighbor_setter(neighbors)
#                 wvertices.append(ver)
#                 if face_index not in ver.faces:
#                     ver.faces_setter(face_index)
#             face = WFace()
#             face.vertieces = wvertices
#
#             faces_dict[face_index] = face
#             face_index += 1
#
#         line = f.readline()
#
if __name__ == '__main__':
    obj = WavefrontObj(wavefront_filepath)
    txt = TextrueObj(texture_filepath)
