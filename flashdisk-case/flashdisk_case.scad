include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

$fn=20;

difference() {
    // main mass
    hull() {
        cuboid([18, 7, 13], align=V_UP, fillet=3, edges=EDGES_Z_ALL);
        zmove(1) cuboid([20, 9, 11], align=V_UP, fillet=4, edges=EDGES_Z_ALL);
    }
    
    // grip
    translate([10, 0, 6.5]) zscale(3) xrot(90) cylinder(h=10, d=3, center=true);
    translate([-10, 0, 6.5]) zscale(3) xrot(90) cylinder(h=10, d=3, center=true);
    
    // connector hole
    zmove(-1) upcube([12, 4.5, 13 + 2]);
    hull() {
        upcube([12, 4.5, .6]);
        zmove(-1) upcube([13, 5.5, 1.2]);
    }
    
    //fix in place holes
    zmove(10.5) cuboid([13, 1.6, 1.6], align=V_UP, fillet=.8);
    cuboid([12.6, 1.6, 12], align=V_UP, fillet=.8);
    

}
