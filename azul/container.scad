include <BOSL/constants.scad>
use <BOSL/shapes.scad>

include <settings.scad>
use <utils.scad>

//container();
lid();

module container() {
    // todo stopper hole
    board_h=board_h0+board_h1+board_h2+board_h3;
    container_h0=1;
    container_h1=3*w_outer/2;
    container_h2=board_h*5;
    container_h3=3;
    finger_r=10;
    container_x=board_x+w_outer+8;
    container_y=board_y+8;

    container_h=container_h0+container_h1+container_h2+container_h3;
    
    module finger_hole(t=[0, 0, 0]) {
         color("blue") cuboid(
            [3*w_outer, 2*w_outer, container_h*2], 
            p1=[2, 2+3, container_h0],
            fillet=8
        );
        translate([-1.3, 2*w_outer-2.8]) rotate([0, 0, -45]) color("yellow") cuboid(
            [2*w_outer, 3*w_outer, container_h*2], 
            p1=[0, 0, container_h0],
            fillet=8
        );
    }
    
    module small_container() {
        color("red") union() {
            cuboid(
                [w_outer-1, 2*w_outer, 100],
                fillet=(w_outer-3)/2,
                p1=[2, -w_outer, container_h0+container_h1]
            );
            children();
        }
    }
    
    module lid() {
        tz=container_h0+container_h1+container_h2;
        union() {
            hull() {
                cuboid(
                    [board_x+w_outer+1+40, board_y+4.2, 1],
                    p1=[.9, .9, tz],
                    fillet=12, edges=EDGES_Z_LF
                );
                cuboid(
                    [board_x+w_outer+1+39, board_y+2, 2.1],
                    p1=[2, 2, tz],
                    fillet=12, edges=EDGES_Z_LF
                );
            }
           cuboid(
                [board_x+w_outer+1+39, board_y+2, 10],
                p1=[2, 2, tz],
                fillet=12, edges=EDGES_Z_LF
            );
        }
    }
    
    module azul_text() {
        rotate([90, 0, -90]) {
            translate([0,0,-.5]) 
                linear_extrude(1) 
                text("AZUL", size=26, halign="center", valign="center");
            scale([2, 2, 1]) {
                //translate([29, 0, 0]) render_pattern("rhombus");
                //translate([-29, 0, 0]) render_pattern("rhombus");
            }
        }
    }
    
    module azul_deco() {
        d=20;
        rotate([90, 0, 0]) scale([2, 2, 1]) {
            translate([-2*d, 0, 0]) render_pattern("lily");
            translate([-d, 0, 0]) render_pattern("wheel1");
            translate([0, 0, 0]) render_pattern("rhombus");
            translate([d, 0, 0]) render_pattern("lotus1");
            translate([2*d, 0, 0]) render_pattern("shou");
        }
    }
    
    module main_body() {
        difference() {
            hull() {
                cuboid(
                    [container_x, container_y, container_h-2], 
                    p1=[-1,-1,1],
                    fillet=12, edges=EDGES_Z_ALL
                );
                cuboid(
                    [container_x-2, container_y-2, container_h], 
                    p1=[0,0,0],
                    fillet=12, edges=EDGES_Z_ALL
                );
            }
            color("blue") cuboid(
                [12, container_y, container_h3], 
                p1=[container_x-1-12, -1, container_h0+container_h1+container_h2],
                edges=EDGES_Z_ALL
            );
        }
    }

    difference() {
        // main mass
        main_body();
        // hole for stones
        translate([2+w_outer, 2, container_h0+container_h1]) 
            board_base(board_h*10, 2);
        // hole for boards
        cuboid(
            [board_x-4, board_y-4, container_h*2], 
            p1=[2+w_outer+1+2, 3+2, container_h0],
            fillet=8
        );
        finger_hole([1+w_outer-finger_r, board_y/2-finger_r, container_h0+container_h1]);
        // holes for 1st player token and counters
        translate([0,2*board_y/4, 4]) small_container() 
            cuboid(
                [w_outer-1, w_outer-1, 100],
                p1=[2, -(w_outer-1)/2, container_h0+container_h1],
                fillet=1
            );
        translate([0,3*board_y/4,0]) small_container() cuboid(
                [w_outer-1, stone_h+1, 100],
                p1=[2, -(stone_h+1)/2, container_h0+container_h1-2.5],
                fillet=1
            );
        // lid
        lid();
        // decorations
        translate([-1, -1, 0]) {
            // front face
            translate([0, container_y/2, 0]) {
                translate([0, 0, container_h/2]) azul_text();
            }
            //back face
            translate([container_x, container_y/2, 0]) {
                translate([0, 0, container_h/2-2]) rotate([0,0,180]) azul_text();
                translate([0, 0, container_h0+container_h1+container_h2-.4]) 
                    color("red") union() {
                        cuboid([2, 20, 1], fillet=1, edges=EDGES_Z_ALL);
                        cuboid([1, 18, 1.4], fillet=.5, edges=EDGES_Z_ALL);
                    }
            }
            if (render_deco) {
                //right face
                translate([container_x/2, 0, 0]) {
                    translate([0, 0, container_h/2]) azul_deco();
                }
                //left face
                translate([container_x/2, container_y, 0]) {
                    translate([0, 0, container_h/2]) azul_deco();
                }
            }
        }
    }
}

module lid() {
    shop_w=3*w+2;
    gap=8;
    body_x=board_x+w_outer+6;
    body_y=board_y+4;
    bottom_y=7;
    mid_y=body_y/2 - shop_w/2;
    top_y=body_y -7 -shop_w;
    
    module body() {
        union() {
            hull() {
                cuboid(
                    [body_x, body_y, 1],
                    p1=[0,0,1],
                    fillet=12, edges=EDGES_Z_ALL
                );
                cuboid(
                    [body_x-1, body_y-2, 2],
                    p1=[1,1,0],
                    fillet=12, edges=EDGES_Z_ALL
                );
            }
            cuboid(
                [body_x-1.1, body_y-2.2, 1],
                p1=[1.1,1.1,-1],
                fillet=12, edges=EDGES_Z_ALL
            );
        }
    }
    
    module shop() {
        x=shop_w;
        y=shop_w;
        
        union() {
            color("blue")
                translate([x/2, y/2, .6])
                children();
            
            translate([0,0,1]) hull() {
                cuboid(
                    [x, y, 1],
                    p1=[0,0,1],
                    fillet=12, edges=EDGES_Z_ALL
                );
                cuboid(
                    [x-2, y-2, 2],
                    p1=[1,1,0],
                    fillet=12, edges=EDGES_Z_ALL
                );
            }
        }
    }
   
    module rest_shop() {
        x=3*shop_w+2*gap;
        y=shop_w;
        
        union() {
            translate([0,0,.6]) hull() {
                cuboid(
                    [x, y, 1],
                    p1=[0,0,1],
                    fillet=12, edges=EDGES_Z_ALL
                );
                cuboid(
                    [x-2, y-2, 2],
                    p1=[1,1,0],
                    fillet=12, edges=EDGES_Z_ALL
                );
            }
        }
    }
    
    module players(n, init_rz=0) {
        rz_step = 360 / n;
        
        scale([.1, .1, 1]) translate([0, 0, .5]) union() {
            difference() {
                cylinder(h=1, r=100, center=true);
                cylinder(h=2, r=80, center=true);
            }
            for (rz=[rz_step : rz_step : 360]) {
                rotate([0, 0, rz+init_rz]) {
                    translate([0, -95, 0]) teardrop(r=30, orient=ORIENT_Z, ang=25);
                    translate([0, -170, 0]) cylinder(h=1, r=30, center=true);
                }
            }
        }
    }
    module stopper() {
        color("blue") translate([0, 0, 2] ) union() {
            cuboid([2, 20, 1], fillet=1, edges=EDGES_Z_ALL);
            cuboid([1, 18, 1.4], fillet=.5, edges=EDGES_Z_ALL);
        }
    }
    
    module stopper_mass() {
        // TODO
        color("blue") cuboid(
                [12, container_y, container_h3], 
                p1=[container_x-1-12, -1, container_h0+container_h1+container_h2],
                edges=EDGES_Z_ALL
            );
    }
    
    difference() {
        union() {
            body();
            translate([body_x-4.2 ,body_y/2, 0]) stopper();
            stopper_mass();
        }
        for (tx=[6 : shop_w + gap : body_x-shop_w]) {
            player_num = tx == 6 ? 4 : tx > body_x - 2*shop_w ? 3 : 2;
            init_rz = player_num == 4 ? 45 : player_num == 3 ? -30 : 0;
            
            translate([tx, bottom_y, 0]) shop() players(player_num, init_rz);
            translate([tx, top_y, 0]) shop() players(player_num, init_rz);
        }
        translate([6, mid_y, 0]) shop() players(2);
        translate([6+shop_w+gap, mid_y, 0]) rest_shop();
        translate([body_x, body_y/2, 0]) stopper();
    }
}



