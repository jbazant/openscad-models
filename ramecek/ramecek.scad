include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>


module frame() {
    union() {
        for(rz=[90 : 90 : 360]) zrot(rz) {
        ymove(85.1) cuboid([210,19.8,10], edges=EDGES_TOP, chamfer=4, align=V_TOP+V_BACK);
        }
        difference() {
            upcube([210, 210, 1.2]);
            cuboid([150, 150, 10], fillet=5, edges=EDGES_Z_ALL);
        }
    }
}

module hook() {
    union() {
        for (tx=[-5 : 2.5 : 5]) {
            xmove(tx) zrot(45) upcube([5, 5, 4]);
        }
        move(y=2.5, z=1.2) upcube([17, 5, 2.8]);
        ymove(-2.5) upcube([17, 5, 4]);
    }
}

difference() {
    frame();
    ymove(95) hook();
}