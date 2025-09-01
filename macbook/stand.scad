include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

$fn=20;
EDGES_NO_BOT=EDGES_ALL-EDGES_BOTTOM;
V_TB=V_BACK+V_TOP;

w=8;

mac_height = 18.5; // including hardshell

base_width = w + mac_height + 5;



module leg() {
    w_leg=10;
    
    ymove(w/2) cuboid([30, 30+w/2, w_leg], align=V_FRONT+V_TOP, edges=EDGES_NO_BOT-EDGES_BACK, fillet=w_leg/2);
}

module wing() {
    w_bot=5;
    w_top=4;
    
    ymove(base_width-w_bot) hull() {
        ymove(w_bot-w_top) cuboid([40, w_top, 40+w], align=V_TB, edges=EDGES_NO_BOT, fillet=w_top/2);
        cuboid([100, w_bot, w], align=V_TB, edges=EDGES_NO_BOT, fillet=w_bot/2);
    }
}

union() {
    cuboid([130, base_width, w], align=V_TB, edges=EDGES_NO_BOT, fillet=w/2);
    hull() {
        cuboid([40, w, 80+w], align=V_TB, edges=EDGES_ALL, fillet=w/2);
        cuboid([130, w, 40+w], align=V_TB, edges=EDGES_ALL, fillet=w/2);
    }
    xmove(-50) leg();
    xmove(50) leg();
    wing();
}