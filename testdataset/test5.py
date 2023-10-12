import copy
import cv2
import numpy as np

with open('testdataset/DoNotCommit/mesh_postprocessed.obj', 'r') as obj_file:
    lines = obj_file.readlines()

# 1. 读取图片
ori_img = cv2.imread('testdataset/DoNotCommit/texture_1001.png')

# 2. 计算每个像素点的亮度 (使用公式: 0.299*R + 0.587*G + 0.114*B)
brightness = 0.299 * ori_img[:, :, 2] + 0.587 * ori_img[:, :, 1] + 0.114 * ori_img[:, :, 0]

thresholds = [65, 115, 125, 55, 135]
for threshold in thresholds:
    img = copy.copy(ori_img)
    # 3. 找出所有亮度超过threshold的像素点
    coords = np.column_stack(np.where(brightness > threshold))

    # 4. 将这些像素涂成红色
    img[coords[:, 0], coords[:, 1]] = [0, 0, 255]  # [B, G, R] format for OpenCV

    # 5. 保存为新的图片
    cv2.imwrite(f'testdataset/DoNotCommit/intesity_{threshold}.png', img)

    bright_coords_list = coords.tolist()
    coords_set = set(map(tuple, coords))


    vt_list = []  # List to hold all vt coordinates
    v_list = []  # List to hold all v coordinates
    affected_vt = set()  # Set to hold vt indices that fall in the red area
    affected_v = set()  # Set to hold v indices associated with affected vt

    # 解析.obj文件
    for line in lines:
        parts = line.strip().split()
        if parts[0] == 'vt':
            vt_list.append((float(parts[1]), float(parts[2])))
        elif parts[0] == 'v':
            v_list.append((float(parts[1]), float(parts[2]), float(parts[3])))
        elif parts[0] == 'f':
            for part in parts[1:]:
                vertex, vt, _ = map(int, part.split('/'))
                uv_coords = vt_list[vt - 1]
                u = round(uv_coords[0] * 4096)
                v = round(uv_coords[1] * 4096)
                if (4096 - v, u) in coords_set:
                    affected_vt.add(vt)
                    affected_v.add(vertex)


    mod_img = cv2.imread(f'testdataset/DoNotCommit/intesity_{threshold}.png')
    for part in affected_v:
        for idx, vt in enumerate(affected_vt):
            uv_coords = vt_list[vt - 1]
            u = int(uv_coords[0] * 4096)
            v = int(uv_coords[1] * 4096)
            mod_img[4096 - v, u] = [0, 255, 0]  # Set to green

    # 5. Save the modified image
    cv2.imwrite(f'testdataset/DoNotCommit/modified_{threshold}.png', mod_img)


## 以上代码可以在WaveParser环境下运行，以下只能在blender里运行
import math, mathutils
def create_cone(location, direction):
    # 创建一个锥体
    bpy.ops.mesh.primitive_cone_add(vertices=32, radius1=0.0001, depth=0.01, location=location)
    cone = bpy.context.active_object
    # 旋转锥体，使其指向指定的方向
    rotation_diff = direction.rotation_difference(mathutils.Vector((0, 0, 1)))
    cone.rotation_euler = rotation_diff.to_euler()
    return cone


obj = D.objects['texturedMesh']
m = obj.matrix_world
for index in result:
    v = obj.data.vertices[index]
    create_cone(v.co@m, -v.normal@m)
