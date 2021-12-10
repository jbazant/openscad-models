
module heart() {
  linear_extrude(5)
      scale([3, 3])
        translate([- 4.25, - 19.3])
        import("./activity-board/assets/heart.svg");
}

module pin() {
  difference() {
    cylinder(d = 13, h = 25, $fn=50);
    cylinder(d = 2, h = 26, $fn=50);
  }
}

union() {
  heart();
  pin();
}