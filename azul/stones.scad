include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

include <settings.scad>
use <utils.scad>

patterns=[
    "player", "shou", "lily", "lotus1", "lotus2", 
    "lotus3", "cloud", "wheel1", "wheel2", "wheel3", 
    "hand", "rhombus", "smooth"
];

for (tx=[0 : len(patterns)-1]) {
    p=patterns[tx];
    xmove(tx * (w+5)) {
        stone(p);
        ymove(w+5) stone_multicolor(p);
    }
}

ymove(-w-5) {
    stone_multicolor_inner();
    xmove(w+5) stone_multicolor_inner(1);
}

module stone(pattern) {
    module make_stone() {
        difference() {
            cuboid([w, w, stone_h], chamfer=stone_chamfer);
            translate([0, 0, 3]) children();
            rotate([0, 180, 0]) translate([0, 0, 3]) children();
        }
    }
    
    make_stone() render_pattern(pattern);
}

module stone_multicolor_inner(dz=.5) {
    module single_plate() {
        cuboid([w-2, w-2, .2], chamfer=stone_chamfer, edges=EDGES_Z_ALL);
    }
    
    for (i=[-1, 1]) {
        translate([0,0,(stone_h/2-dz-.1)*i]) single_plate();
    }
}

module stone_multicolor(pattern) {
    dz=pattern == "player" ? 1 : .5;
    difference() {
        stone(pattern);
        color("red") stone_multicolor_inner(dz);
    }
}
