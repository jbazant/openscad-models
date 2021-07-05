module rainbow_toy() {
  mass_r = 110;
  mass_h = 16;

  hole_r = 10;
  holes_space = 2;

  module body_mass() {
    union() {
      difference() {
        cylinder(r = mass_r, h = mass_h / 5, $fn = 100);
        translate([- mass_r, - mass_r, - 1])
          cube([2 * mass_r, mass_r, mass_h / 5 + 2]);
      }
      translate([- mass_r, - hole_r, 0])
        cube([2 * mass_r, hole_r, mass_h / 5]);
    }
  }

  module body_mass_rounded() {
    translate([0, 0, - 3 * mass_h / 5])
      minkowski() {
        body_mass();
        sphere(r = 2 * mass_h / 5, $fn = 50);
      }
  }

  module one_color(cnt, r) {
    delta = 180 / cnt;
    for (i = [0: delta : 181]) {
      rotate([0, 0, i]) translate([r, 0, 0]) sphere(r = hole_r, $fn = 50);

    }
  }

  function one_color_r(step) = mass_r - (2 * step + 1) * (hole_r + holes_space);

  function one_color_cnt(step) = 13 - ceil(PI * step);

  difference() {
    body_mass_rounded();
    for (i = [0:3]) {
      one_color(one_color_cnt(i), one_color_r(i));
    }
  }
}

module rainbow_proto() {
  hole_r = 10;
  mass = hole_r * 2;
  vert = hole_r * 1.7;
  mass_clearance = mass + 2;


  module one_hole(deep) {
    txt = str(deep * 100, "%");
    v = (mass / 2 + vert / 2);

    difference() {
      translate([0, 0, - v])cube([mass_clearance, mass_clearance, vert], center = true);
      translate([0, 0, - deep * hole_r * 2]) {
        cylinder(r = hole_r, h = hole_r, $fn = 50);
        sphere(r = hole_r, $fn = 50);
      }
    }
    color("red")
      translate([0, - mass_clearance / 2, - v])
        rotate([90, 0, 0])
          linear_extrude(0.5)
            text(txt, 6, valign = "center", halign = "center");
  }

  module sample(v, s) {
    for (i = [0:s - 1]) {
      translate([i * mass_clearance, 0, 0])
        one_hole(v[i]);
    }
  }

  sample([.20, .33, 0.5, .66], 4);
}

rainbow_proto();
*rainbow_toy();
