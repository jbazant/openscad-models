$fn=50;

difference() {
    union() {
        translate([0, 0, 0]) cylinder(r1=7.5, r2=8, h=1);
        translate([0, 0, 1]) cylinder(r1=8, r2=9, h=19);
        translate([0, 0, 20]) cylinder(r1=9, r2=8, h=3);
        translate([0, 0, 23]) cylinder(r2=9, r1=8, h=3);
        translate([0, 0, 26]) cylinder(r=9, h=10);
        translate([0, 0, 36]) cylinder(r1=9, r2=8, h=3);
        translate([0, 0, 39]) cylinder(r2=9, r1=8, h=3);
        translate([0, 0, 42]) cylinder(r=9, h=2);
        translate([0, 0, 44]) cylinder(r1=9, r2=6, h=20);
        translate([0, 0, 64]) cylinder(r1=6, r2=3, h=2);
    }
    cylinder(d=10.5, h=20);
    cylinder(d1=11.5, d2=10.5, h=1);
}