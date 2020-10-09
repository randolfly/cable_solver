def init_cables():
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
    
def get_cables_length():
    # get all cable length data
    init_cables()
    a_length_list = [a1.location-A.location, a2.location-A.location,a3.location-A.location]
    b_length_list = [b1.location-B.location, b2.location-B.location]
    c_length_list = [c1.location-C.location]
    return [a_length_list, b_length_list, c_length_list]