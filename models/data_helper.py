import numpy as np
import random
import bpy


def init_cables():
    global A, B, C, a1, a2, a3, b1, b2, b3, c1, c2, c3, up_circle, up_collection
    # init the objects to validate algorithm
    A = bpy.data.objects['A']
    B = bpy.data.objects['B']
    C = bpy.data.objects['C']
    a1 = bpy.data.objects['a1']
    a2 = bpy.data.objects['a2']
    a3 = bpy.data.objects['a3']
    b1 = bpy.data.objects['b1']
    b2 = bpy.data.objects['b2']
    c1 = bpy.data.objects['c1']
    up_collection = bpy.data.collections['up_circle']
    up_circle = bpy.data.objects['up_circle']


def get_cables_length():
    # get all cable length data
    a_length_list = [a1.location-A.location,
                     a2.location-A.location, a3.location-A.location]
    b_length_list = [b1.location-B.location, b2.location-B.location]
    c_length_list = [c1.location-C.location]
    a_length = np.linalg.norm(a_length_list, 2, axis=1)
    b_length = np.linalg.norm(a_length_list, 2, axis=1)
    c_length = np.linalg.norm(a_length_list, 2, axis=1)
    return [a_length, b_length, c_length]


def get_locations():
    # get all locations of each point
    A_loc = [a1.location, a2.location, a3.location]
    B_loc = [b1.location, b2.location]
    C_loc = [c1.location]
    return [A_loc, B_loc, C_loc]


# 选择collection_object
def select_collection(collection_object):
    bpy.ops.object.select_same_collection(collection=collection_object.name)


# 随机分配collection_object 位置
def random_collection_position(collection_object):
    # 清除所有选中的物体
    if len(bpy.context.selected_objects) != 0:
        bpy.ops.object.select_all()
    # 选中所有collection
    select_collection(collection_object)
    # 随机分配位置
    # 生成旋转轴随机数
    orient_rot = ['X', 'Y', 'Z'][random.randint(0, 2)]
    # 旋转
    bpy.ops.transform.rotate(value=random.random()/5.0, orient_axis=orient_rot, orient_type='VIEW', orient_matrix=((-0.0598548, 0.998115, -0.0136004), (-0.388781, -0.010761, 0.921267), (0.919384, 0.0604299, 0.388692)),
                             orient_matrix_type='VIEW', mirror=True, use_proportional_edit=False, proportional_edit_falloff='SMOOTH', proportional_size=1, use_proportional_connected=False, use_proportional_projected=False)

    # 平移
    axis_tran = [(random.random()-0.5)/10.0, (random.random()-0.5)/10.0,
                 (random.random()-0.5)/10.0]
    axis_tran = tuple(list(axis_tran))
    bpy.ops.transform.translate(value=axis_tran, orient_type='GLOBAL', orient_matrix=((1, 0, 0), (0, 1, 0), (0, 0, 1)), orient_matrix_type='GLOBAL', mirror=True,
                                use_proportional_edit=False, proportional_edit_falloff='SMOOTH', proportional_size=1, use_proportional_connected=False, use_proportional_projected=False)

    # 清除选择的物体
    bpy.ops.object.select_all()


def reset_object(bpy_object, location, rotation=[0, 0, 0]):
    bpy_object.location = location
    bpy_object.rotation_euler = rotation


def reset_pos():
    reset_object(A, [0, 1, 1.5])
    reset_object(B, [-0.866025, -0.5, 1.5])
    reset_object(C, [0.866025, -0.5, 1.5])
    reset_object(up_circle, [0, 0, 1.5])
    

# 运行run_number次算法


def validate_algorithm(run_number=20):
    init_cables()
    reset_pos()
    for idx in range(run_number):
        if(idx%10==0):
            reset_pos()
        random_collection_position(up_collection)
        length_list = get_cables_length()
        location_list = get_locations()

        with open('pos_data.txt', 'a') as f:
            for length in length_list[0]:
                f.write(str(length)+',')
            f.write(';')
            for pos in location_list[0]:
                f.write(str(list(pos))+',')
            f.write('\n')

validate_algorithm(10)
