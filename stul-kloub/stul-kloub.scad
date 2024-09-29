include <BOSL/constants.scad>
use <BOSL/shapes.scad>

d_inner=16.8;
d_outer=23.4;
h_inner=28.75;
r_ankle=28.5;
r_ankle2=r_ankle-d_outer;
ty_ankle=51.6-r_ankle-d_outer/2;
tx_ankle=-d_outer/2-r_ankle2;

x_insert=25;
y_insert=21;
z_insert=22.5;
t_insert=r_ankle2+d_outer/2;

$fn=50;


module joint() {
    difference() {
        union() {
            cylinder(d=d_outer, h=h_inner+3);
            translate([-d_outer/2, 0]) cube([d_outer, ty_ankle, h_inner]);
        }
        translate([0,0,3+1]) cylinder(d=d_inner, h=h_inner+1);
 
    }
}



module ankle() {
    intersection() {
        difference() {
            cylinder(r=r_ankle, h=h_inner);
            translate([0,0,-1]) cylinder(r=r_ankle2, h=h_inner+2);
        }
        cube(h_inner);
    }
}

module insert() {
    translate([x_insert/2 ,y_insert/2, z_insert/2]) difference() {
        cuboid([x_insert,y_insert, z_insert], chamfer=3);
        rotate([90, 0, 0]) union() {
            hull() {
                translate([0,0, -y_insert/2-1]) cylinder(h=1, d=9, center=true);
                translate([0,0, -y_insert/2+1]) cylinder(h=1, d=7, center=true);
            }
            cylinder(h=y_insert+2, d=7, center=true);
            hull() {
                translate([0,0, y_insert/2+1]) cylinder(h=1, d=9, center=true);
                translate([0,0, y_insert/2-1]) cylinder(h=1, d=7, center=true);
            }
        }
    }
    translate([x_insert-1, y_insert/2, z_insert/2]) cuboid([10,y_insert, z_insert], chamfer=3);
}
    
module left() {
    joint();
    translate([tx_ankle, ty_ankle, 0]) ankle();
    translate([-(t_insert+x_insert), t_insert+0.75, 4]) insert();
}

module right() {
    mirror([1,0,0]) left();
}

//left();
right();
//insert();