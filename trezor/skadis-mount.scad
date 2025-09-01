include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>
use <jb-scad/skadis.scad>

x_inner=118+.2;
y_inner=80;
z_inner=10+.2;
w=1.6;


xrot(90) union() {
    ymove(y_inner/4+1.7) case();
    skadis_hook_triple();
}

module plate() {
    x=118+.2;
    y=80;
    
    zmove(z_inner/2+w) hull() {
        cuboid([x_inner, y_inner, z_inner-2], fillet=10, edges=EDGES_Z_ALL);
        cuboid([x_inner-2, y_inner-2, z_inner], fillet=9, edges=EDGES_Z_ALL);
    }
}

module notch() {
    ymove(2) zmove(z_inner/2+w) hull() {
        cuboid([x_inner, 10, z_inner-2]);
        cuboid([x_inner-2, 10-2, z_inner]);
        cuboid([x_inner+2, 6, z_inner]);
        cuboid([x_inner, 6-2, z_inner+2]);
    }
}

module case() {
    difference() {
        cuboid(
            [x_inner+2*w, y_inner+2*w, z_inner+2*w], chamfer=8,  
            edges=EDGES_Z_ALL, align=V_TOP
        );
        plate();
        zmove(w) cuboid([x_inner-8, y_inner-8, z_inner+3], fillet=6, edges=EDGES_Z_ALL, align=V_TOP);
        zmove(w+2) cuboid([x_inner-20, 2*y_inner, z_inner+3], fillet=6, edges=EDGES_BOTTOM, align=V_TOP);
        cuboid([2*x_inner, y_inner, 3*z_inner], align=V_BACK);
        notch();
        move(y=-y_inner/2-w, x=20) zrot(45) cuboid([20, 20, 20], chamfer=3);
        move(y=-y_inner/2-w, x=-20) zrot(45) cuboid([20, 20, 20], chamfer=3);
        move(x=40) zrot(45) cuboid([20, 20, 20], chamfer=3);
        move(x=-40) zrot(45) cuboid([20, 20, 20], chamfer=3);
        zrot(45) cuboid([20, 20, 20], chamfer=3);
    }
}
