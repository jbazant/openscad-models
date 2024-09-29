
h=36;
//h=5;
w=2.3;
l=24+w;

$fn=40;

union(){
    cube([l, w, h]);
    
    translate([l, 5, 0]) difference() {
        cylinder(r=5, h=h);
        translate([0, 0, -1])cylinder(r=5-w, h=h+2);
        translate([-5, -5, -1]) cube([5,10,h+2]);
    }

    translate([0, 6+w, 0])difference() {
        cylinder(r=6+w, h=h);
        translate([0, 0, -1])cylinder(r=6, h=h+2);
        translate([0, -6-w, -1]) cube([12+2*w,12+2*w,h+2]);
    }
    
    translate([-6-w+0.4, 6+3/2*w, 0]) rotate([0, 0, 180]) intersection() {
        translate([-h+5,w/2,h/2]) rotate([90, 0, 0]) 
            cylinder(r=h, h=w, center=true, $fn=100);
        cube(h);
    }
}
