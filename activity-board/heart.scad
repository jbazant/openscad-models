height=40;
pin_dia=13;
hole_dia=2;

module heart() {
  linear_extrude(5)
      scale([3, 3])
        translate([- 4.25, - 19.3])
        import("./activity-board/assets/heart.svg");
}

module pin() {
  difference() {
    cylinder(d = pin_dia, h = height, $fn=50);
    cylinder(d = hole_dia, h = height+1, $fn=50);
  }
}

union() {
  heart();
  pin();
}