include <BOSL/constants.scad>
use <BOSL/shapes.scad>



$fn=20;

//box1a();
//box1b();

//box2a();
box2b();

//tesla_bottom();
//tesla_doublebottom();




module box1a() {
    w=82.5;
    h=30;

    dx_hole=59/2;
    hole_t=[dx_hole, 0, 0];
    
    module main_mass() {
        difference() {
            cuboid([w, w, h], chamfer=4, edges=EDGES_TOP, align=V_ABOVE);
            cuboid([w-4, w-4, h-2], fillet=4, edges=EDGES_TOP, align=V_ABOVE);
        }
    }
    
    module screw_guide() {
        translate(hole_t) union() {
            cylinder(d=6,h=h);
            hull() {
                translate([0, 0, h-12]) cylinder(d=6, h=12);
                translate([0, 0, h-8]) cylinder(d=8, h=8);
            }
            translate([2, -1, 8]) cube([7.8, 2, 20]);
        }
    }

    module screw_hole() {
        translate(hole_t) difference() {
            union() {
                cylinder(d=3.6,h=h);
                translate([0, 0, h-5]) cylinder(d=5.5, h=5);
            }
            translate([0, 0, h-5]) upcube([5.5, 5.5, .2]);
        }
    }

    rotate([180, 0, 0]) difference() {
        union() {
            main_mass();
            screw_guide();                
            mirror([1,0,0]) screw_guide();
        }
        screw_hole();
        mirror([1,0,0]) screw_hole();
    }
}

module box1b() {
    w=82.5;
    h=30;
    
    dx_hole=59/2;
    hole_t=[dx_hole, 0, 0];
    
    module main_mass() {
        module single_a(delta) {
            intersection() {
                upcube([w-2*delta, w-2*delta, h-delta]);
                rotate([0, 0, 45]) upcube([w+4-2*delta, w+4-2*delta, h-delta]);
            }
        }
        
        module single_b(delta, h) {
            cuboid(
                [w-2*delta, w-2*delta, h], 
                edges=EDGES_Z_ALL, 
                align=V_ABOVE
            );
        }
        
        difference() {
            hull() {
                single_a(0);
                single_b(0, 6);
            }
            single_a(2);
            single_b(2, 1);
        }
    }
    
        module screw_guide() {
        translate(hole_t) union() {
            cylinder(d=6,h=h);
            hull() {
                translate([0, 0, h-12]) cylinder(d=6, h=12);
                translate([0, 0, h-8]) cylinder(d=8, h=8);
            }
            translate([2, -1, 8]) cube([7.8, 2, 20]);
        }
    }

    module screw_hole() {
        translate(hole_t) difference() {
            union() {
                cylinder(d=3.6,h=h);
                translate([0, 0, h-5]) cylinder(d=5.5, h=5);
            }
            translate([0, 0, h-5]) upcube([5.5, 5.5, .2]);
        }
    }

    rotate([180, 0, 0]) difference() {
        union() {
            main_mass();
            screw_guide();                
            mirror([1,0,0]) screw_guide();
        }
        screw_hole();
        mirror([1,0,0]) screw_hole();
    }
}

module box2(h) {
    w=82.5;
    
    module main_mass() {
        module single_a(delta) {
            intersection() {
                upcube([w-2*delta, w-2*delta, h-delta]);
                rotate([0, 0, 45]) upcube([w+4-2*delta, w+4-2*delta, h-delta]);
            }
        }
        
        module single_b(delta, h) {
            cuboid(
                [w-2*delta, w-2*delta, h], 
                fillet=12-delta, 
                edges=EDGES_Z_ALL, 
                align=V_ABOVE
            );
        }
        
        difference() {
            hull() {
                single_a(0);
                single_b(0, 6);
            }
            single_a(2);
            single_b(2, 1);
        }
    }
    
    module screw_hole() {
        translate([94.5/2, 0, 0]) difference() {
            union() {
                cylinder(d=5, h=h);
                translate([0, 0, 6]) cylinder(d=8, h=h);
            }
            translate([0, 0, 5.8]) upcube([5, 5, .2]);
        }
    }
    
    difference() {
        main_mass();
        for (rz=[45 : 90 : 360]) {
            rotate([0, 0, rz]) screw_hole();
        }
    }
}

module box2a() {
    difference() {
        box2(30);
        translate([0, 30, 0]) upcube([31, 50, 25]);
        translate([30, 0, 0]) upcube([50, 15, 12]);
        translate([0, -30, 0]) cuboid([8, 50, 10], fillet=3);
    }
}

module box2b() {
    difference() {
        box2(20);
        translate([30, 5, 0]) upcube([50, 15, 12]);
        translate([0,30, 0]) cuboid([8, 50, 20], fillet=4);
    }
}

module tesla_bottom(h=15) {
    module single_mass(delta) {
        cuboid(
            [80-2*delta, 80-2*delta, h-delta],
            fillet=6-delta,
            edges=EDGES_Z_ALL, 
            align=V_ABOVE,
            $fn=50
        );
    }
    
    module screw_hole() {
        tx=59/2;
        w=(80-59)/2;
        
        translate([tx, 0 ,0]) difference() {
            union() {
                cylinder(d=6, h=h, $fn=20);
                translate([0, -1, 0]) cube([w, 2, h]);
                translate([4.75, -1, -1.5]) cube([1.5, 2, h+1.5]);
            }
            translate([0, 0, -2]) cylinder(d=2.1, h=h, $fn=20);
            hull () {
                cylinder(d=2.1, h=1, $fn=20);
                cylinder(d=4, h=0.1, $fn=20);
            }
        }
    }
    
    union() {
        difference() {
            single_mass(0);
            single_mass(2);
        }
        screw_hole();
        rotate([0, 0, 180]) screw_hole();
    }
}

module tesla_doublebottom() {
    h=15;
    difference() {
        union() {
            translate([40, 0 ,0]) tesla_bottom(h);
            translate([-40, 0 ,0]) tesla_bottom(h);
        }
        translate([-15, 30, 0]) cube([30, 20, 15]);
        translate([-15, 15, -2]) cube([30, 40, 15]);
        translate([-7.5, -2, 5]) cube([5.5, 40, 8]);
        translate([2, -2, 5]) cube([5.5, 40, 8]);
        
        color("red") slot([70,30,h-1], [70,20,h-1], d1=8, d2=4.5, h=2);
        color("red") slot([-70,-30,h-1], [-60,-30,h-1], d1=8, d2=4.5, h=2);
    }

    
}