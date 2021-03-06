union() {
translate([33.5,0,31]) 
  color("blue") 
  scale([0.4, 1, 1]) {
    cylinder(d1=3.6, d2=3, h=7, $fn=20);
    translate([0,0,7]) scale([1,1,0.6]) sphere(d=3, $fn=20);
  }
translate([-36.8,-3.05,31]) color("blue") cube([4,6.1,4.1]);
  rotate_extrude(angle=360, $fn=200) 
  rotate(90) polygon([
  [0,0],
  [0,33],
  [3,35],
  [31,36.8],
  [31,33.8],
  [41,33.8],
  [41,33.2],
  [40,32.7],
  [39,32.4],
  [38,32.3],
  [6,30.6],
  [5,30.3],
  [4, 29.5],
  [3.5, 28.8],
  [3,27.6],
  [3,0]
]);
}