w=91;
h=5;
nut_d=6.5;
nut_h=3;

// -----
wh=w/2;
hh=h/2;


module hole(t_y) {
    cylinder(h=h, d=3, $fn=50);
    cylinder(h=nut_h, d=nut_d, $fn=6);
}

difference() {
    hull() {
        translate([0, wh, 0]) cylinder(h=h, d=nut_d+3);
        translate([0, -wh, 0]) cylinder(h=h, d=nut_d+3);
    }
    union() {
    translate([0, wh, 0]) hole();
    translate([0, -wh, 0]) hole();
    }
}