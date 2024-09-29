include <BOSL/constants.scad>
use <BOSL/shapes.scad>

nozzle_width=0.4;
wall_w=4*nozzle_width;

bottom_h=1.6;
stand_bottom=3.4;

$fn=20;
// -------

//wemos_soldering_socket();
soldering_stand();

// --------
module wemos_soldering_socket() {
    l=20.8;
    w=2.35;
    h=8.45;

    li=20;
    wi=0.8;
    hi=1;

    ho=h+hi;
    wo=w+2*wall_w;
    lo=l+2*wall_w;

    socket_w=22.86;

    
    
    module pins() {
        union() {
            translate([0, 0, hi]) union() {
                upcube([l, w, h]);
                translate([0, 0, h*2/3]) hull() {
                    translate([0, 0, -1])upcube([l, w, 1]);
                    upcube([l+2, w, 1]);
                }
                translate([0, 0, h]) hull() {
                    translate([0, 0, -1])upcube([l, w, 1]);
                    upcube([l+2, w+1, 1]);
                }
            }
            upcube([li, wi, hi]);
        }
    }

    module socket_mass() {
        union() {
            hull() {
                cuboid([lo, wo, ho*2/3], edges=EDGES_ALL, align=V_TOP, fillet=1);
                cuboid([lo/2, wo, ho], edges=EDGES_ALL, align=V_TOP, fillet=1);
            }
        }
    }


    difference() {
        union() {
            cuboid([40, 40, bottom_h], edges=EDGES_Z_ALL, align=V_TOP, fillet=4);
            translate([0, socket_w/2, 0]) socket_mass();
            translate([0, -socket_w/2, 0])  socket_mass();

        }
        translate([0, socket_w/2, 0]) pins();
        translate([0, -socket_w/2, 0]) pins();
        cuboid([lo, socket_w-wo, bottom_h], edges=EDGES_Z_ALL, align=V_TOP, fillet=1);
        
        for (rz=[0 : 90 : 359]) {
            rotate([0, 0, rz]) translate([16, 16, 0]) union() {
                translate([0, 0, .4]) cylinder(r=1.6, h=bottom_h-.8);
                hull() {
                    translate([0, 0, .4]) cylinder(r=1.6, h=.1);
                    translate([0, 0, -.1]) cylinder(r=1.8, h=.1);
                }
                hull() {
                    translate([0, 0, bottom_h-.5]) cylinder(r=1.6, h=.1);
                    translate([0, 0, bottom_h]) cylinder(r=1.8, h=.1);
                }
            }
        }
    }
}

module soldering_stand() {
    h=10.5;
    
    difference() {
        union() {
            for (rz=[0 : 90 : 359]) {
                rotate([0, 0, rz]) translate([16, 16, 0]) {
                    cylinder(r=1.5, h=h+.5+stand_bottom+bottom_h);
                    cylinder(r=4, h=h+stand_bottom);
                }
            }
            for (rz=[45 : 90 : 270]) {
                rotate([0, 0, rz]) upcube([sqrt(2*32*32), 8, stand_bottom]);
            }
            upcube([20, 20, stand_bottom]);
        }
        translate([5, 5, .4]) cylinder(d=8.2, h=2.2, $fn=20);
        translate([-5, -5, .4]) cylinder(d=8.2, h=2.2, $fn=20);
    }
}

