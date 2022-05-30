h=10;
delta=0.1;
top_clearance=0.4;

module pylon(d, t) {
  cylinder(h=h + t, r=10 + d, $fn=3);
}


module mass() {
  translate([0, -40, 0]) cube([10, 80, h + 2]);
}

module t(d, t) {
  translate([10,0,1]) rotate([90,0,90])linear_extrude(0.5) text(str(d, " - ", t), halign="center", size=h);
}

module side_a() {
  union() {
    mass();
    for (y=[-30,0,30]) {
      translate([0, y, 0]) pylon(0, 0);
    }
  }
}

module side_b(d, t) {
  union() {
    t(d, t);
    difference() {
      mass();
      for (y=[-30,0,30]) {
        translate([0, y, 0]) rotate([0,0,180])
          pylon(d, t);
      }
    }
  }
}


side_a();
translate([-20, 0, 0]) side_b(delta, top_clearance);
