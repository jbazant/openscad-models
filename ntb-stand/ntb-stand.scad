r = 20;
x = 100;
y = 60;
h = 5;

fn = $preview ? 50 : 100;

module pillars() {
    translate([x, y, 0]) cylinder(r1 = 20, r2 = 10, h = 155, $fn = fn);
    translate([x, - y, 0]) cylinder(r1 = 20, r2 = 12, h = 49, $fn = fn);
}

module c_supports() {
    for (i = [0:2]) {
        rotate([0, 0, i * 180])
            translate([x, y, 0])
                rotate([50, 0, - atan(x / y)])
                    cylinder(r1 = 15, r2 = 7, h = 155, $fn = fn);
    }
}

module x_support() {
    translate([- 20, y - 10, 91])
        rotate([0, - 55, - 9])
            cylinder(r1 = 5, r2 = 3, h = 180, center = true, $fn = fn);
}

module y_support() {
    translate([x, 0, 69])
        rotate([- 40, 0, 0])
            scale([1, 1.4, 1])
                cylinder(r1 = 7, r2 = 3, h = 195, center = true, $fn = fn);
}
module ntb() {
    color("grey", 0.5) translate([0, 15, 113]) rotate([40, 0, 0]) cube([300, 210, 10], center = true);
}

module half_stand() {
    pillars();
    c_supports();
    x_support();
    y_support();
}

difference() {
    // stand mass
    union() {
        half_stand();
        mirror([1, 0, 0]) half_stand();
    }

    // boundaries
    union() {
        for (i = [0:1]) {
            translate([0, 0, i * 10]) ntb();
        }

        translate([0, 0, - 25]) cube([500, 500, 50], center = true);
    }
}

if ($preview) {
    ntb();
}
