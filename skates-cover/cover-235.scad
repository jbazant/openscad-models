l=232;
iw=3.46;
wall=1.6;
ow=iw+2*wall;
h=20;
back_h=h+18;
front_h=h+23;
l_lock=7;


module sikmina() {
    color("red") rotate([0,45,0]) cube([l_lock,20,l_lock], center=true);
}


module innersikmina() {
    translate([0,ow/2,0]) difference() {
        rotate([0,45,0]) cube([26, ow, 26], center=true);
        translate([0,0, -50]) cube(100, center=true);
    }
}

module maxisikmina() {
    color("red") rotate([0,45,0]) cube(25, center=true);
}

module minisikmina() {
    color("red") rotate([0,45,0]) cube([1,3*ow,1], center=true);
}

difference() {
    union() {
        cube([l, ow, h]);

        translate([l, 0, 0]) difference() {
            cube([l_lock, ow, back_h]);
            
            translate([l_lock, 0, back_h]) sikmina();

            hull() {
                translate([0, 0, h+1]) minisikmina();
                translate([0, 0, back_h-2]) minisikmina();
            }
        }

        translate([-l_lock, 0, 0]) difference() {
            cube([l_lock, ow, front_h]);
            
            translate([0, 0, front_h]) sikmina();
            
            hull() {
                translate([l_lock, 0, h+1]) minisikmina();
                translate([l_lock, 0, front_h-2]) minisikmina();
            }
        }
    }
    
    translate([0, wall, 0]) hull() {
        translate([5, 0, h-2]) cube([l-9, iw, 1]);
        translate([25, 0, 2]) cube([l-36, iw, 1]);
    }
    translate([l/2, ow/2, h]) rotate([45,0,0]) 
        cube([l, iw, iw], center=true);
    
    translate([l/2, wall, 0]) {
        translate([60, 0, 0]) cube([20, iw, 4]);
        translate([-10, 0, 0]) cube([20, iw, 4]);
        translate([-60-20, 0, 0]) cube([20, iw, 4]);
    }
    
    translate([l+l_lock, 0, 0]) maxisikmina();
    translate([-l_lock, 0, 0]) maxisikmina();
}
