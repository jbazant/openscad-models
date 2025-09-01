include <BOSL/constants.scad>
use <BOSL/shapes.scad>

$fn=100;

pin_d=8;

// ----------

optimist_hull();
//translate([0, -6, 5]) rudder();
//translate([0, -84, 5]) sail();

// ----------
module equipment_pin() {
    pin_d1=pin_d;
    pin_d2=pin_d1 + .2;
    pin_h=11;
    
    intersection() {
        difference() {
            union() {
                cylinder(d=pin_d1, h=pin_h, $fn=20);
                translate([0, 0, 3]) cylinder(d1=pin_d2, d2=pin_d1, h=1);
                translate([0, 0, 1]) cylinder(d=pin_d2, h=2);
                cylinder(d1=pin_d1, d2=pin_d2, h=1);
            }
            upcube([pin_d2, 1.2, 7]);
        }
        upcube([7, pin_d2, pin_h]);
    }
}

module rudder() {
    union() {
        equipment_pin();
        translate([0, 0, 9.5]) cuboid([7, 40, 5], chamfer=1, align=V_TOP);
        translate([0, 15, -3]) cuboid([2, 10, 14], chamfer=.5, align=V_TOP);
    }
}

module sail() {
    union() {
        equipment_pin();
        translate([0, 0, 9]) hull() {
            cylinder(d=10, h=12);
            cylinder(d=8, h=13);
        }
        translate([0, 0, 17]) cuboid([7, 90, 5], chamfer=1, align=V_TOP+V_BACK);
    }
}
    
module optimist_hull() {
    module waterline(s=1) {
        scale([s, s, s])
        translate([ 0, -7, 0]) 
            intersection() {
                translate([-13,  0, 0]) cylinder(r=20, h=.2);
                translate([ 13,  0, 0]) cylinder(r=20, h=.2);
                translate([  0, -3, 0]) upcube(20);
            }
    }

    module basic(s=5) {
        scale([s*3/4, s, s*2/3])
            hull() {
                translate([ 0, 0, 0]) waterline();
                translate([ 0, 0, 4]) waterline(1.05);
            }
    }

    module equipment_hole() {
        pin_d1=pin_d;
        pin_d2=pin_d1+2;
        
        translate([0, 0, 4]) {
            cylinder(d=pin_d1, h=40, $fn=20);
            cylinder(d=pin_d2, h=4);
            translate([0, 0, 4]) cylinder(d1=pin_d2, d2=pin_d1, h=1);
        }
    }

    module magnet_hole() {
        translate([0, 0, .4]) cylinder(d=8.2, h=2.2);
    }

    difference() {
        translate([0, 0, 0]) basic(5);
        difference() {
            translate([0,  -6, 3]) basic(4.4);
            // divide
            translate([0, -48, 0]) cuboid([200, 2, 9], fillet=1, align=V_TOP, edges=EDGES_TOP, $fn=10);
            // book
            translate([0, -49, 0]) cuboid([4, 16, 12], fillet=1, align=V_TOP+V_FRONT, edges=EDGES_TOP+EDGES_FRONT, $fn=10);
            //bench
            translate([0, -84, 0]) cuboid([200, 12, 13.5], fillet=1, align=V_TOP, edges=EDGES_TOP, $fn=10);
            // rudder
            translate([0,  -6, 0]) cylinder(d=12, h=40);
        }
        
        // bench hole
        translate([0, -84, 0]) {
            equipment_hole();
            magnet_hole();
        }
        
        // rudder hole
        translate([0,  -6, 0]) {
            equipment_hole();
            magnet_hole();
        }
    }
}
