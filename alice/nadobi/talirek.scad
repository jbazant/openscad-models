include<BOSL/transforms.scad>

$fn=100;

d=150;

difference() {
    hull() {
        cylinder(d=d-6, h=7);
        zmove(3) cylinder(d=d, h=3);
    };
    zmove(2)  hull() {
        cylinder(d=d-20, h=6);
        zmove(2) cylinder(d=d-16, h=6);
    }
    
    zmove(6) hull() {
        cylinder(d=d-16, h=6);
        zmove(1) cylinder(d=d-10.4§, h=6);
    }
}