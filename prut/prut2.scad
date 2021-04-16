

module bottom() { 
    translate([0, 0.86, 0]) cylinder(d=4, h=20, $fn=6);
}


module middle() {
     cylinder(d=2, h=90, $fn=6);
}

module top() {
  translate([0,0,92])
  rotate([90,0,0])

  rotate_extrude(convexity=5, $fn=20) 
    translate([2, 0, 0]) 
    circle(d=2, $fn=6);
}

translate([5,-5,5])
rotate([90,0,0]) {
top();
middle();
bottom();
}
