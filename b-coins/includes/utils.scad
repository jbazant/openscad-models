include<./config.scad>

module coin_base(fn = fn, outline_width = 2) {
  if (!$preview || preview_bottom) {
    translate([0, 0, - bottom_h]) color("aqua")
      cylinder(r = r, h = bottom_h, center = false, $fn = fn);
  }

  difference() {
    cylinder(r = r, h = top_h, center = false, $fn = fn);
    // translate and +2 height just for better preview
    translate([0, 0, - 1])  cylinder(r = r - outline_width, h = top_h + 2, center = false, $fn = fn);
  }
}

module clear_fix() {
  difference() {
    // translate and +2 height just for better preview
    translate([0, 0, top_h / 2])cube([3 * r, 3 * r, top_h + 2], center = true);
    translate([0, 0, - 1]) cylinder(r = r - 1, h = top_h + 2);
  }
}

module simple_coin(fn = fn, outline_width = 2) {
  union() {
    coin_base(fn);
    difference() {
      children();
      clear_fix();
    }
  }
}