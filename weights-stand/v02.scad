r_c=145/2;
r_s=25/2;
r_w=r_c+r_s;
r_m=15;
min_delta=3;

module main_mass() {
    minkowski() {
        translate([0,0,10]) cube([220, 8*r_s+4, 20], center=true);
        sphere(r=3, $fn=8);
    }
}

module hole() {
    t_y=r_w;
    
    union() {
        translate([0,0,t_y]) rotate([90,0,0]) union() {        
            minkowski() {
                cylinder(r=r_c, h=1, center=true, $fn=100);
                sphere(r=r_s);
            }
            
            /*
            hull() {
                cylinder(r=r_c-20, h=1, center=true, $fn=100);
                sphere(r=r_s+4);
            }
            */
        }
    }
}

difference() {
    main_mass();
    translate([-(r_w + r_m)/2 - 2, -3*r_s, 0]) hole();
    translate([(r_w + r_m)/2 + 2, 3*r_s, 0]) hole();
}
