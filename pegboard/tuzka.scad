include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
include <jb-scad/skadis.scad>

a=12.5;
b=8;
c=SKADIS_HOLES_SPACING_X+SKADIS_HOOK_HEIGHT+2;

module skadis_hooks() {
    xrot(90) {
        skadis_hook_single();
        ymove(SKADIS_HOLES_SPACING_X) skadis_hook_single();
    }
}

skadis_hooks();
difference() {
    cuboid([ a+4, b+4, c+2], align=V_FRONT+V_TOP, chamfer=1, edges=EDGES_ALL-EDGES_BACK);
    move(y=-2, z=2) cuboid([ a, b, c], align=V_FRONT+V_TOP);
    hull() {
        move(y=-2, z=c) cuboid([ a, b, 1], align=V_FRONT+V_TOP);
        move(y=-1, z=c+2) cuboid([ a+2, b+2, 1], align=V_FRONT+V_TOP);
    }
}