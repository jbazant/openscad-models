include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

$fn=20;

narrow_stand();

module narrow_stand() {
    base();
    wings();
    saw();
    
    module base() {
        cyl(r=10, h=2, chamfer2=.5, align=V_TOP, $fn=100);
    }

    module wings() {
        for (rz=[0, 180]) {
            zrot(rz) {
                xmove(1) cuboid([1.2, 16, 10], chamfer=.4, align=V_TOP);
                xmove (1.6) hull() {
                    right_triangle([6, 1, 8], align=V_UP+V_RIGHT);
                    right_triangle([6.2, .6, 8.3], align=V_UP+V_RIGHT);
                }
            }
        }
    }

    module saw() {
        module tooth() {
            cyl(r1=.4, r2=.7, h=10, chamfer=.2, align=V_TOP);
        }
        
        tx=.7;
        
        for (ty=[-7 : 3.5 : 6]) {
            move(x=tx, y=ty) tooth();
            move(x=-tx, y=ty+1.75) tooth();
        }
        move(x=tx, y=7) tooth();
    }
}

