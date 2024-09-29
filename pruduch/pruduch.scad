include <BOSL/constants.scad>
use <BOSL/shapes.scad>

/* [Hole settings] */
// width of the wall to mount cover to
h_wall=15; //[::non-negative float]
// Outer diameter of cover (diameter of hole in the wall)
d_outer=54; //[::non-negative float]

/* [Lock settings] */
// Width of a lock wall
outer_wall=1.6; //[::non-negative float]
// overhang of outer wall on the top
lock_overhang=1.2; //[::non-negative float]


/* [Grid settings] */
// Thickness of blades
thin_wall=0.8; //[::non-negative float]
// blade length
blade_l=10; //[::non-negative float]
//angle of blades
blade_angle=45; //[::non-negative integer]
//whether to generate transom across the blades
generate_transom=true;//[::boolean]
// Diameter of grid hole
d_inner=d_outer - 6; //[::non-negative float]

/* [Front] */
// diameter of front face
d_front=d_outer + 8;  //[::non-negative float]

$fn=$preview ? 50 : 200;

module tube_lock(d_outer, wall, inner_height, lock_overhang, lock_straight_h=0) {
    lock_h1=cos(60)*lock_overhang;
    lock_h2=cos(30)*(lock_overhang + wall/2);
    d_lock=d_outer+2*lock_overhang;
    d_inner=d_outer-2*wall;
    
    translate([0,0,0]) tube(h=lock_h1, id=d_inner, od1=d_outer, od2=d_lock);
    translate([0,0,lock_h1]) tube(h=lock_straight_h, id=d_inner, od=d_lock);
    translate([0,0,lock_h1+lock_straight_h]) tube(h=lock_h2, id=d_inner, od1=d_lock, od2=d_outer-wall);
}

module insertable_tube(d_outer, wall, inner_height, lock_overhang) {
    difference() {
        union() {
            tube(h=inner_height, od=d_outer, wall=outer_wall);
            translate([0,0,inner_height]) tube_lock(d_outer, wall, inner_height, lock_overhang, .4);
        }
        translate([0,0,inner_height + 2]) for (rz=[0:60:180]) {
           rotate([0,0,rz]) cube([1,3*d_outer,2*inner_height], center=true); 
        }
    }
}

module grid(d_inner, wall, blade_l, blade_angle, transom) {
    module blade() {
        rotate([0,blade_angle,0]) translate([0,0,blade_l/2]) cube([wall, d_inner, blade_l], center=true);
    }
    
    module grid_ring() {
        tube(h=blade_l*cos(blade_angle), id=d_inner, wall=wall);
    }

    color("red") union() {
        intersection() {
            union() {
                 for(dx=[-d_inner/2 - wall*sin(blade_angle) : 7 : d_inner/2]) {
                    translate([dx, 0, 0]) blade();
                }
            }
            // todo assert
            cylinder(d=d_inner, h=blade_l*cos(blade_angle));
            
        }
        if (transom) {
            translate([-d_inner/2, 0, 0]) cube([d_inner, wall, blade_l*cos(blade_angle)]);
        }
        grid_ring();
    }
}

module front(h, d_inner, d_outer) {
    color("blue") tube(h=h, id=d_inner, od1=d_outer-2*h, od2=d_outer);
}


insertable_tube(d_outer, outer_wall, h_wall, lock_overhang);
translate([0,0,-outer_wall]) {
    grid(d_inner, thin_wall, blade_l, blade_angle, generate_transom);
    front(outer_wall, d_inner,d_front);
}