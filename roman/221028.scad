$fn=100;

w=21.5;
r1=5;
r2=4.25;
w2= w - r1 - r2;

mid_h=2.3;
right_h=6.4;


module mid_part() {
    hull() {
        h=2.3;
        cylinder(h=h, r=r1);
        translate([w2, 0, 0]) cylinder(h=h, r=r2);
    }
}

module right_part() {
    gap_depth=0.9;
    r3=r2-1.75;
    
    module tube() {
        rotate([0,90,0]) {
            cylinder(d=gap_depth, h=2*r3, center=true);
            translate([gap_depth/2,0,0]) cube([gap_depth,gap_depth,2*r3], center=true);
        }
    }
    translate([w2, 0, 0]) {
        difference() {
            cylinder(h=right_h, r=r2);
            translate([0,0,mid_h]) {
                cylinder(h=right_h, r=r3);
                translate([0,0,right_h/2]) cube([2*r2+1, gap_depth, right_h], center=true);
            }
        }
        translate([0,0,mid_h+gap_depth]) {
            tube();
            rotate([0,0,45]) tube();
        }
    }
        
}

module lock() {
    translate([-0.,-1.5,0]) {
        translate([0,0,2.4]) hull() {
            cube([0.4, 3, 2.5]);
            cube([2, 3, 0.2]);
        }
        
        cube([0.8,3,2.4]);
        translate([-3,1,0]) cube([3,1,1]);
    }
}

module x(r, h) {
    r_plus= r+0.;
    r_minus= r-0.1;
    
    intersection() {
        union() {
            rotate([0,0,24]) translate([0,0,h/2]) cube([1, 2*r_plus, h], center=true);
            rotate([0,0,-24]) translate([0,0,h/2]) cube([1, 2*r_plus, h], center=true);
        }
        difference() {
            cylinder(h=h, r=r_plus);
            cylinder(h=h, r=r_minus);
        }
    }
}

module left_part() {
    h= 12.1;
    h1=4.9;
    h2= h - h1;
    r= 4.05;
    c= 4.2;

    
    rotate([180,0,0]) {
        difference() {
            union() {
                intersection() {
                    cylinder(h=h, r=r);
                    union() {
                        translate([0,0,h/2]) cube([c, 2*r, h], center= true);
                        cylinder(h=h2, r=r);
                    }
                }
                cylinder(h=0.3, r1=r+0.4, r2=r);
                x(r, 12.1);
            }
            translate([1.5, 0, h2/2+h/2]) cube([c, 4.8, h1], center= true);
        }
        translate([c/2,0,h2]) lock();
    }
}

module left_hole() {
    h1=3.2;
    h2=8.1-h1;
    h3=11;
    cylinder_d=5;
    cube_w=2.9;
    y_offset=2.3;
    
     translate([0,0,y_offset])rotate([180,0,0]) {
        cylinder(h=h1, d=cylinder_d);
        translate([0,0, h1-1]) intersection() {
            cylinder(h=h2+1, d=cylinder_d);
            translate([0,0, (h2+1)/2]) cube([cylinder_d, cube_w, h2+1], center=true);
        }
        translate([1,-cube_w/2, 0]) cube([5, cube_w, h2+h1]);
        translate([2.1,-cube_w/2, 0]) cube([5, cube_w, h3]);
    }
}



module complet() {
    rot=75;
    difference() {
        union() {
            rotate([0,0,rot]) left_part();
            mid_part();
            right_part();
        }
        rotate([0,0,rot]) left_hole();
    }
}

complet();
    