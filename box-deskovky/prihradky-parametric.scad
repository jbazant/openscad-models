stackable_organizer([60,80,20], [4,1], r_bottom=15);
//stackable_organizer([10,10,3], [2,1], r_bottom=2);


module organizer(dimensions = [20,20,10], matrix =[1,1], r_wall = 2, r_bottom = undef) {
    // prepare
    $fn=50;
    
    x=dimensions[0];
    y=dimensions[1];
    z=dimensions[2];
    
    r_b = is_undef(r_bottom) ? z : r_bottom;
    
    // make sure inputs are valid
    assert(x > 0);
    assert(y > 0);
    assert(z > 0);
    assert(matrix[0] > 0);
    assert(matrix[1] > 0);
    assert(r_wall >= .5, "wall radius is expected to be at least 0.5 mm");
    assert(r_b <= z, "Too big bottom radius! Specify radius no bigger than z dimmension!");
    
    // assemble
    for(i=[0 : matrix[0] - 1]) {
        for(j=[0 : matrix[1] - 1]) {
            translate([i * x, j * y, 0]) single_box();
        }
    }
    
    // sub module definitions
    module basic_wall(wx, d, t) {
        rotate([0, 0, d]) translate([0, t, 0]) minkowski() {
            cube([wx, 0.01, z]);
            sphere(r=r_wall);
        }
    }

    module floor_curve(h) {
        translate([0, 0, r_b]) rotate([0, 90, 0]) cylinder(r=r_b, h=h);
    }
    
    module curved_floor() {
        difference() { 
            translate([0, 0, -r_wall]) cube([x, y, r_wall + r_b]);
            hull() {
                translate([0, 0 + r_b + r_wall, 0]) floor_curve(x);
                translate([0, y - r_b - r_wall, 0]) floor_curve(x);
            }
        }
    }

    module single_box() {
        union() {
            basic_wall(x,  0,  0);
            basic_wall(x,  0,  y);
            basic_wall(y, 90,  0);
            basic_wall(y, 90, -x);
            curved_floor();
        }
    }
}


module stackable_organizer(dimensions = [20,20,10], matrix =[1,1], r_wall = 2, r_bottom = undef) {
    difference() {
        organizer(dimensions, matrix, r_wall, r_bottom);
        translate([0,0,-(dimensions[2] + r_wall)]) 
          organizer(dimensions, matrix, r_wall, r_bottom);
    };
}

