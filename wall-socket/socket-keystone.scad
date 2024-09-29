$fn=50;

h=12;
w=80;
w_deco=65;


module main_body_circle() {
  cylinder(h=h, d=w);
}

module main_body_square() {
    difference() {
        translate([0,0,h/2]) cube([w,w,h], center=true);
        translate([0,0,h]) cube([w - 6, w - 6, 2], center=true);
    }
}


module srew_hole() {
    union() {
        cylinder(h=h, d=3);
        cylinder(h=2, d=6);
        translate([0,0,2]) cylinder(h=1, d1=6, d2=3);
    }
}

module keystone() {
    translate([2,-2,0])import("Keystone-Cutout.stl", convexity=3);
    translate([0.5, -25, 10]) cube([18,5,10]);
}

module stoneline2() {
    translate([8,0,0]) keystone();
    translate([28,0,0]) keystone();
}

module stoneline3() {
    translate([0,0,0]) keystone();
    translate([18,0,0]) keystone();
    translate([36,,0]) keystone();
}

module decorative_cutout() {
    module rounded_cube(w, h) {
        w_half=w/2;
        
        hull() {
            translate([w_half - 1, w_half - 1, 0]) cylinder(h=h, r=1);
            translate([-w_half + 1, -w_half + 1, 0]) cylinder(h=h, r=1);
            translate([-w_half + 1, w_half - 1, 0]) cylinder(h=h, r=1);
            translate([w_half - 1, -w_half + 1, 0]) cylinder(h=h, r=1);
        }
    }
    
    deco_h=6;
    deco_size = .8;
    double_deco=2 * deco_size;
    inner_w=w_deco - double_deco;
    
    difference() {
        hull() {
            rounded_cube(w_deco, deco_h - 1);
            translate([0, 0, deco_h/2])
              cube([inner_w, inner_w, deco_h], center=true);
        }
        rounded_cube(inner_w, deco_h);
    }
}
    

module result() {
    difference() {
        // body mass
        main_body_square();
        decorative_cutout();
        
        // keystones
        translate([-27.5,-1.9,0]) {
            stoneline3();
            translate([0,26,0]) stoneline2();
        }

        // screw holes
        rotate([0,0,-20]){
        translate([0, 30, 0]) srew_hole();
        translate([0, -30, 0]) srew_hole();
        }
        
        // descriptions
        mirror([1,0,0]) linear_extrude(.5) {
            translate([0, 1, 0]) {
                translate([-10, 0, 0]) text("WAN", size=4, halign="center");
                translate([10, 0, 0]) text("F", size=4, halign="center");
            }
            translate([0, -3.5, 0]) {
                translate([-18, 0, 0]) text("KAN", size=4, halign="center");
            text("PO1", size=4, halign="center");
                translate([18, 0, 0]) text("PO2", size=4, halign="center");
            }
        }
    }
}

result();
