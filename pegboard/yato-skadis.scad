include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>
include <jb-scad/skadis.scad>

r_inner=7.2;
r_outer=r_inner+2;
h_inner1=58.2;
h_inner2=h_inner1-21;
h_outer=h_inner1+2;

$fn=50;

module mass() {
    hull() {
        cuboid(
            [2*r_outer,1.6*r_outer,h_outer], 
            chamfer=1, edges=EDGES_ALL-EDGES_BACK, 
            align=V_TOP+V_BACK
        );
        cyl(h=h_outer, r=r_outer, chamfer=1, align=V_TOP);
    }
}

module yato() {
    union() {
        intersection() {
            union() {
                zmove(-1) cylinder(h=3, d=4);
                zmove(2) cylinder(h=8, d2=8, d1=6.5);
                zmove(10) cylinder(h=4, d1=10, d2=12);
                zmove(14) cylinder(d=12, h=5);
                zmove(19) cylinder(d1=12, r2=r_inner, h=12);
                zmove(31) cylinder(r=r_inner, h=h_inner2);
            }
            zmove(-2) cylinder(h=h_inner1+4, r=r_inner, $fn=6);    
        }
        zmove(h_inner1-2) cylinder(h=7, r1=r_inner-3, r2=r_inner+3);
    }
}

module front_hole() {
    hull() {
        zmove(-1) cuboid([4, 1.2*r_outer, 1], align=V_FRONT+V_TOP);
        zmove(-1) cuboid([3.5, 1.2*r_outer, 3], align=V_FRONT+V_TOP);
    }
    zmove(-1) cuboid([3.5, 1.2*r_outer, 5], align=V_FRONT+V_TOP);
    hull() {
        zmove(4) cuboid([3.5, 1.2*r_outer, 3], align=V_FRONT+V_TOP);
        zmove(10) cuboid([5, 1.2*r_outer, h_outer-9], align=V_FRONT+V_TOP);
    }
    hull() {
        zmove(h_outer-4) cuboid([5, 1.2*r_outer, 1], align=V_FRONT+V_TOP);
        zmove(h_outer) cuboid([8, 1.2*r_outer, 1], align=V_FRONT+V_TOP);
    }
}

module yatoSkadis() {
    zmove(1.6*r_outer) xrot(-90) difference() {
        mass();
        yato();
        front_hole();
    }
    ymove(6) union() {
        skadis_hook_single();
        ymove(SKADIS_HOLES_SPACING_X) skadis_hook_single();
    }
}

xrot(90) yatoSkadis();
