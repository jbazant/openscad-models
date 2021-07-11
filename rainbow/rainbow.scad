use<./models.scad>

module rainbow_toy() {
  mass_r = 110;
  mass_h = 16;

  hole_r = 10.5;
  holes_space = 2;
  hole_deep_percent = .33;

  hole_deep_correction = (.5 - hole_deep_percent) * hole_r * 2;


  function one_color_r(step) = mass_r - (2 * step + 1) * (hole_r + holes_space);

  function one_color_cnt(step) = 13 - ceil(PI * step);

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
      rotate([0, 0, i])
        translate([r, 0, hole_deep_correction])
          sphere(r = hole_r, $fn = 50);
    }
  }

  union() {
    difference() {
      body_mass_rounded();
      for (i = [0:3]) {
        one_color(one_color_cnt(i), one_color_r(i));
      }
    }
    scale([1, 1, .5]) logoC();
  }
}

rainbow_toy();
