include <BOSL/constants.scad>
use <BOSL/threading.scad>

/* [user settings] */
// Diameter of cards + some reserve
d_inner=86;

// Height of stack + at least 3mm
h_inner=22; 

// height of thread
h_inner_top=7.5; 

// bottom wall (and top -0.4)
wall=1.2; 

// diameter of hole in the bottom. Set to 0 for no hole.
d_finger_hole=18;

// non-threading cylinder at the bottom of thread
h_mid=3; 

/* [stoppers] */
// wheter to generate stoppers
use_stoppers=true;

// stoppers (those dots) should be nearly in the corner for best effect
stopper_offset=5; 

/* [thread settings] */
// Pitch
pitch=3;

// Thread angle
thread_angle=30;

// Starts
starts=3;

/* [computed values] */
d_outer=d_inner+2*(pitch+2);
d_mid=(d_inner+d_outer)/2;
h_inner_bottom=h_inner-h_inner_top;

/* [general] */
// Precision
$fn=$preview ? 30 : 100;

module hex(d, h) {
    module regular_hexagon(r) {
        points = [ for (i = [0:5]) 
            [r * cos(i * 60), r * sin(i * 60)]
        ];
        polygon(points);
    }

    linear_extrude(height = h) {
        r = d / (2 * cos(30));
        regular_hexagon(r);
    }
}

module cap() {
    hull() {
        translate([0,0,-wall]) hex(d_outer-2*wall, wall);
        translate([0,0,-0.1]) hex(d_outer, 0.1);
    }
}

module finger_hole(d, h) {
    translate([0,0,-h]){ 
        cylinder(d1=d, d2=d-h, h=h);
        cylinder(d2=d, d1=d-h, h=h+0.01);
        cylinder(d=d-.3, h=h);
    }
}

module stopper_top(z) {
    for(rz=[0 : 60 : 360]) {
        rotate([0,0,rz]) translate([d_outer/2+stopper_offset,0,z]) scale([1,1,.6]) sphere(r=1, $fn=20);
    }
}

module stopper_bottom(z) {
    for(rz=[0 : 180 : 360]) {
        rotate([0,0,rz]) translate([d_outer/2+stopper_offset,0,z]) scale([1,1,.15]) sphere(r=1, $fn=20);
    }
}

module overhang(delta) {
    difference() {
        hex(d_outer, h_mid);
        cylinder(d=d_mid+delta, h=h_mid);
    }
}

module bottom() {
    union() {
        difference() {
            union() {
                cap();
                hex(d_outer, h_inner_bottom);
                translate([0,0,h_inner_bottom+h_inner_top/2]) 
                    trapezoidal_threaded_rod(d=d_mid, l=h_inner_top, pitch=pitch, thread_angle=thread_angle, starts=3, bevel2=true);
                
            }
            cylinder(d=d_inner, h=h_inner);
            translate([0,0,h_inner_bottom-h_mid]) overhang(0);
            if (d_finger_hole > 0) {
                finger_hole(d_finger_hole, wall);
            }
        }
        if (use_stoppers) {
            stopper_bottom(h_inner_bottom-h_mid);
        }
    }
}

module top() {
    h=h_inner_top;
    
    difference() {
        union() {
            translate([0,0,h/2])
            rotate([0,180,0])
                trapezoidal_threaded_nut(od=d_outer, id=d_mid, h=h, pitch=pitch, thread_angle=thread_angle, starts=3, slop=0.2);
            cap();
            translate([0,0,h]) overhang(0.4);
            
        }
        translate([0,0,-0.4]) cylinder(d=d_inner, h=1);
        if (use_stoppers) {
            stopper_top(h+h_mid);
        }
    }
}

translate([0,50,0]) bottom();
translate([0,-50,0]) top();


