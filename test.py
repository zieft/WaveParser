import cv2
import numpy as np
import pandas as pd
from PIL import ImageDraw
import matplotlib.pyplot as plt


def parse_wavefront_obj(file_path):
    vertices = []
    tex_coords = []
    faces = []

    with open(file_path, 'r') as file:
        for line in file:
            if line.startswith('v '):
                vertex = line.strip().split()[1:]
                vertices.append(vertex)
            elif line.startswith('vt '):
                tex_coord = line.strip().split()[1:]
                tex_coords.append(tex_coord)
            elif line.startswith('f '):
                face = line.strip().split()[1:]
                faces.append(face)

    df_vertices = pd.DataFrame(vertices, columns=['X', 'Y', 'Z'], index=range(1, len(vertices) + 1))
    df_tex_coords = pd.DataFrame(tex_coords, columns=['U', 'V'], index=range(1, len(tex_coords) + 1))
    df_faces = pd.DataFrame(faces, columns=['Vertex1', 'Vertex2', 'Vertex3'], index=range(1, len(faces) + 1))

    return df_vertices, df_tex_coords, df_faces



vertices, tex_coords, faces = parse_wavefront_obj(r'C:\Users\zieft\Desktop\smallTexture\texturedMesh.obj')


def replace_indices_with_coordinates(faces, vertices, tex_coords):
    # 创建新的DataFrame来存储替换后的数据
    vertex_1 = pd.DataFrame()
    vertex_2 = pd.DataFrame()
    vertex_3 = pd.DataFrame()
    texture_1 = pd.DataFrame()
    texture_2 = pd.DataFrame()
    texture_3 = pd.DataFrame()

    # 替换顶点坐标
    vertex_1['X'] = vertices['X'].astype(float).reset_index(drop=True)[
        faces['Vertex1'].str.split('/').str[0].astype(int) - 1]
    vertex_1['Y'] = vertices['Y'].astype(float).reset_index(drop=True)[
        faces['Vertex1'].str.split('/').str[0].astype(int) - 1]
    vertex_1['Z'] = vertices['Z'].astype(float).reset_index(drop=True)[
        faces['Vertex1'].str.split('/').str[0].astype(int) - 1]

    vertex_2['X'] = vertices['X'].astype(float).reset_index(drop=True)[
        faces['Vertex2'].str.split('/').str[0].astype(int) - 1]
    vertex_2['Y'] = vertices['Y'].astype(float).reset_index(drop=True)[
        faces['Vertex2'].str.split('/').str[0].astype(int) - 1]
    vertex_2['Z'] = vertices['Z'].astype(float).reset_index(drop=True)[
        faces['Vertex2'].str.split('/').str[0].astype(int) - 1]

    vertex_3['X'] = vertices['X'].astype(float).reset_index(drop=True)[
        faces['Vertex3'].str.split('/').str[0].astype(int) - 1]
    vertex_3['Y'] = vertices['Y'].astype(float).reset_index(drop=True)[
        faces['Vertex3'].str.split('/').str[0].astype(int) - 1]
    vertex_3['Z'] = vertices['Z'].astype(float).reset_index(drop=True)[
        faces['Vertex3'].str.split('/').str[0].astype(int) - 1]

    # 替换纹理坐标
    texture_1['U'] = tex_coords['U'].astype(float).reset_index(drop=True)[
        faces['Vertex1'].str.split('/').str[1].astype(int) - 1]
    texture_1['V'] = tex_coords['V'].astype(float).reset_index(drop=True)[
        faces['Vertex1'].str.split('/').str[1].astype(int) - 1]

    texture_2['U'] = tex_coords['U'].astype(float).reset_index(drop=True)[
        faces['Vertex2'].str.split('/').str[1].astype(int) - 1]
    texture_2['V'] = tex_coords['V'].astype(float).reset_index(drop=True)[
        faces['Vertex2'].str.split('/').str[1].astype(int) - 1]

    texture_3['3'] = tex_coords['U'].astype(float).reset_index(drop=True)[
        faces['Vertex3'].str.split('/').str[1].astype(int) - 1]
    texture_3['3'] = tex_coords['V'].astype(float).reset_index(drop=True)[
        faces['Vertex3'].str.split('/').str[1].astype(int) - 1]

    return vertex_1, vertex_2, vertex_3, texture_1, texture_2, texture_3



vertex_1, vertex_2, vertex_3, texture_1, texture_2, texture_3 = replace_indices_with_coordinates(faces, vertices,
                                                                                                 tex_coords)

P1 = faces['Vertex1'].str.split('/').str[1].astype(int)
P2 = faces['Vertex2'].str.split('/').str[1].astype(int)
P3 = faces['Vertex3'].str.split('/').str[1].astype(int)

im = cv2.imread(r'C:\Users\zieft\Desktop\smallTexture\texture_1001.png')


def draw_triangle(im, p1, p2, p3):
    # 绘制三角形
    cv2.line(im, p1, p2, (0, 255, 0), 1)
    cv2.line(im, p2, p3, (0, 255, 0), 1)
    cv2.line(im, p3, p1, (0, 255, 0), 1)

    return im


# p1 = (int(float(tex_coords.loc[1].U) * 4096), int(float(tex_coords.loc[1].V) * 4096))
# p2 = (int(float(tex_coords.loc[2].U) * 4096), int(float(tex_coords.loc[2].V) * 4096))
# p3 = (int(float(tex_coords.loc[3].U) * 4096), int(float(tex_coords.loc[3].V) * 4096))
# im = draw_triangle(im, p1, p2, p3)
#


for i, j, k in zip(P1, P2, P3):
    p1 = (int(float(tex_coords.loc[i].U) * 4096), int((1-float(tex_coords.loc[i].V)) * 4096))
    p2 = (int(float(tex_coords.loc[j].U) * 4096), int((1-float(tex_coords.loc[j].V)) * 4096))
    p3 = (int(float(tex_coords.loc[k].U) * 4096), int((1-float(tex_coords.loc[k].V)) * 4096))

    im = draw_triangle(im, p1, p2, p3)

plt.imshow(im)
plt.show()
cv2.imwrite("path/to/image.png", im)
