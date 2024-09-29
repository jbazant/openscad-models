w=99/2;
d=64;
h=60;

$fn=100;

module my_hull(d, h) {
    hull() {
        translate([w,0,0]) cylinder(d=d, h=h);
        translate([0,-d/2,0]) cube([1,d,h]);
    }
}

module half() {
    difference() {
        union() {
            translate([w,0,0]) cylinder(h=7, d=11.5);
            
            difference() {
                hull() {
                    translate([0,0,1]) my_hull(d, h - 1);
                    my_hull(d - 2, 1);
                }
                translate([0,0,3.5]) my_hull(d-4, h);
                translate([0,0,2.5]) my_hull(44, h);
            }
            
            difference() {
                my_hull(48, 5.5);
                my_hull(44, 5.5);
            }
            
            difference() {
                my_hull(30, 4.5);
                my_hull(26, 4.5);
            }

            translate([0,0,h-2.5]) {
                difference() {
                    hull() {
                        my_hull(d + 2.5, 2.5);
                        translate([0,0,-2]) my_hull(d, 2.5);    
                    }
                    translate([0,0,-3]) my_hull(d, 10);
                }
            }
        }
        
        translate([w,0,0]) cylinder(h=7, d=6);
    }
}

half();
mirror([1,0,0]) half();
    
