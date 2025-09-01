
difference() {
    union() {
        difference() {
            cube([17, 15.6, 1.2]);
            translate([0, 10, 0]) 
              scale([0.02, 0.02, 1]) 
              linear_extrude(1.2) 
              import("./hands2.svg");
        }

        difference() {
            cube([17, 15.6, 2]);
            translate([0, 10, 0]) 
              scale([0.02, 0.02, 1]) 
              linear_extrude(2) 
              import("./hands.svg");
        }
    }
    
    translate([8,8,0]) cylinder(h=.6, d=2.1, $fn=40);
}