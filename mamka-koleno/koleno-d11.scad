include <BOSL/constants.scad>
include <BOSL/transforms.scad>
use <BOSL/shapes.scad>

xrot(90) difference() { 
    union() {
        upcube([14,14,30]);
        cuboid([23, 14, 14], align=V_TOP+V_RIGHT);
    }
    zmove(2) cylinder(d=11, h=30);
    zmove(7) yrot(90) zmove(2) cylinder(d=11, h=30);
}
