$fn=100;

module side_hole() {

  translate([0.75, -1.3, 24.5]) {
    cube([10, 10, 2.8]);
    cube([10, 2.6, 2.8+1.3]);
  }
}
  
difference() {
  union() {
    cylinder(h=24.5+8.5,d=4.7);
    cylinder(h=3,d=7.7);
    translate([0,0, 5]) cylinder(h=2.3,d=9.7);
  }
  
  union() {
    translate([-5,0,24.5+2.8+1.3]) 
      rotate([0,90,0]) 
      cylinder(h=10, d=2.6);
    
    side_hole();
    mirror([1,0,0]) side_hole();
  }
}