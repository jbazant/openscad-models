$fn=50;

outer_d=49;
inner_d=13.3;
ring_2w=4;
h1=2;
h2=4;

union() {
    difference() {
        // bottom
        union() {
            cylinder(d=outer_d, h=h1, $fn=100);

        }
        // mid hole
        cube([inner_d, 7.4, 2*h2+1], center=true);
    }
    
    // outer ring
    difference() {
            cylinder(d=outer_d, h=h2, $fn=100);
            cylinder(d=outer_d-ring_2w, h=h2+1, $fn=100);
    }
    
    // inner ring
    difference() {
            cylinder(d=inner_d+ring_2w, h=h2);
            cylinder(d=inner_d, h=h2+1);
    }
    
    // locks?
    for (rz=[45 : 90 : 360]) {
        rotate([0, 0, rz]) translate([inner_d/2, 0 ,0]) cylinder(d=2, h=h2);
    }
}