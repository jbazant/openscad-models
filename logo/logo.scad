use<../utils/sierpinski-triangle.scad>

module outer() {
  difference() {
    circle(d = 20, $fn=100);
    circle(d = 16, $fn=100);
    for(i=[-75:30:15]) {
      rotate(-i) translate([10, 0]) square([20, 2], center = true);
    }
  }
}

module inner2d() {
  rotate(60) sierpinsky_triangle(15, 3, .1);
}

module inner3d(w) {
  rotate(60) sierpinsky_triangle_multilayer(w, 15, 4, 0);
}

module logo2d() {
  union() {
    outer();
    inner2d();
  }
}


module logo3d(w1 = 3, w2 = 1) {
  translate([0,0,-w1/2]) linear_extrude(w1) outer();
    inner3d(w2 / 2);
    rotate([0, 180, 0]) inner3d(w2 / 2);
}

rotate(60) sierpinsky_triangle(180, 3, .1);
* logo2d();
* logo3d(3, 2);
