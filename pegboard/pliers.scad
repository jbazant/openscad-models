include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <jbscad/skadis.scad>

module pliers_holder(w, l) {
    hand_r=3;
    back_w=max(w+4*hand_r+2, 50); 
    back_h=4;
    l_all=l+4;
    w_space=w/2+hand_r;
    
    skadis_hook_double();
    skadis_hook_double_support();

    module hand() {
        difference() {
            translate([0, hand_r, 1]) union() {
                scale([1, 2, 1]) cylinder(r=hand_r, h=l_all-1, $fn=20);
                zmove(l_all-3) hull() {
                    scale([1, 1.6, 1]) cylinder(r=hand_r, h=6, $fn=20);
                    zmove(2) scale([1, 2.4, 1]) cylinder(r=hand_r, h=3, $fn=20);
                }
            }
            cuboid([2*hand_r, 2*hand_r, 2*l_all], align=V_UP+V_FRONT);
        }
    }
    
    cuboid([back_w, 20, 4], chamfer=1, align=V_TOP+V_BACK);
    xmove(-w_space) hand();
    xmove(w_space) hand();
}

pliers_holder(34.5, 20);
//pliers_holder(38.5, 20);