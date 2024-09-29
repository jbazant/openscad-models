$fn=100;

difference() {
    scale([3, 2.4, 1.5]) sphere(r=6);
    translate([-50, -50, -100]) cube(100);
    translate([7, 0, 1]) cylinder(d=3, h=20);
}