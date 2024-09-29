
$fn=100;

module pen(d1 = 30, d2= 32, d3 = 7) {
    union() {
        hull() {
            translate([0,0, 60]) scale([d2/d1, 1, 1]) cylinder(d=d1 + 1, h=11);
            translate([0,0, 59]) scale([d2/d1, 1, 1]) cylinder(d=d1, h=1);
        };
        hull() {
            translate([0,0, 30]) scale([d2/d1, 1, 1]) cylinder(d=d1, h=31);
            translate([0,0, 5]) cylinder(h=1, d=d3);
        };
    }
}

module body() {
    module one() {
        hull() {
            cylinder(d1=50, d2=40, h=59);
            cylinder(d=38, h=60);
        }
    }
    difference() {
        hull() {
            translate([25,0,0]) one();
            translate([-25,0,0]) one();
        };
        translate([-25,0,0]) pen(30, 32, 7);
        translate([25,0,0]) pen(33, 34.5, 8);
    }
}

module inicials() {
    translate([0, -22, 20]) 
    rotate([85, 0, 0]) 
    linear_extrude(2) 
      text("A  I", size =30, halign="center");
}

union() {
    body();
    color("green") inicials();
}

