module brim() {
  rotate_extrude(360, $fn=100) 
  translate([9.5, 0])
   circle(.5, $fn=100);
}

module small_brim() {
  rotate_extrude(360, $fn=100) 
  translate([9.5, 0])
   circle(.2, $fn=100);
}

module bottom() {
  hull() {
    cylinder(d=19, h=3, $fn=100);
    translate([0,0,2]) cylinder(d=21.5, h=1, $fn=100); 
  };
}

module body() {
  union() {
    hull() {
      cylinder(d=19, h=17, $fn=100);
      cylinder(d=18, h=18, $fn=100); 
    };
    translate([0,0,3]) cylinder(d=19.5, h=2, $fn=100);
  }
}

module wall() {
  translate([0,0,2]) difference() {
    cylinder(d=18, h=1, $fn=100);
    cylinder(d=11.5, h=1, $fn=100);
  };
}

module pillar() {
  translate([-.4,-19/2,3]) hull() {
    cube([.8, 2, 5]);
    cube([.8, 1, 7]);
  }
}
  

union() {
  difference() {
    union() {
      body();
      bottom();

      translate([0,0,7]) small_brim();
      translate([0,0,8.5]) brim();
      translate([0,0,10]) small_brim();
      
    }
    cylinder(d=17, h=19, , $fn=100); 
  }
  wall();
  for(i=[0:60:360]) {
    rotate([0,0,i]) pillar();
  }
}
    