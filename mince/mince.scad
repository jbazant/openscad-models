include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

coin_d1=30.6;
coin_d2=31.1;
coin_d3=31.6;
coin_h=3.2+1;



coin_hole(coin_d1);
//single_coin(coin_d1, "d1");
//three_coins();
//eight_coins();
//titles();


// ---------------- do not edit below this line ------------
$fn = 100;

hole_h0 = .4;
hole_h1 = coin_h;

h = 2 * hole_h0 + hole_h1;  
spacing = coin_d1+7;
    
module coin_hole(coin_d) {
// TODO upadte
    zmove(-.6) cyl(d=coin_d-1, h=coin_h+2, align=V_TOP);
    zmove(hole_h0) cyl(d=coin_d, h=coin_h, chamfer=1, align=V_TOP);
    zmove(-.6) difference() {
        cyl(d=coin_d, h=coin_h/2+1, align=V_TOP);
        union() {
            ymove(-8) cuboid([coin_d, coin_d, coin_h/2+1], align=V_TOP+V_FRONT);
            ymove(coin_d/2) zrot(45) upcube([coin_d/4, coin_d/4, coin_h/2+1]);
        }
    }
}

module title(t) {
    zmove(h-.2) linear_extrude(.2) 
        text(t, halign="center", size=5, font="Arial:style=Bold");
}
    

module single_coin(coin_d, description) {
    w = coin_d1 + 10;

    difference() {
        cuboid([w, w, h], fillet=10, edges=EDGES_Z_ALL, align=V_TOP);
        coin_hole(coin_d);
        move(x=coin_d/2-3, y=coin_d/2-3) color("green") title(description);
    }

}

module titles() {
    color("green") {
        ymove(coin_d1/2-4) ydistribute(spacing) {
            ymove(-1) title("Chomutov");
            xdistribute(spacing) {
                title("Berlín");
                title("Loučeň");
                title("Dvůr Králové");
                title("Teplice");
            }
        }

    }
}

module holes() {
    ymove(-5) color("blue") {
        ydistribute(spacing) {
            xdistribute(spacing) {
                coin_hole(coin_d1);
                coin_hole(coin_d1);
                coin_hole(coin_d1);
                coin_hole(coin_d1);
            }
            xdistribute(spacing) {
                coin_hole(coin_d3);
                coin_hole(coin_d2);
                coin_hole(coin_d1);
                coin_hole(coin_d2);
            }

        }
    }
}

module three_coins() {
    xdistribute(coin_d1+6) {
        single_coin(coin_d1, "d1");
        single_coin(coin_d2, "d2");
        single_coin(coin_d3, "d3");
    }
}
    

module eight_coins() {
    difference() {
        ymove(-1) hull() {
            cuboid([4*spacing-2, 2*spacing+5-2, h], fillet=9, edges=EDGES_Z_ALL, align=V_TOP);
            zmove(1) cuboid([4*spacing, 2*spacing+5, h-2], fillet=10, edges=EDGES_Z_ALL, align=V_TOP);
        }
        holes();
        titles();
    }
}

