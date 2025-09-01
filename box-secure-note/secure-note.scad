include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>
use <jb-scad/skadis.scad>

module box() {
    difference() {
        cuboid([50, 10, 180], chamfer=3, align=V_UP);
        zmove(5) cuboid([43, 1, 180], align=V_UP);
        zmove(180-15) cuboid([20, 5, 60], edges=EDGES_Y_ALL, fillet=10, align=V_BACK+V_UP);
        move(y=5, z=90) trezor_logo();
        move(y=-5, z=90) trezor_logo();
    }

    move(y=5, z=150) xrot(90) skadis_hook_triple();
}

module trezor_logo() {
    xrot(90) scale([5,5,1]) move(x=-6.7, y=-6.7, z=-.5) linear_extrude(1) import("./hollow-app-logo.svg");
}

box();