include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

$fn=20;

multicase();

/*
difference() {
  cuboid([45, 68, 10], fillet=4, edges=EDGES_Z_ALL, align=V_BOTTOM+V_BACK);
  trezor_safe_5_with_locks();
}
/**/


module lock_right() {
    yrot(180) union() {
        zmove(.2) right_triangle([.6,10,1]);
        cube([.6,10,.2]);
    }
}

module lock_left() {
    mirror([1,0,0]) lock_right();
}

module lock_top() {
    xmove(5) zrot(90) lock_right();
}
module label(l) {   
    move(y=70) linear_extrude(.2) text(l, size=5, halign="center", font="Roboto");
}

module trezor_general(dim1, dim2) {
    f=3;
    
    hull() {
        cuboid(dim1, fillet=f, edges=EDGES_Z_ALL, align=V_TOP+V_BACK);
        ymove(dim1[1]) cuboid(dim2, fillet=f,  edges=EDGES_Z_ALL, align=V_TOP+V_FRONT);
    }
}

module trezor_model_one(dz) {
    h=7.3+dz;
    zmove(-h) hull() {
        trezor_general([17, 58, h], [30.5, 45, h]);
        cuboid([17, 59, h], fillet=3, edges=EDGES_Z_ALL, align=V_TOP+V_BACK);
    }
}

module trezor_model_one_with_locks() {
    difference() {
        union() {
            trezor_model_one(.6);
            translate([0, 37, -10]) cylinder(h=10, r=10, $fn=50);
        }
        translate([15.25, 30, 0]) lock_right();
        translate([-15.25, 30, 0]) lock_left();
        ymove(59) lock_top();
    }
}

module trezor_safe_3(dz) {
    h=7.5+dz;
    zmove(-h) {
        trezor_general([16.5, 59, h], [32.5, 41, h]);
    }
}

module trezor_safe_3_with_locks() {
    difference() {
        union() {
            trezor_safe_3(.6);
            translate([0, 38.5, -10]) cylinder(h=10, r=10, $fn=50);
        }
        translate([16.25, 30, 0]) lock_right();
        translate([-16.25, 30, 0]) lock_left();
        ymove(59) lock_top();
    }
}

module trezor_safe_5(dz) {
    h=8;
    zmove(-h-dz) hull() {
        w1=17.5;
        l1=65;
        w2=38.5;
        l2=42.5;
        trezor_general([w1, l1, h], [w2, l2, h]);
        zmove(h-.1) trezor_general([w1+2, l1+1, .1+dz], [w2+2, l2+2, .1+dz]);
    }
}

module trezor_safe_5_with_locks() {
    difference() {
        union() {
            trezor_safe_5(.6);
            translate([0, 41, -10]) cylinder(h=10, r=10, $fn=50);
        }
        translate([20.25, 49, 0]) lock_right();
        translate([-20.25, 49, 0]) lock_left();
        translate([20.25, 28, 0]) lock_right();
        translate([-20.25, 28, 0]) lock_left();
        ymove(66) lock_top();
    }
}

module plate() {
    x=118;
    y=80;
    
    move(y=y/2, z=-5) hull() {
        cuboid([x, y, 8], fillet=10, edges=EDGES_Z_ALL);
        cuboid([x-2, y-2, 10], fillet=9, edges=EDGES_Z_ALL);
    }
}

module multicase() {
    difference() {
        union() {
            plate();
            xmove(-40) {
                label("Model");
                ymove(-7) label("One");
            }
            xmove(-5) label("Safe 3");
            xmove(35) label("Safe 5");
        }
        xmove(-40)trezor_model_one_with_locks();
        xmove(-5) trezor_safe_3_with_locks();
        xmove(35) trezor_safe_5_with_locks();
    }
}