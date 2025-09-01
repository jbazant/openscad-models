include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

$fn=$preview ? 10 : 30;

module jumbo_case() {
    cards_w_outer=63.6;
    h=36;
    
    module mass() {
        hull() {
            cuboid([195, 195, 1], edges=EDGES_Z_ALL, fillet=3, align=V_TOP);
            cuboid([192, 192, h], edges=EDGES_Z_ALL, fillet=3, align=V_TOP);
        }
    }

    module cards(tx, ty) {
        translate([tx, ty, 2]) cuboid([95, 62, h+1], edges=EDGES_Z_ALL, fillet=1, align=V_TOP);
        translate([tx, ty, -1]) cuboid([60, 37, 5], edges=EDGES_Z_ALL, fillet=5, align=V_TOP);
    }

    module tokens_big(ty) {
        translate([-14, ty, h-25]) cuboid([79, 42, h+12], fillet=10, align=V_TOP+V_LEFT);
    }

    module tokens_narrow() {
        translate([-73, 0, h-25]) cuboid([20, 95, h+12], fillet=10, edges=EDGES_X_ALL, align=V_TOP+V_LEFT);
    }

    module finger(ty) {
        translate([-2.4, ty, .8]) cuboid([20, 20, h+10], fillet=8, align=V_TOP);
    }

    module long_finger() {
        translate([-5.4, 0, .8]) cuboid([25, 20, h+10], fillet=8, align=V_TOP);
    }
    
    module rules() {
        zmove(h-1) union() {
            upcube([190, 190, 2]);
            upcube([196, 20, 2]);
            upcube([20, 196, 2]);
        }
    }

    difference() {
        mass();
       
        cards(45, cards_w_outer);
        finger(cards_w_outer);
        
        cards(45, 0);
        long_finger();
        finger(-cards_w_outer);
        
        cards(45, -cards_w_outer);
        zrot(90) cards(0, 40);
        long_finger();
        
        tokens_big(72);
        tokens_big(-72);
        tokens_narrow();
        
        rules();
    }
}

jumbo_case();