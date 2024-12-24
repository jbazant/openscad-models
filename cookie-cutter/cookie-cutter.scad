include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

$fn=40;

d=1.6;

module simple_house() {
    difference() {
        union() {
            hull() {
                ymove(22.5) zrot(45)cuboid([37, 37, 14], fillet = 3, edges = EDGES_Z_ALL, align = V_UP);
                cuboid([50, 50, 14], fillet = 3, edges = EDGES_Z_ALL, align = V_UP);

                ymove(22) zrot(45) cuboid([37 - d / 2, 37 - d / 2, 16], fillet = 3, edges = EDGES_Z_ALL, align = V_UP);
                cuboid([50 - d / 2, 50 - d / 2, 16], fillet = 3, edges = EDGES_Z_ALL, align = V_UP);
            }

            cuboid([58, 58, 2], fillet = 5, edges = EDGES_Z_ALL, align = V_UP);
            ymove(22.5) zrot(45) cuboid([46, 46, 2], fillet = 5, edges = EDGES_Z_ALL, align = V_UP);
        }
        union() {
            ymove(22.5 - d / 4) zrot(45)
            cuboid([37 - d, 37 - d, 20], fillet = 3 - d / 2, edges = EDGES_Z_ALL, align = V_UP);
            cuboid([50 - d, 50 - d, 20], fillet = 3 - d / 2, edges = EDGES_Z_ALL, align = V_UP);
        }
    }
}

module simple_circle() {
    difference() {
        union() {
            hull() {
                cylinder(d = 40 + 1.6, h = 16);
                cylinder(d = 40 + 3.2, h = 14);
            }
            cylinder(d = 50, h = 2);
        }
        cylinder(d = 40, h = 17);
    }
}

simple_house();
simple_circle();
