include <BOSL/constants.scad>
use <BOSL/shapes.scad>

w1=120;
l1=148;

w2=118;
l2=146;

h=36;
r=19;

h_to_b=h-4;

module outer_body() {
    difference() {
        rounded_prismoid(size1=[w1, l1], size2=[w2, l2], h=h, r1=r, r2=r, $fn=100);
        //rounded_prismoid(size1=[w1-4, l1-4], size2=[w2-10, l2-10], h=h_to_b, r1=r, r2=r, $fn=100);
        
        for(i=[-1/3 : 2/3 : 1/3]) {
            translate([0, i*l1, (h_to_b)/2]) cube([w1, 1, h_to_b], center=true);
            translate([i*w1, 0, (h_to_b)/2]) cube([1, l1, h_to_b], center=true);
        }
    }
}

module inner_body() {
    // todo maybe from cards_hole?
    hull() {
        translate([0,0, h_to_b]) rounded_prismoid(size1=[w2-10, l2-10], size2=[w2-10, l2-10], h=1, r1=r, r2=r, $fn=100);
    cards_hole(2, 2);
    }
}

module cards_hole(delta_w = 0, delta_l = 0) {
    hole_w=70+delta_w;
    hole_l=95+delta_l;
    hole_h=h-0.4;
    
    finger_hole_r=13+delta_w;
    
    hull() {
         translate([0,0,hole_h-0.1]) cuboid([hole_w,hole_l-2,0.1], align=V_UP);
         cuboid([hole_w,hole_l,hole_h-1], align=V_UP);
    }
    translate([0, hole_l/2, 0]) cylinder(h=hole_h, r=finger_hole_r);
    translate([0, -hole_l/2, 0]) cylinder(h=hole_h, r=finger_hole_r);
}

module single() {
    difference() {
        union() {
            outer_body();
            inner_body();
        }
        translate([0,0,0.4]) cards_hole();
    }
}

module double() {
    difference() {
        union() {
            outer_body();
        }
        translate([0, 36.5, 0.4]) rotate([0,0, 90]) cards_hole();
        translate([0, -35.5, 0.4]) rotate([0,0, 90]) cards_hole(2);
    }
}

double();

