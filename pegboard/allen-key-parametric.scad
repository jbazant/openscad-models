include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
include <jb-scad/skadis.scad>

/* [Global] */

// diameters of your allen keys
diameters=[2, 2.5, 3, 4, 5, 6];

// hole clearance
tolerance=.4;

// heigh of the box
h=12; //[::non-negative integer]

// space between individual holes
spacer=2; //[::non-negative integer]

// whether 1st layer "brim" should be generated for skadis hooks
generate_brims=true; //[::bolean]

/* ----- Do not edit bellow this line ----- */

function outer_d_hex(inner_d) = 2 * inner_d / pow(3, 1/2);

function computeOffset(arr, i) = (i < 0) ? 0 : spacer + arr[i] + computeOffset(arr, i-1);

function get_width() = spacer + computeOffset(outer_diameters, len(diameters)-1);

function get_y_offset() = outer_diameters[len(diameters)-1]/2 + spacer;

inner_diameters=[for (i = [0: len(diameters)-1]) diameters[i] + tolerance];
outer_diameters=[for (i = [0: len(diameters)-1]) outer_d_hex(inner_diameters[i])];

module holes() {
    move(x=1-get_width()/2, y=-get_y_offset()) union() {
        for(i = [0 : len(outer_diameters)-1]) {
            let (
                d_outer=outer_diameters[i], 
                d_inner=inner_diameters[i],
                tx=computeOffset(outer_diameters, i-1)
            ) {        
                xmove(tx + 1 + d_outer/2) {
                    cylinder(h=h+d_inner/2, d=d_outer, $fn=6);
                    zmove(h) xrot(90) cylinder(h=h, d=d_outer, $fn=6);
                    hull() {
                        zmove(h-d_outer) cylinder(h=d_outer, d=d_outer, $fn=6);
                        zmove(h) xrot(90) cylinder(h=d_outer, d=d_outer, $fn=6);
                    }
                }
            }
        }
    }
}

module labels() {
    color("blue") move(x=1-get_width()/2, y=-get_y_offset()-h+.5) 
    for(i = [0 : len(outer_diameters)-1]) {
        let (
            d_outer=outer_diameters[i],
            d_inner=diameters[i],
            tx=computeOffset(outer_diameters, i-1) + 1 + d_outer/2,
            tz= i % 2 == 0 ? spacer : spacer*3/2+(h/5)
        ) {
            move(x=tx, z=tz) xrot(90)
                linear_extrude(1) 
                text(str(d_inner), halign="center", valign="bottom", size=h/5);
        }
    }
}

module mass() {
    cuboid(
        [max(get_width(), SKADIS_HOLES_SPACING_X+SKADIS_HOLE_WIDTH), h+get_y_offset(), h], 
        align=V_FRONT+V_TOP, 
        chamfer=spacer/2, edges=EDGES_ALL-EDGES_BACK
    );
    cuboid(
        [max(get_width(), SKADIS_HOLES_SPACING_X+SKADIS_HOLE_WIDTH), spacer, SKADIS_HOLE_LENGTH-.6], 
        align=V_FRONT+V_TOP, 
        chamfer=spacer/2, edges=EDGES_ALL-EDGES_BACK
    );
}

module skadis_hooks() {
    xrot(90) {
        skadis_hook_double();
        if(generate_brims) {
            skadis_hook_double_support();
        }
    }
}

union() {
    difference() {
        mass();
        holes();
        labels();
    }
    skadis_hooks();
}
