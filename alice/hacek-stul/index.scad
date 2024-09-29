include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>



module hook() {
    cuboid([4, 13, 4], chamfer=1, p1=[0, 0, 0]);
    cuboid([4, 6, 9], chamfer=1, p1=[0, 7, 0]);
}

yrot(-90) {
    hook();
    ymove(33) hook();
    cuboid([7, 33+13, 4], chamfer=1, p1=[0, 0, 5]);


    translate([0, 35, 10]) for (rx=[20 : -10 : -80]) {
         hull() {
            xrot(rx) cuboid([7, 4, 4], chamfer=1, p1=[0, -10, 0]);
            xrot(rx + 10) cuboid([7, 4, 4], chamfer=1, p1=[0, -10, 0]);
         }
    }

    move(x=0, y=27, z=8) xrot(90) hull() {
        right_triangle([7, 7, 7], orient=ORIENT_X);
        xmove(1) right_triangle([5, 8, 8], orient=ORIENT_X);
    }
}