union() {
    difference() {
        cube([14,20,7]);
        translate([3,0,0]) hull() {
            translate([0,0,0]) cube([8,20,3]);
            translate([2,0,0]) cube([4,20,5]);
        }
        
        translate([0,0,2]) rotate([90,0,0]) cylinder(h=50, d=2, center=true, $fn=8);
        translate([14,0,2]) rotate([90,0,0]) cylinder(h=50, d=2, center=true, $fn=8);
        
        translate([0,9,0]) cube([14,2,5]);
        
        translate([0,0,0]) rotate([90,0,0]) cylinder(h=50, d=1.4, center=true, $fn=4);
        translate([14,0,0]) rotate([90,0,0]) cylinder(h=50, d=1.4, center=true, $fn=4);

    }
    translate([3,4,2]) cube([8,1,5]);
    translate([3,15,2]) cube([8,1,5]);
}