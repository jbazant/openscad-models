
module pole() {
    rotate([0, -20, 0]) 
    translate([20, 20, 0])
    rotate([30, 0, 0]) 
        cylinder(h=80, r=3);
}

module pillar() {
    for(rot=[0 : 45 : 360]) {
        rotate([0,0,rot]) pole();
    }
}

module base() {
    difference() {
        hull() {
            cylinder(h=9, r=30);
            cylinder(h=11, r=26);
        }
        cylinder(h=12, r=23);
        cylinder(h=5, r=31);
    }
}

difference() {
    union() {
        pillar();
        base();
    }
    translate([0, 0, 71])cylinder(h=5, r=31);
}