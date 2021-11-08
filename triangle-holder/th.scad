top_translate = [0, 26, 0];
//
difference() {
  union() {
    hull() {
      translate(top_translate) cylinder(d = 9.4, h = 3, $fn = 50);
      translate([- 8, 0, 0]) cube([16, 3, 3]);
    }
    translate(top_translate) cylinder(d = 9.4, h = 5, $fn = 50);
    translate([- 8, 0, 0]) cube([16, 3, 16]);
  }
  translate(top_translate)  cylinder(d = 6.2, h = 6, $fn = 50);
  translate([0, 0, 9.5]) rotate([- 90, 90, 0]) cylinder(r2 = 3, , r1 = 1, h = 3, $fn = 6);
}