precision = 20;

module hvezda_a(d, vertex_count = 5) {
    angle = 360 / vertex_count;

    function getPointR(x) = x % angle == 0 ? d : d / 2;
    function getPoint(x) = [getPointR(x) * cos(x), getPointR(x) * sin(x)];
    polygonPoints = [for (x = [0:angle / 2:360]) getPoint(x)];

    linear_extrude(1, center = true)
        polygon(polygonPoints);
}

module cip(r1, r2) {
    cylinder(d1 = 1, d2 = 0, h = 2, $fn=3);
    rotate([180, 0, 0])cylinder(d1 = 1, d2 = 0, h = 2, $fn=3);

    linear_extrude(0.2, center = true)
        polygon([
                [r1, 0],
                [0, r2],
                [0, - r2],
            ]);
}

module hvezda_b(d, vertex_count = 5) {
    angle = 360 / vertex_count;

    for (dz = [0:angle:360]) {
        rotate([0, 0, dz]) hull() cip(d / 2, d / 6);
    }
}

module hvezda_c(d, vertex_count = 4) {
    angle = 360 / vertex_count;
    angle2 = 2*angle;

    for (dz = [0:angle2:360]) {
        rotate([0, 0, dz]) hull() cip(d / 2, d / 12);
    }
    rotate([0, 0, angle]) {
        for (dz = [0:angle2:360]) {
            rotate([0, 0, dz]) hull() cip(d / 4, d / 12);
        }
    }
}

module hvezda_d(d, vertex_count = 4) {
    angle = 360 / vertex_count;
    angle2 = 2*angle;

    for (dz = [0:angle2:360]) {
        rotate([0, 0, dz]) hull() cip(d / 2, d / 12);
    }

    rotate([0, 0, angle]) {
        for (dz = [0:angle2:360]) {
            rotate([0, 0, dz]) hull() cip(d / 3, d / 8);
        }
    }
}

module mesic(d) {
    difference() {
        scale([1, 1, 4 / d]) sphere(d = d, $fn = precision);
        translate([d / 2, 0, 0]) sphere(d = d, $fn = precision);
    }
}

module kometa() {
}

difference() {
    translate([0, 0, - 1]) cube([40, 40, 2], center = true);
    //mesic(10);
    hvezda_d(20,10);
}
