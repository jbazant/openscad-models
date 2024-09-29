$fn = $preview ? 50 : 200;

module top_mass() {
    difference() {
      scale([1, 18.6/20]) circle(10);
      translate([0, -10]) square(20);
    }
}

module bottom_mass() {
    hull() {
        square([0.1, 10.3], center=true);
        translate([6, 4.5/2]) circle(2);
            translate([6, -4.5/2]) circle(2);
    }
}

module round_bottom() {
    r=2.75;
    translate([-25.5-r+0.2, -r, 0]) color("red") union() {
        cylinder(h=22, r=r, center=true);
        translate([0,-100,-50]) cube(100);
        translate([-100,-70,-50]) cube(100);
        translate([10,-70,-50]) cube(100);
    }
}

module main_mass() {
    rotate([-90, 0, 0]) rotate([0,0,35]) 
    intersection() {
        difference() {
            union() {
                rotate_extrude(angle=55) translate([-25.5, 0]) top_mass();
                rotate([0,0,18]) rotate_extrude(angle=37) translate([-25.5, -1.1]) bottom_mass();
                rotate([0,0,55]) rotate_extrude(angle=35) translate([-25.5, -1.1]) difference() {
                    bottom_mass();
                    translate([-0.1, -5-2.4]) square(5);
                }
                
            }
            hull() {
                translate([-20.8, -6.5]) cylinder(d=7, h=20, center=true);
                translate([-24.5,-0.1,-10]) cube([11, 0.1, 20]);
            }
        }
        round_bottom();
    }
}

module lock() {
    difference() {
        hull () {
            translate([0, 0, 2]) rotate([90,0,0]) {
                translate([8.1, 0, 0]) cylinder(h=2.5, r=2, center=true);
                translate([-8.1, 0, 0]) cylinder(h=2.5, r=2, center=true);
            }
            translate([0, 0, 6.5/2 + 2]) cube([20.2, 2.5, 6.5], center=true);
            translate([0, 0, 15]) cube([1, 2.5, 1], center=true);
        }
        translate([0, 0, 4 + 4.5/2]) cube([12.2, 3, 4.5], center=true);
        rotate([-45, 0, 0]) translate([0,0,-1.5]) cube([22, 22, 4], center=true);
    }

}

module lock_hole() {
    alpha=44;
    rotate([-90, 90, 0]) rotate([0,0,-alpha/2]) rotate_extrude(angle=alpha) translate([-15.7, -4]) square([2,5]);
}

module mass_hole() {
    alpha=48;
    w=3;
    rotate([-90, 0, 0]) rotate([0,0,35+(55-alpha)/2]) 
     rotate_extrude(angle=alpha) translate([-30, 0]) union() {
        translate([-10, 0]) square([20, w], center=true);
        translate([0, -10]) square([w, 20], center=true);
        circle(d=w);
    }
}

module connect_hole() {
    alpha=31;
    w=3;
    h=3.6;
    rotate([-90, 0, 0]) rotate([0,0,35]) 
    rotate([0,0,55]) rotate_extrude(angle=alpha) translate([-25.5+1.9, -h+0.1]) square([w,h]);
}

module final() {
    difference() {
        union() {
          main_mass();
          translate([0, -1.25, 6]) lock();
        }
        connect_hole();
        mass_hole();
        lock_hole();

    }
}

module print_support(h=5, x=0, y=0, r=0, w=10) {
    translate([x,y,0]) rotate([0,0,r]) cube([w,0.4,h]);
}

module supports() {
        print_support(15, 5,-0.6, 0);
        print_support(17, 3.5,-0.6, 0);
        print_support(10, -3.5,-0.6, 0);
        print_support(4, 3, -6, 90);
        print_support(4, 1, -6, 90);

        translate([0,-2.3,10]) rotate([0,35,0]) cube([15,0.4,10]);


        translate([-5, -11, 0]) cube([20, 20, 0.2]);
        translate([13, -6, 0]) cube([7, 10, 0.2]);print_support(4, 1, -1.5, 90, 3);

        print_support(10, 0, -4, 0, 26);
        print_support(10, 0, 1.5, 0, 26);
        print_support(16.5, 0, -4, 0, 16);
        print_support(16.5, 0, 1.5, 0, 16);
        print_support(18.5, 0, -4, 0, 8);
        print_support(18.5, 0, 1.5, 0, 8);
        print_support(5, 19, -6, 90);
        print_support(16, 3, -5, 90, 2);
        print_support(13, 9, -5, 90, 2);    
        print_support(16, 3, 1, 90, 2);
        print_support(13, 9, 1, 90, 2);
    
        translate([23, -6, 13]) cube([6, 0.4, 2.5]);
        translate([30, -3, 15]) rotate([0,0,90]) cube([6, 0.4, 2.5]);
}

difference() {
    union() {
        mirror([1,0,0]) rotate([0,-35,0]) final();
        color("red") supports();
    }
    translate([-50, -50, -5]) cube([100, 100, 5]);
}


