include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

hole_d=4.2;
pool_w=100;
pool_l=72;
pool_h=3.2;

module hole() {
    zmove(-pool_h) cylinder(d=hole_d, h=pool_h, $fn=20);
}

difference() {
    
    union() {
        // top
        hull() {
            cuboid(
                [100+13+13, 72+13, 1.5], 
                fillet=12, edges=EDGES_Z_FR, 
                align=V_FRONT+V_TOP, 
                $fn=50
            );
            xmove(.5) cuboid(
                [100+12+12, 72+12.5, 2], 
                fillet=12, edges=EDGES_Z_FR, 
                align=V_FRONT+V_TOP, 
                $fn=50
            );
        }
        // bottom
        cuboid([100,72,3.2], chamfer=1, edges=EDGES_Z_ALL, align=V_FRONT+V_BOTTOM);
        
        // holes
        translate([pool_w/2-16, -pool_l-8.5]) hole();
        translate([-pool_w/2+14, -pool_l-8.5]) hole();
        translate([-pool_w/2-2, -pool_l-9]) hole();
    }
    
    // pool
    ymove(-1) difference() {
        union() {
            cuboid(
                [100-2,72-2,4.4], 
                fillet=2, edges=EDGES_Z_ALL, 
                align=V_FRONT, $fn=20
            );
            hull() {
                zmove(1.5) cuboid(
                    [100-2,72-2,1], 
                    align=V_FRONT+V_TOP, fillet=2, 
                    edges=EDGES_Z_ALL, $fn=20
                );
                translate([0, .5, 2]) cuboid(
                    [100-1,72-1,1], align=V_FRONT+V_TOP, 
                    fillet=2, edges=EDGES_Z_ALL, $fn=20
                );
            }
        }
        hull() {
            cuboid(
                [20, 20, 2.5],
                fillet=10, edges=EDGE_BK_LF,
                p1=[50-20, -72, -3]
            );
            cuboid(
                [19.5, 19.5, 3],
                fillet=9.5, edges=EDGE_BK_LF,
                p1=[50-19.5, -72, -3]
            );
        }
    }
}