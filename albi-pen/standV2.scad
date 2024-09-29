
$fn=100;

module pen(d1 = 30, d2= 32, d3 = 7) {
    hull() {
        translate([0,0, 30]) scale([d1/d2, 1, 1]) cylinder(d=d1, h=31);
        translate([0,0, 5]) cylinder(h=1, d=d3);
    };
}

module aaa() {
    difference() {
        hull() {
            translate([25,0,0]) cylinder(d1=50, d2=40, h=60);
            translate([-25,0,0]) cylinder(d1=50, d2=40, h=60);
        };
        translate([25,0,0]) pen(30, 32, 7);
        translate([-25,0,0]) pen(33, 34.5, 8);
    }
}

aaa();
color("green") 
  translate([0, -22, 20]) 
  rotate([85, 0, 0]) 
  linear_extrude(2) 
    text("A I", size =30, halign="center");
