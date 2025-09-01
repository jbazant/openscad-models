include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

h=36;
l=58;

module mycube(d, noedge=EDGES_NONE) {
    cuboid(d, align=V_BACK+V_RIGHT+V_TOP, edges=EDGES_TOP-noedge, chamfer=.2);
}

module kul() {
    mycube([2, h, 1]);
    ymove(h-2.7) mycube([2, 2.7, 1], noedge=EDGE_TOP_RT+EDGE_TOP_LF);
}

module sekce() {


    module planka() {
        mycube([1, h, .6]);
    }

    module lat() {
        mycube([l, 1, .6], noedge=EDGE_TOP_RT);
    }

    module madlo() {
        mycube([l, 2.7, 1], noedge=EDGE_TOP_RT+EDGE_TOP_LF);
    }
    
    module tram() {
        mycube([l]);
    }
    
    module stred() {
        mycube([l, 12, .6], noedge=EDGE_TOP_RT+EDGE_TOP_LF);
    }

    lat();
    ymove(h-2.7) madlo();
    ymove(13) stred();
    kul();
    for (tx=[7 : 6.35 : l-1]) {
        xmove(tx) planka();
    }
}

module traverza(l) {
    module sroub() {
        xmove(1) hull() {
            cylinder(d=2, h=.8, $fn=6);
            cylinder(d=1.6, h=1, $fn=6);
        }
    }
    
    color("blue")cube([l, 10, .6]);
    ymove(8) mycube([l, 2, 1], EDGE_TOP_RT+EDGE_TOP_LF);
    mycube([l, 2, 1], EDGE_TOP_RT+EDGE_TOP_LF);    
    ymove(3.5) sroub();
    ymove(6.5) sroub();
}


for (tx=[0 : 2]) xmove(tx * l) sekce();
xmove(3 * l) kul();

// ------

//for (tx=[0 : 2]) xmove(tx * l) traverza(l);
//xmove(3 * l) traverza(2);

    