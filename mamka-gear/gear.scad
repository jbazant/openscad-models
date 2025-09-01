include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

$fn=50;

difference() {
    union() {
        cylinder(h=6, d=3);
        cylinder(h=1.8, d=4.8);
        for (zr=[36 : 36 : 180]) {
            zrot(zr) cuboid([.6, 4.8, 6], align=V_UP, edges=EDGES_Z_ALL, fillet=.3);
        }
    }
    zmove(-1) cylinder(h=8, d=2);
}