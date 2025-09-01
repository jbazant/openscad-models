include <BOSL/constants.scad>
use <BOSL/shapes.scad>

$fn=40;
r=2;
a=50;
a_inner=46;
h=6;
h_inner=5;
b_stand=30;
lock_w=.4;

module mass() {
    difference() {
        cuboid([a,a,h], fillet=r, edges=EDGES_Z_ALL+EDGES_Y_BOT+EDGE_BOT_BK);
        translate([0,-lock_w+0.1,1]) 
            cuboid([a_inner,a_inner-lock_w,h_inner], fillet=r-.5, edges=EDGES_Z_ALL);
    }
}

module single_lock() {
    color("red") translate([a_inner/2-lock_w/2, 0, 1]) cube([lock_w,7,.6], center=true);
}

module double_lock() {
    translate([0,8.5,0]) single_lock();
    translate([0,-8.5,0]) single_lock();
}

module single_border_deco() {
    bh=2;
    bw=1.6;
    br=0.6;
    bl=29.4;
    
    color("red") translate([0, a/2-bw/2, h/2+bh/2])
    cuboid([bl,bw,bh], fillet=br,edges=EDGES_Y_TOP);
}

module single_border_ext() {
    union() {
        single_border_deco();
        translate([3,0,0]) single_border_deco();
    }
}
    

module container_asymetrical() {
    // locks
    for(rz=[180:90:360]) {
        rotate([0,0,rz]) double_lock();
    }
    
    // border decorations
    for(rz=[-90:90:90]) {
        rotate([0,0,rz]) single_border_deco();
    }
    rotate([0,0,180]) single_border_ext();
    
    // main mass
    mass();
}

module container_symetrical() {
    // locks
    for(rz=[180:90:360]) {
        rotate([0,0,rz]) double_lock();
    }
    
    // border decorations
    for(rz=[90:90:360]) {
        rotate([0,0,rz]) single_border_deco();
    }
    
    // main mass
    mass();
}

module leg() {
    intersection () {
         difference() {
            translate([0,b_stand/2-1,h/2]) 
                color("blue") cuboid([a,b_stand,h], fillet=r, edges=EDGES_TOP+EDGES_Z_BK);
            rotate([60,0,0]) translate([0,a/2-lock_w,h/2]) 
                cuboid([a_inner,a_inner-lock_w,h_inner], fillet=r-.5, edges
=EDGES_Z_ALL);
         }
         rotate([60,0,0]) translate([0,a/2,0]) 
                cuboid([a,a,a], fillet=r, edges=EDGES_Z_ALL);
        
    }
}

module stand(symetrical = false) {
    rotate([60,0,0]) translate([0,a/2,h/2]) {
        if (symetrical) {
            container_symetrical();
        } else {
            container_asymetrical();
        }
    }
    leg();
}

stand(fa);
