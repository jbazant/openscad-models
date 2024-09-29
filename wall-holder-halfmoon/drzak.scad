// render screw hole 
with_srew_hole=false;// boolean

// $fn prop
$fn=100;

difference() {
    translate([0,0,7]) sphere(r=35);
    
    // dira do oblouku
    translate([3, 0, 0]) difference() {
        scale([29/30,1,1])cylinder(r=30, h=100, center=true);
        translate([-20, 0, 0]) cube([40, 100, 100], center= true);
    };
    
    // zadni stena
    translate([-20, 0, 0]) cube([40, 100, 100], center= true);
    
    // spodni seriznuti
    translate([0, 0, -20]) cube([100, 100, 40], center= true);

    if (with_srew_hole) {
        // dira na vrut
        translate([0,0,30]) rotate([0, 90, 0]) {
            cylinder(r=2, h=10, $fn=8, center=true);
            translate([0,0,1]) cylinder(r1=2, r2=4, h=2, $fn=8);
        }
    }
    
    // vrchni seriznuti
    translate([3, -50, 23]) union() {
        rotate([0, 10, 0]) cube([100, 100, 10]);
        cube([100, 100, 10]);
    }
};
