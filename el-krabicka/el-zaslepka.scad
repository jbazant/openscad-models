include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

wall=2;

w_inner=82.5;
w_outer=w_inner+2*wall;
h_inner=10;
h_outer=h_inner+wall;

w_bar_inner=15;
w_bar_outer=w_bar_inner+2*wall;




module socket_cover() {
    module mass() {
        difference() {
            hull() {
                cuboid([w_inner, w_inner, h_outer], edges=EDGES_Z_ALL, fillet=8, align=V_TOP);
                cuboid([w_outer, w_outer, h_inner], edges=EDGES_Z_ALL, fillet=10, align=V_TOP);
            }
            zmove(-1)cuboid([w_inner, w_inner, h_inner+1], edges=EDGES_Z_ALL, fillet=8, align=V_TOP);
        }
    }
    
    module single_cyl() {
        cylinder(d=8, h=h_inner, $fn=40);
        zmove(h_inner/2-2) cuboid([12, wall, h_inner/2], align=V_RIGHT+V_TOP);
    }

    module single_hole() {
        cylinder(d=3.5, h=h_outer+1, $fn=40);
        zmove(h_outer-3) cylinder(d=6, h=4, $fn=40);
    }

    difference() {
        union() {
            mass();
            move(x=29.5, z=2) single_cyl();
            zrot(180) move(x=29.5, z=2) single_cyl();
        }
        
        xmove(29.5) single_hole();
        xmove(-29.5) single_hole();
    }
}

module bar() {
    difference() {
        cuboid(
            [w_bar_outer, w_bar_outer, h_outer], 
            edges=EDGES_Z_FR+EDGES_TOP-EDGE_TOP_BK, chamfer=2, 
            align=V_TOP+V_FRONT
        );
        move(x=-wall/2, y=-wall, z=-1) cuboid(
            [w_bar_inner+wall, w_bar_inner, h_inner+1], 
  
            align=V_TOP+V_FRONT
        );
    }
}


xrot(180) difference() {
    union() {
        socket_cover();
        move(x=-25, y=-w_outer/2+wall) bar();
    }
    move(x=-23, y=-w_outer/2+1, z=-1) cuboid([10, wall*2, h_inner], edges=EDGES_Y_TOP, fillet=3, $fn=40, align=V_TOP);
}
