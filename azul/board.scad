include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

include <settings.scad>
use <utils.scad>

ydistribute(20, [w+10, board_y]) {
    xdistribute(10, [w/2, w+10, w]) {
        counter();
        board_test();
        insert();
    }

    xdistribute(20, [board_x, board_x]) {
        translate([-board_x/2, -board_y/2, 0]) board("a", "b");
    }
}


module counter() {
    cuboid([w/2, w/2, w/2], chamfer=1);
}


module insert() {
    cuboid([w-2, w-2, .4]);
}

module board(scoreboard_variant = "a", wall_variant = "b") {
    
    h_board=board_h0+board_h1+board_h2;
    stone_z=stone_h/2+board_h0+board_h1;
    
    function getPenalty(x) = x < 2 ? -1 : x < 5 ? -2 : -3;

    module make_tile(depth=.2) {
        translate([0, 0, stone_z]) {
            cuboid([w_outer, w_outer, stone_h], chamfer=2);
            cuboid([w-2, w-2, stone_h+2*depth]);
        }
    }

    module wall(variant) {
        module wall_a() {
            patterns = ["shou", "lily", "lotus2", "cloud", "wheel"];
            for(x=[0 : 4]) {
                for (y=[0 : 4]) {
                    translate([x*w_outer, y*w_outer, 0]) {
                        make_tile();
                        translate([0, 0, .8]) render_pattern(patterns[(x+y)%5]);
                    }
                }
            }
        }
        
        module wall_b() {
            for(x=[0 : 4])  for (y=[0 : 4]) {
                translate([x*w_outer, y*w_outer, 0]) make_tile(board_h1); 
            }
        }
        
        if (variant == "a") wall_a();
        else if (variant == "b") wall_b();
        else echo("Unknown wall variant!");
    }
    
    module preparation() {
        for(y=[0 : 4]) {
            for (x=[0 : 4]) if (x >= y) {
                translate([x*w_outer, y*w_outer, 0]) make_tile();
            }
        }
    }

    module score_text(score, size = font_size_score_default, style = undef) { 
        font_with_style= style != undef ? str(font, ":style=", style) : font;

        linear_extrude(1) text(
            str(score), 
            halign="center", 
            valign="center", 
            size=size, 
            font=font_with_style
        );
    }
        
    module broken_tiles() {
        for(x=[0 : 6]) translate([x*w_outer, 0, 0]) {
            make_tile();
            score_text(getPenalty(x), style="bold");
        }
    }
    
    module scoreboard(variant) {
        function getSize(score) = score == 100 ? font_size_score_small : font_size_score_default;
        
        module make_score_position(score, size=font_size_score_default, depth=.2) {
            union() {
                cuboid([w/2+2, w/2+2, stone_h], chamfer=2);
                cuboid([w/2-2, w/2-2, stone_h+2*depth]);
                translate([0, 0, -stone_h/2-1]) score_text(score, size);
            }
        }
        
        module scoreboard_a() {
            for(x=[0 : 19]) for (y=[0 : 4]) {
                score=x+(4-y)*20+1;
                translate([x*w_outer/2+w/4+.5, y*w_outer/2, stone_z]) 
                    make_score_position(score, getSize(score));
            }
            translate([-1*w_outer/2 +w/4, 4*w_outer/2, stone_z]) 
                make_score_position(0);
        }
        
        module scoreboard_b() {
            for(x=[0 : 19]) for (y=[0 : 4]) {
                score=x+(4-y)*20;
                translate([x*w_outer/2+w/4+.5, y*w_outer/2, stone_z]) 
                    make_score_position(score, getSize(score));
            }
        }
        
        if (variant == "a") scoreboard_a();
        else if (variant == "b") scoreboard_b();
        else echo("Unknown scoreboard variant!");
    }
    
    module score_deco(variant) {
        module scoreboard_a() {
            for (x=[1 : 4]) {
                translate([5*x*w_outer/2-w/4-.5, -w_outer/4-.3, h_board]) cuboid(
                    [w_outer/2+.6, 5*(w_outer/2)+.6, board_h3],
                    fillet=3,
                    edges=EDGES_Z_ALL,
                    align=V_UP+V_BACK,
                    $fn=20
                );
            }
            translate([-w/4-1, 7*w_outer/4-.3, h_board]) cuboid(
                    [w_outer/2+.6, w_outer/2+.6, board_h3],
                    fillet=3,
                    edges=EDGES_Z_ALL,
                    align=V_UP+V_BACK,
                    $fn=20
                );
        }
        
        module scoreboard_b() {
            for (x=[0 : 3]) {
                translate([5*x*w_outer/2+w/4+.5, -w_outer/4-.3, h_board]) cuboid(
                    [w_outer/2+.6, 5*(w_outer/2)+.6, board_h3],
                    fillet=3,
                    edges=EDGES_Z_ALL,
                    align=V_UP+V_BACK,
                    $fn=20
                );
            }
        }
        
        if (variant == "a") scoreboard_a();
        else if (variant == "b") scoreboard_b();
        else echo("Unknown scoreboard variant!");
    }
       
    module arrows() {
        module arrow_deco() {
            translate([-2.75, -5, h_board]) linear_extrude(board_h3) {
                polygon([
                    [0.5, 0], [2.5, 0], [5.5, 5], [2.5, 10], [0.5, 10], [3.5, 5]
                ]);
                polygon([[0.5, 1.5], [2.5, 5], [0.5, 8.5], [1, 5]]);
            }
        }
    
        for(y=[0 : 4]) {
            translate([0, y*w_outer, 0]) arrow_deco();
        }
    }
    
    module penalties() {
        module penalty1(tx=0) {
            translate([tx, w_outer/2+.5, h_board-1]) cylinder(r=1, h=2, $fn=20);
        }
        module penalty2() {
            penalty1(-1.5);
            penalty1(1.5);
        }
        module penalty3() {
            penalty1(-3);
            penalty1(0);
            penalty1(3);
        }
        
        difference() {
            cuboid(
                [w_outer*7, w_outer+2, board_h3], 
                p1=[-w_outer/2, -w_outer/2, h_board],
                fillet=3,
                edges=EDGES_Z_ALL,
                $fn=20
            );
            union() for(x=[0 : 6]) {
                penalty=getPenalty(x);
                translate([x*w_outer, 0, 0]) {
                    if (penalty == -1) penalty1();
                    else if (penalty == -2) penalty2();
                    else if (penalty == -3) penalty3();
                    else echo("Unknown penalty value!");
                }
            }
        }
    }
    
    module score_card() {
        module points(number) {
            linear_extrude(board_h3)    
                text(str(number), halign="center", valign="center", size=6, font=font);
        }

        module tile() {
            upcube([2, 2, board_h3]);
        }

        module points2(){
            points(2);
            for(tx=[0 : 4]) {
                translate([tx*3+4, 0, 0]) upcube([2, 2, board_h3]);
            }
        }
        
        module points7(){
            points(7);
            for(ty=[0 : 4]) {
                translate([+4, ty*3-6, 0]) upcube([2, 2, board_h3]);
            }
        }
        
            module points10(){
            points(10);
            for(txy=[0 : 4]) {
                translate([18-txy*3, txy*3-6, 0]) upcube([2, 2, board_h3]);
            }
        }
        

        translate([-3, 1, h_board]) union() {
            difference() {
                translate([-w_outer/4, 0, 0]) cuboid(
                    [w_outer*4, w_outer+2, board_h3], 
                    align=V_TOP+V_RIGHT,
                    fillet=3,
                    edges=EDGES_Z_ALL,
                    $fn=20
                );
                translate([-w_outer/4+2, 0, 0]) cuboid(
                    [w_outer*4-4, w_outer-2, 1], 
                    align=V_TOP+V_RIGHT,
                    fillet=2.5,
                    edges=EDGES_Z_ALL,
                    $fn=20
                );
            }
        
            translate([2, 0, 0])points2();
            translate([24, 0, 0]) points7();
            translate([38, 0, 0]) points10();
        }
    }
    

    union() {
        board_base(board_h0);
        difference() {
            union() {
                board_base(h_board);
                color("blue") {
                    translate([w_outer*6, w_outer*2, 0]) arrows();
                    translate([w_outer*1, w_outer*.75, 0]) penalties();
                    translate([w_outer*1, w_outer*7, 0]) score_deco(scoreboard_variant);
                    translate([w_outer*8, w_outer*.75, 0]) score_card();
                }
            }
            translate([w_outer*1, w_outer*2, 0]) preparation();
            translate([w_outer*7, w_outer*2, 0]) wall(wall_variant);
            translate([w_outer*1, w_outer*0.75, 0]) broken_tiles();
            translate([w_outer*1, w_outer*7, 0]) scoreboard(scoreboard_variant);
        }
    }
}

module board_test() {
    // TODO top decorative layer
    h_board=board_h0+board_h1+board_h2;
    stone_z=stone_h/2+board_h0+board_h1;
    
    module make_tile(depth=.2) {
        translate([0, 0, stone_z]) {
            cuboid([w_outer, w_outer, stone_h], chamfer=2);
            cuboid([w-2, w-2, stone_h+2*depth]);
        }
    }
    
    module score_text(score, size = font_size_score_default, style = undef) { 
        font_with_style= style != undef ? str(font, ":style=", style) : font;

        linear_extrude(1) text(
            str(score), 
            halign="center", 
            valign="center", 
            size=size, 
            font=font_with_style
        );
    }
        
    module broken_tiles() {
        for(x=[0 : 6]) translate([x*w_outer, 0, 0]) {
            make_tile();
            score_text(getPenalty(x), style="bold");
        }
    }
    
    union() {
        upcube([w+10, w+10, board_h0]);
        
        difference() {
            upcube([w+10, w+10, h_board]);
            make_tile();
            xmove(-2.5) score_text("34", style="bold");
            xmove(2.5) score_text("34");
        }
    }
}