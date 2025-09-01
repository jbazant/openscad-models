include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

$fn=120;

w=0.8;

module simple_circle(d = 40) {
    difference() {
        union() {
            hull() {
                cylinder(d = d + w, h = 16);
                cylinder(d = d + 2*w, h = 14);
            }
            cylinder(d = d+10, h = 2);
        }
        cylinder(d = d, h = 17);
    }
}


simple_circle(100);
