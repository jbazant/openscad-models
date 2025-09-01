include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

w=81;
h1=2.5;
h2=28;

$fn=$preview ? 10 : 30;

module table_stopper(l) {
    difference() {
        cuboid([w, l+10, h2], align=V_TOP+V_BACK, edges=EDGES_ALL-EDGES_BOTTOM, fillet=3);
        difference() {
            zmove(h1) cuboid([w, 10, h2-h1], align=V_TOP+V_BACK, edges=EDGES_Z_BK+EDGES_TOP-EDGE_TOP_FR, fillet=3);
            ymove(2) cuboid([w-10, 3, 6], align=V_TOP+V_BACK, edges=EDGES_Z_ALL, fillet=1);
        }
        ymove(-(w/2)+14) cylinder(h=h2/2, d=w-10);
        //ymove(l/2+10) cylinder(h=h2-h1, d=l-10);
    }
   
}

//table_stopper(55);
table_stopper(57);