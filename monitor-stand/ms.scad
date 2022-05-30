

    
  module lock_pillar(d, t) {
    rotate([0,0,180]) cylinder(h=75 + t, r=10 + d, $fn=3);
  }

  module lock(d, t) {
    color("purple") translate([-55, -0,0]) 
    for (y=[-80:40:80]) {
      translate([0, y, 0])
        lock_pillar(d, t);
    }
  }
  
module monitor_stand(lock_as_hole=true) {
  module base_bottom_basic() {
    union() {
      for (i = [11:8:115]) {
        difference() {
          translate([0,0,-1]) cylinder(1.4, r=i, $fn=50);
          translate([0,0,-2])cylinder(3, r=i-2, $fn=50);
        }
      }
    }
  }
    
  module base_bottom_a() {
    difference() {
      base_bottom_basic();
      translate([(250/2 - 100),-50,-2]) cube([100,100, 3]);
      translate([-345, -150, -2]) cube([300, 300, 3]);
    }
  }
  
  module base_bottom_b() {
    difference() {
      base_bottom_basic();
      translate([-65, -150, -2]) cube([300, 300, 3]);
    }
  }
  
  module base() {
    difference() {
      union() {
        cylinder(90, d2=238, d1=250, $fn=200);
        mobile_stand();
      }
      translate([0,0,90-8.5]) cylinder(10, d=238-2*9.5, $fn=200);
      translate([0,0,90]) cylinder(20, d=300);
    }
  }


  
  module as_hole(z) {
    color("red") 
    translate([0,125,z])
    rotate([100,0,0])
    children();
  }

  module stickers() {
    color("blue") translate([(250/2 - 90),-40,0]) hull() {
      cube([90,80, 20]);
      translate([89, 0, 0]) cube([1,80, 50]);
    }
  }

  module cables(z=60) {
    as_hole(z)
    cylinder(102,d=25, , $fn=100);
  }

  module labelo(z=60) {
    as_hole(z)
    cylinder(52, d=20, , $fn=50);
  }
  
  module pen(z=30) {
    as_hole(z)
    scale([1,17/14,1])
    cylinder(h=110, d=14, $fn=50);
  }
  
  module cable_clip() {
    color("magenta")
    translate([0,-124,12])
    rotate([20,0,0])
    rotate([0,-90,0])
    translate([0,0,-1.5])
    difference() {
      union() {
        hull() {
          translate([12,3,0]) cylinder(3, r=2, $fn=50);
          translate([-20,-5,0]) cube([1,10,3]);

        }
        hull() {
          translate([12,-3,0]) cylinder(3, r=2, $fn=50);
          translate([-20,-5,0]) cube([20,10,3]);
        }
      }
      
      hull() {
        translate([4,0,0]) cylinder(5, r=1, $fn=50);
        translate([20,0,0]) cylinder(5, r=1);
      }
      translate([8,0,0]) cylinder(5, r=1.5, $fn=50);
    }
  }
  
    module cable_clip_big() {
    color("magenta")
    translate([0,-124,12])
    rotate([20,0,0])
    rotate([0,-90,0])
    translate([0,0,-1.5])
    difference() {
      union() {
        hull() {
          translate([12,3,0]) cylinder(3, r=1, $fn=50);
          translate([-20,-5,0]) cube([1,10,3]);

        }
        hull() {
          translate([12,-3,0]) cylinder(3, r=1, $fn=50);
          translate([-20,-5,0]) cube([20,10,3]);
        }
      }
      
      hull() {
        translate([4,0,0]) cylinder(5, r=2, $fn=50);
        translate([20,0,0]) cylinder(5, r=2);
      }
      translate([8,0,0]) cylinder(5, r=3, $fn=50);
    }
  }

  module cable_clips() {
    rotate([0,0, 50]) cable_clip();
    rotate([0,0, 130]) cable_clip();

    rotate([0,0, 230]) cable_clip_big();
    rotate([0,0, 310]) cable_clip_big();
  }
  
  module as_cube_hole(z) {
    color("red")
    rotate([-4,0,0])
    translate([0,-120,z])
    children();
  }
  
  module usb(z) {
    as_cube_hole(z) 
      rotate([0,90,0])
      translate([-6.1, -5.5, 0]) union() {
      cube([12.2, 11, 4.7]);
      hull() {
        translate([-1,0,-1]) cube([14,1,6.5]);
        translate([0,3, 0]) cube([12.2, 0.1, 4.7]);
      }
    }
  }
  
  module sd(z, zd=0) {
    as_hole(z)
      translate([0, 0, 13 - zd])
        cube([2.5, 25, 32], center=true);
  }
  
  module msd(z, zd=0) {
    as_hole(z)
      translate([0,0,5+zd])
        cube([1,11.5,15], center=true);
  }
  
  module mobile_stand_pillar() {
  rotate([20,0,0])
  difference() {
    union() {
      translate([-17.5/2, -15,0]) cube([17.5,15,45]);
      
      hull() {
        translate([0,14,7]) 
         rotate([-90,0,0]) 
         for(x=[-1, 1])
         translate([x*11.5/2, 0, 0]) 
         cylinder(h=3, r=3, $fn=20);
         
        translate([-17.5/2,14,3]) 
         rotate([0,90,0])
         cylinder(h=17.5, r=3, $fn=8);
       }
         
       translate([-17.5/2, 0, 0]) cube([17.5, 14, 6]);
    }

    hull() {
      for (y=[.5, 13.5])
        for(z=[3.5, 20])
          translate([-10,y,z])
          rotate([0,90,0])
            cylinder(h=20, r=.5, $fn=10);
      }
  }
}

  module mobile_stand() {
  rotate([0,0,-90])
  translate([0, 132, 53])
  for(i=[-1,1])
  translate([i*(50-17.5/2)/2, 0, 0])
  mobile_stand_pillar();
}

  module side_hole(w, l) {
    union() {
      hull() {
        for(i = [w/2, -w/2]) {
          for (j =[120-l, 110]) {
            for (k =[10, 70-(l/2)]) {
              translate([i, j, k]) sphere(5);
            }
          }
        }
      }
      difference() {
        hull() {
          for(i = [w/2, -w/2]) {
            translate([i, 120-l, 15]) sphere(5);
            translate([i, 120-l, 70-(l/2)]) sphere(5);
            translate([i, 130, 75]) sphere(5);
            translate([i, 130, 15]) sphere(5);
          }
          
        }
        translate([-75, 10, 5]) cube([150, 150, 10]);
      }
    }
  }


  difference() {
    union() {
      difference() {
        base();
        stickers();
        rotate([0,0,-130]) cables();
        rotate([0,0,-50]) labelo();
        rotate([0,0,-33]) union() {
          pen();
          pen(50);
          pen(70);
        };
        
        for (i=[14, 23 , 32]) {
          rotate([0,0,i]) union() {
            usb(15);
            usb(35);
            usb(55);
          };
        }
        
        for(i = [18,23]) rotate([0,0,-i]) {
          sd(63);
          sd(27, 3);
        }

        rotate([0,0,-10]) {
          msd(70,3);
          msd(53,2);
          msd(36,1);
          msd(20);
        }
      
        rotate([0,0,170]) side_hole(50, 110);
        rotate([0,0,10]) side_hole(40, 80);
      };
      cable_clips();
    }
    base_bottom_a();
    base_bottom_b();
  }
}

module resultA() {
  intersection() {
    translate([-55, -125,0]) cube([210,250,210]);
    difference() {
      monitor_stand();
      lock(.1,.4);
    }
  }
}

module resultB() {
    union() {
      lock(0,0);
      difference() {
        monitor_stand();
        translate([-55, -125,0]) cube([210,250,210]);
        translate([0,0,-50]) cube([500,500,100], center=true);
      }
  }
}


//monitor_stand();
//resultA();
resultB();



