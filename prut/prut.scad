

module bottom() {
    difference() {
        cylinder(d=4, h=20, $fn=20);
        translate([0,0,10]) cylinder(d=2.1, h=10, $fn=6);
    }
}


module middle() {
    translate([0, -1.5, 0]) 
     rotate([90, 0, 0]) 
     cylinder(d=2, h=100, $fn=6);
}

module top() {
  rotate_extrude(convexity=5, $fn=20) 
    translate([2, 0, 0]) 
    circle(d=2, $fn=6);
}

translate([0, 0, 0.9]) {
    top();
    middle();
}
translate([0, 5.1, 0]) bottom();
