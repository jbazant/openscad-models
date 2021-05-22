fn = 50;

translate([6, 0, 0]) union() {
  // leg
  cylinder(d = 3, h = 18, $fn = fn);

  // head
  difference() {
    translate([0, 0, 15]) union() {
      sphere(d = 10, center = true, $fn = fn);
      translate([0, 0, - 2]) cylinder(d = 10, h = 2, $fn = fn);
      translate([0, 0, - 2]) sphere(d = 10, center = true, $fn = fn);
    }
    // hole from the bottom
    cylinder(d = 8, h = 16, $fn = fn);
    // make sure that leg is exactly 11mm long
    cylinder(d = 30, h = 11, $fn = fn);
  }
}