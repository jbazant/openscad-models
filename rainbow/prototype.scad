use<./models.scad>

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

module logo_proto() {
  one = 30;
  half = one / 2;

  union() {
    difference() {
      translate([- half, - half, - 3]) cube([2 * one, 2 * one, 3]);
      logoA();
      translate([one, 0, 0]) logoB();
    }
    translate([0, one, 0]) logoC();
    translate([one, one, 0]) scale([1, 1, .5])logoC();
  }
}

logo_proto()
*rainbow_proto();

