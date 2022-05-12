from ovito.io import import_file
#from ovito.modifiers import md
import ovito.vis as vis
import numpy as np
import sys

T = sys.argv[1]
file = "../dump/dump_" + T + ".eim"
pipeline = import_file(file)
pipeline.add_to_scene()

# def mod_color_radius(frame, data):
#     radius_property = data.particles_.create_property("Radius")
#     color_property = data.particles_.create_property("Color")
#     type_property = data.particles_.create_property("Particle type")
#     for i in range(len(radius_property)):
#         if type_property.array[i] == 1:
#             color_property.marray[i] = (112/250, 112/250, 112/250)
#         else:
#             color_property.marray[i] = (0/250, 0/250, 112/250)
#         radius_property.marray[i] = 0.4

# pipeline.modifiers.append(md.PythonScriptModifier(function = mod_color_radius))

data = pipeline.compute()

wall_x = data.cell[0][0]
wall_y = data.cell[1][1]
wall_z = data.cell[2][2]

vp = vis.Viewport()
vp.type = vis.Viewport.Type.Perspective

fi = 60 
center = np.array([wall_x/2, wall_y/2, wall_z/2])
radius = (wall_x/2+wall_y/2*3**0.5)*1.1
phi = np.pi * fi / 180
direction = np.array([np.cos(phi), np.sin(phi), 0])

vp.camera_pos = tuple(center+direction*radius)
vp.camera_dir = tuple(-direction)
vp.fov = np.radians(60.0)
vp.render_image(size=(400,400), filename="../png/image_"+T+"_"+str(fi)+".png", renderer=vis.TachyonRenderer())
