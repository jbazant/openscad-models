$fn=100;

// wall width
w=4;

h=100;
h1=80;
h3=w;
h2=h-h1-h3;

r1=30;
r2=20;

// rim width
w_rim=8;

// screw hole width
hole_d=5;
// screw hole count
hole_count=3;



difference() {
    // mass
    union() {
        cylinder(r1=r1, r2=r2, h=h1);
        translate([0,0,h1]) cylinder(r1=r2, r2=r1, h=h2);
        translate([0,0,h1+h2]) cylinder(r=r1, h=h3);
        
        cylinder(r=r1+w_rim, h=h3);
    }
    
    // mid hole
    union() {
        cylinder(r1=r1-w, r2=r2-w, h=h1);
        translate([0,0,h1]) cylinder(r1=r2-w, r2=0, h=h2);
    }
    
    // screw holes
    for (rz = [0:360/hole_count:360]) {
        rotate([0,0,rz])translate([0, r1+w_rim/2, 0]) cylinder(d=hole_d, h=h3);

    }
}