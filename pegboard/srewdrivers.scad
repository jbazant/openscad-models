include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

include <jb-scad/skadis.scad>


module screwdrivers_mount() {
    module mounts() {
        a=51;
        inner_r=2.1;
        outer_r=4.6;
        
        module mount_single() {
            zrot(22.5) cylinder(h=2, r=inner_r, $fn=8);
            zmove(2) hull() {
                cylinder(h=2, r=outer_r-.6, $fn=40);
                zmove(.5) cylinder(h=1, r=outer_r, $fn=40);
            }
        }

        difference() {    
            ymove(inner_r-.2) union() {
                xmove(a) mount_single();
                xmove(-a) mount_single();
            }
            fwdcube([3*a, 10, 10]);
        }
    }

    module skadis_hooks() {
        for (tx=[-1 : 1]) {
        xmove(tx*SKADIS_HOLES_SPACING_X) skadis_hook_single();
        }
    }


    skadis_hooks();
    cuboid([120, 18, 2], align=V_TOP+V_BACK, chamfer=5, edges=EDGES_Z_ALL);
    zmove(2) mounts();
}

xrot(90) screwdrivers_mount();