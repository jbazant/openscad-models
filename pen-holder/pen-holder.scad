use<../b-coins/includes/models.scad>

height = 85;
round_r = 10;
fn = 50;
offsets = [55, 55, 45, 45, 45, 25, 25, 5, 5, 5];

module body() {
  module cyl(r) {
    cylinder(h = height, r = r, $fn = fn);
  }

  difference() {
    hull() {
      translate([0 + round_r, 0 + round_r, 0]) cyl(round_r);
      translate([250 - round_r, 0 + round_r, 0]) cyl(round_r);
      translate([250 - round_r, 115 - round_r, 0]) cyl(round_r);
      translate([0 + round_r, 115 - round_r, 0]) cyl(round_r);
    }

    for (j = [0:1]) {
      for (i = [0:4]) {
        translate([i * 49, j * 55, offsets[i + j * 5]]) hull() {
          translate([10, 10, 0]) cyl(round_r / 2);
          translate([45, 10, 0]) cyl(round_r / 2);
          translate([45, 50, 0]) cyl(round_r / 2);
          translate([10, 50, 0]) cyl(round_r / 2);
        }
      }
    }
  }
}

module deco() {
  module flw(t, s) {
    translate(t) rotate([90, 0, 0]) translate([20, 10, 0]) flower2(s);
  }

  color("blue") {
    flw([10, 0, 10], 50);

    flw([40, 0, 18], 100);
    flw([36, 0, - 2], 200);
    flw([52, 0, - 1], 150);
    flw([73, 0, 0], 160);
    flw([60, 0, 10], 180);
    flw([90, 0, - 3], 200);

    flw([2, 0, 40], 100);
    flw([0, 0, 65], 180);
    flw([8, 0, 55], 200);
    flw([22, 0, 37], 160);
  }
}

body();
deco();