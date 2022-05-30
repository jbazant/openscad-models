



  
module b() {
  rotate([90, 0, 0]) difference() {
    cylinder(h=2, r=12);
    cylinder(h=2, r=10);
  }
}

module c() {
  translate([0,0,2]) rotate([0, 90, 0]) cylinder(h=100, r=1, center=true, $fn=20);
}

module a() {
  scale([1, .8, .5]) difference() {
  sphere(20, $fn=9);

  translate([0,0,37])
    rotate([10, 30, 55]) 
    cube([100, 100, 30], center=true);
  translate([16,0,37])
    rotate([30, 55, 15]) 
    cube([100, 100, 30], center=true);
  translate([-16,0,40])
    rotate([-130, -15, -15]) 
    cube([100, 100, 30], center=true);
    
  translate([0,0,-15])
    cube([100, 100, 30], center=true);
  }
}

difference() {
  a();
  c();
}