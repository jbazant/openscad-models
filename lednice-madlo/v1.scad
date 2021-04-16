

module half() {
    // main mass
    module s(t) {
        translate(t) translate([1,1,1]) sphere(r=1, $fn=20);
    }

    difference() {
        union() {
            hull() {
                s([0,-1,0]);
                s([20,-1,0]);
                s([20,45,0]);
                s([0,45,0]);
            }
            hull() {
                s([0,-1,0]);
                s([0,-1,43]);
                s([0,45,43]);
                s([0,45,0]);
            }
        }
        color("red") translate([22-4.2,-1,0]) cube([4.2,4,2]);
    }
    
    // inner socket
    color("purple") translate([1, 10.6,1]) {
      cube([5.4,1.2,26.5]);
     translate([5.4-1.8,-1.2,0]) cube([1.8,1.8,26.5]);
    }

    // outer socket
    translate([1,31.3,1])
     difference() {
       color("blue") hull() {
        cube([11,2.6,12]);
        translate([15.5,0,0]) cube([1,2.6,1]);
        translate([16.5-5.2, 0, 12-5.2]) rotate([-90,0,0]) cylinder(r=5.2,h=2.6, $fn=40);
       }
       hole_dia=4.3;
       color("red") translate([8.5+hole_dia/2, 0, 4.5+hole_dia/2])
        rotate([-90,0,0])
        cylinder(d=4.3,h=2.6, $fn=40);
     };

    // rest
     color("green")
      translate([0,33.5,0]) 
      hull() {
        translate([0,0,16]) cube([7,5.5,1.3]);
        translate([0,2.25,12]) cube([1,1,1]);
      }
}

half();
mirror([0,1,0]) half();        
