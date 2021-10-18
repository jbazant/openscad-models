height = 85;
round_r = 10;
fn=100;
offsets=[55, 55, 45, 45 ,45, 25, 25, 5, 5, 5];

difference() {
  hull() {
    translate([0 + round_r, 0 + round_r, 0]) cylinder(h = height, r = round_r, $fn=fn);
    translate([250 - round_r, 0 + round_r, 0]) cylinder(h = height, r = round_r, $fn=fn);
    translate([250 - round_r,115 - round_r, 0]) cylinder(h = height, r = round_r, $fn=fn);
    translate([0 + round_r,115 - round_r, 0]) cylinder(h = height, r = round_r, $fn=fn);
  }

  for(j= [0:1]) {
    for (i = [0:4]) {
      translate([i * 49, j*55, offsets[i+j*5]]) hull() {
        translate([10, 10, 0]) cylinder(h = height, r = round_r / 2, $fn = fn);
        translate([45, 10, 0]) cylinder(h = height, r = round_r / 2, $fn = fn);
        translate([45, 50, 0]) cylinder(h = height, r = round_r / 2, $fn = fn);
        translate([10, 50, 0]) cylinder(h = height, r = round_r / 2, $fn = fn);
      }
    }
  }
}