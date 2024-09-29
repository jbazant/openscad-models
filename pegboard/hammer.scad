include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <jbscad/skadis.scad>


module hammer_holder(w, l) {
    back_w=max(w, 25) + 24; 
    back_h=4;
    l_all=l+4;
    
    skadis_hook_double();
    skadis_hook_double_support();

    module left_hand() {
        align=V_UP+V_BACK+V_LEFT;
        
        cuboid([12, 5, l_all], chamfer=1, align=align);
        zmove(l_all-1) xrot(-45) cuboid([12, 4, 8], chamfer=1, align=align);
    }

    module right_hand() {
        align=V_UP+V_BACK+V_RIGHT;
        
        hull() {
            cuboid([12, 5, l_all], chamfer=1, align=align);
            xmove(1) zrot(15) cuboid([12, 4,l_all], chamfer=1, align=align);
        }
        zmove(l+3) xrot(-45) cuboid([12, 4, 8], chamfer=1, align=align);
    }

    cuboid([back_w, 20, 4], chamfer=1, align=V_TOP+V_BACK);
    xmove(-w/2) left_hand();
    xmove(w/2) right_hand();
}

xrot(90) hammer_holder(35, 37);

// measures I need 
// S 20, 20
// M 32, 32
// L 35, 37