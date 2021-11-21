module pipe_holder() {
  d_inner = 85;
  thickness = 3;
  d_outer = d_inner + 2*thickness;
  h = 10;
  support_w = 10;

  module screw_hole() {
    translate([0, 0, h / 2]) rotate([0, -90, 0]) cylinder(r2 = 3, , r1 = 1, h = 3, $fn = 6);
  }

  module mass() {
    difference() {
      union() {
        cylinder(d = d_outer, h = h, $fn = 100);
        translate([0, - d_outer / 2]) cube([d_outer / 2, d_outer, h]);
        translate([d_outer / 2 - thickness, d_outer / 2, 0]) cube([thickness, support_w, h]);
        translate([d_outer / 2 - thickness, - d_outer / 2 - support_w, 0]) cube([thickness, support_w, h]);
      }
      translate([0, 0, - 1]) union() {
        cylinder(d = d_inner, h = h + 2, $fn = 100);
        translate([0, - d_inner / 2]) cube([d_outer / 2 + 1, d_inner, h + 2]);
      }
    }
  }

  difference() {
    mass();
    translate([d_outer / 2, d_outer / 2 + support_w / 2, 0]) screw_hole();
    translate([d_outer / 2, -(d_outer / 2 + support_w / 2), 0]) screw_hole();
  }
}

pipe_holder();