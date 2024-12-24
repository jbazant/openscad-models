include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>
use <JBscad/locks.scad>


module inside(with_hole) {
    module usb_connector() {
        translate([6.5, 16.5, 29-1]) cuboid(
            [12, 8, 10],
            edges=EDGES_Z_ALL,
            fillet=2,
            align=V_TOP,
            $fn=20
        );
    }
    
    module battery() {
        cuboid(
            [35, 10.5, 54],
            edges=EDGES_Z_ALL,
            fillet=5,
            align=V_UP+V_FRONT
        );
    }

    module boards() {
        union() {
            cuboid([27, 29, 29], align=V_UP+V_BACK);
            translate([0, 29, 12]) cuboid([13, 6, 18], align=V_UP+V_BACK);
            ymove(2) cuboid([27, 3, 12], edges=EDGES_Y_ALL, chamfer=2, align=V_BACK);
            usb_connector();
        }
    }
    


    ymove(-1) battery();
    ymove(1) zmove(54-29) boards();
    if (with_hole) {
        color("green") zmove(39) upcube([27, 2, 15]);
    }
    usb_connector();
}

module lid() {
    a=35+4;
    b=10.5+29+2+4;
    
    module locks() {
        translate([16, 12, 0]) xrot(180) lock_small();
        translate([16, -5, 0]) xrot(180) lock_small();
        
        mirror([1,0,0]) {
            translate([16, 12, 0]) xrot(180) lock_small();
            translate([16, -5, 0]) xrot(180) lock_small();
        }
    }
    
    union() {
        difference() {
            zmove(54+2) ymove(b/2) union() {
                difference() {
                    zmove(-1) cuboid(
                        [a, b, 6],
                        chamfer=3,
                        edges=EDGES_TOP+EDGES_Z_ALL
                    );
                    downcube([a+1, b+1, 5]);
                }
                    
                cuboid(
                    [a-3, b-3, 1.8], 
                    align=V_DOWN,
                    edges=EDGES_Z_ALL,
                    chamfer=2
                );
                locks();
            }
            translate([0, +10.5+2+1, 2]) inside(true);
        }
        translate([12.5,15,54+2]) downcube([2,1,1.8]);
        translate([12.5,18,54+2]) downcube([2,1,1.8]);
        color("blue") translate([-12.3,28,54+2]) downcube([2.5,31,1.8]);
    }
    
}

module bottom_case() {
    a=35+4;
    b=10.5+29+2+4;
    
    module lid_spacer() {
        zmove(54+2) ymove(b/2) union() {
            cuboid([a, b, 3], align=V_TOP);
            cuboid(
                [a-2.8, b-2.8, 2], 
                align=V_DOWN,
                edges=EDGES_Z_ALL,
                chamfer=2
            );
        }
    }
    
    module locks() {
        translate([0, b/2, 54]) {
            translate([16, 12, 0]) xrot(180) lock_small_housing();
            translate([16, -5, 0]) xrot(180) lock_small_housing();
            
            mirror([1,0,0]) {
                translate([16, 12, 0]) xrot(180) lock_small_housing();
                translate([16, -5, 0]) xrot(180) lock_small_housing();
            }
        }
    }
    
    difference() {
        color([0,.5,1,.7]) cuboid(
            [a, b, 54+4],
            align=V_TOP+V_BACK,
            chamfer=3
        );
        translate([0, +10.5+2+1, 2]) inside(true);
        lid_spacer();
        locks();
    }

}

//inside();

//ymove(5) bottom_case();
ymove(-5) zmove(54+4) xrot(180) lid();
