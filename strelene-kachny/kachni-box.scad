include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

socket_w = 1.6;
wall_w = socket_w + 1.6;
inner_wall_w = 1.2;
card_w1 = 68;
card_w2 = 61;
card_l = 94;
stack_h = 29;
rules_w = 77;
rules_h = 3;
bottom_wall_h = 1;
top_wall_h = 2.4;
thumb_hole_d = 20;
lock_h = 0.6;
lock_l = 20;

inner_l = card_w1 + inner_wall_w + card_w2;
outer_l = wall_w + inner_l + wall_w;
inner_w = card_l;
outer_w = wall_w + card_l + wall_w;
inner_h = stack_h + rules_h;
outer_h = bottom_wall_h + inner_h + top_wall_h;

chamfer=2;

module container() {
    union() {
        difference() {
            cuboid([outer_l, outer_w, outer_h], align=V_TOP+V_RIGHT, chamfer=2);
            translate([wall_w, 0, bottom_wall_h]) 
                cuboid([inner_l, inner_w, outer_h], align=V_TOP+V_RIGHT);
            translate([wall_w + card_w1/2, 0, -1]) 
                cylinder(d=thumb_hole_d, h=bottom_wall_h+2);
            translate([outer_l - (wall_w + card_w2/2), 0, -1]) 
                cylinder(d=thumb_hole_d, h=  bottom_wall_h+2);

        }
        translate([wall_w + card_w1, 0, bottom_wall_h]) difference() {
            cuboid([inner_wall_w, inner_w, inner_h-0.2], align=V_TOP+V_RIGHT);
            zmove(stack_h) xmove(-1) hull() {
                cuboid([inner_wall_w+2, rules_w, rules_h], align=V_TOP+V_RIGHT);
                zmove(rules_h) cuboid([inner_wall_w+2, rules_w + 2*rules_h, 1], align=V_TOP+V_RIGHT);
            }
        }
    }
}

module lock(delta=1) {
    translate([wall_w, 0, 0.2 + inner_h + bottom_wall_h])
        scale(delta) cuboid([socket_w, lock_l, lock_h+0.2], align=V_BOTTOM, fillet=socket_w/2, edges=EDGES_Z_ALL, $fn=30);
}

module lid(delta=[1, 1, 1]) {
    difference() {
        union() {
            xmove(wall_w) zmove(inner_h + bottom_wall_h) scale(delta) union() {
                hull() {
                    xmove(-wall_w+socket_w) cuboid([2*socket_w + inner_l, 2*socket_w + inner_w, 0.4], align=V_TOP+V_RIGHT);
                    cuboid([inner_l, inner_w, 0.4+socket_w], align=V_TOP+V_RIGHT);
                }
                cuboid([inner_l, inner_w, top_wall_h], align=V_TOP+V_RIGHT);
            }
            lock();
            intersection() {
                lid_handle_bounding();
                translate([wall_w, 0, outer_h-top_wall_h]) 
                    cuboid([2*wall_w, outer_w, 2*top_wall_h], chamfer=2, edges=EDGES_ALL-EDGES_BOTTOM);
            }
        }
        xmove(-wall_w) lock();
    }
}

module lid_handle_bounding() {
    translate([0, 0, outer_h-top_wall_h]) cuboid([wall_w, outer_w, top_wall_h], align=V_TOP+V_RIGHT);
}

module base_text(t) {
    zmove(inner_h*.35) rotate([90, 0, -90]) zmove(-.5) linear_extrude(1) 
        text(t, halign="center", size=inner_h*0.4);
}

module front_text(t) {
    base_text(t);
}

module back_text(t) {
    xmove(outer_l) zrot(180) base_text(t);
}

module right_text(t) {
    xmove(outer_l/2) ymove(-outer_w/2) zrot(90) base_text(t);
}

module left_text(t) {
    xmove(outer_l/2) ymove(outer_w/2) zrot(-90) base_text(t);
}


module container_with_lid_hole() {
    difference() {
        container();
        lid();
        xmove(-1) lid_handle_bounding();
        xmove(0.1) lid_handle_bounding();
        lock([1.1, 1.05, 1.2]);
        xmove(-wall_w) lock();
        zmove(3) front_text("KACHNY");
        scale([1, .5, .5]) front_text("3 - 6 hráčů");
        back_text("KACHNY");
        right_text("STŘELENÉ");
        left_text("STŘELENÉ");
    }
}

module duck() {
    h = .2;
    translate([outer_l/2, 0, outer_h])
    zrot(-90) translate([-37, -35, -.2]) scale([.2, .2, 1]) linear_extrude(h) import("duck.svg");
}

module lid_logo(d) {
    difference() {
        lid(d);
        duck();
    }
}

//xrot(180) zmove(-outer_h) 
//    lid_logo([(inner_l-0.1)/inner_l, (inner_w-0.2)/inner_w,1]);
//    duck();
container_with_lid_hole();
