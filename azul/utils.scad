include <settings.scad>
include <BOSL/constants.scad>
use <BOSL/shapes.scad>

module board_base(h, dxy=0) {
    cuboid([board_x+dxy, board_y+dxy, h], fillet=10, edges=EDGES_Z_ALL, p1=[0, 0, 0]);
}
    
module render_pattern(pattern) {
    module lily() {
        w_inner=w-3;
        module lily_leaf() {
            translate([0, -8, 0]) difference() {
                rotate([0, 0, 45]) cuboid([10, 10, 1], fillet=2, edges=EDGES_Z_ALL, $fn=20);
                
                hull() {
                    translate([0, 1, 0]) cylinder(d=5, h=2, center=true, $fn=50);
                    translate([0, 6.5, 0]) cylinder(d=1, h=2, center=true, $fn=50);
                }
            }
        }

        scale([4.8/w_inner, 4.8/w_inner, 1]) 
        for(rz=[0 : 90 : 270]) {
            rotate([0, 0, rz]) {
                lily_leaf();
                translate([10, 10, 0]) cylinder(d=5, h=1, $fn=50, center=true);
            }
        }
    }

    module first_player() {
        deco_t=3.6;
        
        module deco() {
            rotate([0, 0, 45]) difference() {
                cube([3, 3, 2], center=true);
                difference() {
                    cube([2, 2, 2], center=true);
                    cube([1, 1, 2], center=true);
                }
            }
        }
        
        module deco2() {
            translate([0, 0, -1]) for(rz=[0 : 90 : 270]) {
                rotate([0, 0, rz]) 
                    scale([.4, .8, 1]) 
                    translate([0, -.3, 0]) 
                    rotate([0, 0, 45]) 
                    cube(2);
            }
        }
        
        translate([0, 0, -1])
            linear_extrude(2) 
            text("1", halign="center", valign="center", size=6, font=font);
        
        for(tx=[-deco_t, deco_t]) {
            for(ty=[-deco_t, deco_t]) {
                translate([tx, ty, 0]) deco2();
            }
        }
    }
    
    module wheel(variant) {
        wheel_h=1;
        wheel_a=.5;
        x_inner=4.6;
        
        for(rz=[0 : 45 : 315]) {
            rotate([0, 0, rz]) hull() {
                translate([3, 4, 0]) cylinder(h=wheel_h, d=wheel_a, center=true, $fn=6);
                translate([3, -4, 0]) cylinder(h=wheel_h, d=wheel_a, center=true, $fn=6);
            }
        }
        
        if (variant >= 2) {
            rotate([0, 0, 22.5]) {
                difference() {
                    cylinder(h=wheel_h, d=4, center=true, $fn=8);
                    cylinder(h=wheel_h+1, d=4-2*wheel_a, center=true, $fn=8);
                }
            }
        }

        if (variant >= 3) {
            for(rz=[45 : 90 : 359]) {
                rotate([0, 0, rz]) translate([x_inner/2-.25, 0, 0]) cube([.5, wheel_a, wheel_h], center=true);
            }
            
            difference() {
                union() {
                    for(rz=[0 : 90 : 179]) {
                        rotate([0, 0, rz]) cube([x_inner, wheel_a, wheel_h], center=true);
                    }
                }
                cube([1, 1, wheel_h+1], center=true);
            }
        }
    }
    
    module basic_svg(source, scale_factor) {
        w_inner=w-3;
        s=w_inner/scale_factor;
        
        translate([-w_inner/2, -w_inner/2, -.5])
            scale([s, s, 1]) 
            linear_extrude(1) 
            import(source);
    }
    
    module rhombus() {
        module leaf() {
            translate([.2, .4, -.5]) 
                linear_extrude(1) 
                polygon([[0.2, .5], [.2,5], [3,8], [3, 3.4]]);
        }
        
        scale([.7, .7, 1]) for (rz=[0 : 90 : 359]) {
            rotate([0, 0, rz]) {
                leaf();
                mirror([1,1,0]) leaf();
            }
        }
    }

    if (pattern == "player") {
        first_player();
    } else if (pattern == "shou") {
        translate([0, -0.4, 0]) basic_svg("motives/shou.svg", 85);
    } else if (pattern == "lily") {
        lily();
    } else if (pattern == "lotus1") {
        basic_svg("motives/lotus-flower.svg", 180);
    } else if (pattern == "lotus2") {
        translate([0.2, 0.2, 0]) basic_svg("motives/lotus-simple.svg", 220);
    } else if (pattern == "lotus3") {
        translate([-.4, 0.2, 0]) basic_svg("motives/lotus3.svg", 100);
    } else if (pattern == "cloud") {
        rotate([0, 0, 20]) translate([-0.7, 0, 0]) basic_svg("motives/cloud.svg", 170);
    } else if (pattern == "wheel1") {
        wheel(1);
    } else if (pattern == "wheel2") {
        wheel(2);
    } else if (pattern == "wheel3") {
        wheel(3);
    } else if (pattern == "hand") {
        translate([(3-w)/2, -0.6, 0]) basic_svg("motives/hand.svg", 150);
    } else if (pattern == "rhombus") {
        rhombus();
    } else if (pattern == "smooth") {
        // render nothing
    } else {
        echo("Invalid module name. Please set pattern to a valid module name.");
    }
}

