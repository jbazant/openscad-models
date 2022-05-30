
d_inner=17;
width=5;

module ring(r_inner, w) {
  r_ring=w/2;
  r_mid=r_inner + r_ring;
  
  rotate_extrude(angle=360, $fn=100) 
   translate([r_mid, 0]) 
    circle(r=r_ring, $fn=100);
}


difference() {
  ring(d_inner/2, width);
  translate([0, 0,-5])    cube([100, 100, 10], center=true);  
}