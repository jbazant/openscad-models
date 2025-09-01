include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

plank_w=28;
torch_x=39;
torch_x_outer=torch_x+6;
torch_y=32;
torch_y_outer=torch_y+6;
h=50;

module plank_holder() {
    color("green") xrot(-1) ymove(-plank_w/2) cuboid([torch_x_outer, 6, h], align=V_TOP+V_FRONT, chamfer=2);
    ymove(plank_w/2) cuboid([torch_x_outer, 6, h], align=V_TOP+V_BACK, chamfer=2);
    cuboid([torch_x_outer, plank_w+12, 6], align=V_TOP, chamfer=2);
}

module flash_holder() {
    color("blue") ymove((plank_w+torch_y_outer)/2+3) difference() {
    
        ymove(-1.5) hull() {
            cuboid([torch_x_outer, torch_y_outer+3, 6], align=V_TOP, chamfer=2);
            ymove(-2.5) cuboid([torch_x_outer, torch_y_outer-2, h], align=V_TOP, chamfer=2);
        }
        hull() {
            cuboid([torch_x, torch_y, 6], chamfer=5, align=V_TOP,edges=EDGES_Z_ALL);
            ymove(-2.5) cuboid([torch_x, torch_y-5, h-2], chamfer=5, align=V_TOP);  
        }
    }
}

module mouse_ear(x, y) {
    move(x=x, y=y) cylinder(r=6, h=.2);
}

plank_holder();
flash_holder();

mouse_ear(torch_x_outer/2+2, -plank_w/2-6);
mouse_ear(-torch_x_outer/2-2, -plank_w/2-6);
mouse_ear(torch_x_outer/2+2, plank_w/2+torch_y_outer+4);
mouse_ear(-torch_x_outer/2-2, plank_w/2+torch_y_outer+4);