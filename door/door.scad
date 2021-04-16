include<../_defaults.scad>

door_width = 40;
door_height = 40;
thickness = 3;
revision="r6";
handle_r = 10;

module door_carving(door_text, thickness) {
    translate([0, 0, thickness / 3]) rotate([0, 0, 180]) linear_extrude(thickness / 3)
        text(door_text, 5, halign = "center", valign = "center");
}

module handle_hole() {
    r2=handle_r;
    r1=handle_r/2;

    translate([0,0, -thickness/4]) difference(){
        cylinder(r1=r1, r2=r2, h=thickness/2, center=true);
        translate([0, -r2, 0]) cube([2*r2,2*r2,2*r2], center=true);        
    }
}

module handle_top() {
    r=1;

    translate([0, -r, 0]) hull() {
        for(x=[-handle_r, handle_r]) {
            translate([x,0,0]) sphere(r, $fn=20);
        }
    }
}

module door_lock(width, height, thickness) {
    offset_x = (width + thickness*2/3) / 2;

    for(x=[-offset_x, offset_x]) {
        translate([x, -height/2, -thickness/6]) sphere(thickness/3, $fn=20);
    }
}

module door(width, height, thickness, generate_handle=false, door_text="") {
    handle_position=[0, -(height - 10) / 2, thickness / 2];

    union() {
        difference() {
            // door mass
            union() {
                hull() {
                    translate([0, 0, -(thickness - layer_height) / 2])cube([width + 2* thickness, height + thickness, layer_height], center=true);
                    translate([0, -thickness/2, (thickness - layer_height) / 2]) cube([width, height, layer_height], center=true);
                }
                door_lock(width, height, thickness);
            }

            //handle part #1
            if (generate_handle) {
                translate(handle_position) handle_hole();
            }

            // text on door "bottom"
            if (door_text) {
                translate([0, (height - 16) / 2, 0]) door_carving(door_text, thickness);
            }
        }

        //handle part #2
        if (generate_handle) {
            translate(handle_position) handle_top();
        }
    }
}

// generates door mass, you want to use for creating hole in your model
module door_mass_with_clearance(width, height, thickness, clearance=0.2) {
    scale([(width + 2*clearance)/width, (height + clearance)/ height, (thickness + clearance) / thickness])
        translate([0,0,thickness/2])door(width, height, thickness);
}

// genrates frame for handle, you probably do not want to use it outside example
module frame(width, height, thickness) {
    difference() {
        cube([width + 4*thickness, height + 2*thickness, 2*thickness], center=true);

        cube([width, height - 2*thickness, 2*thickness], center=true);

        translate([0, -thickness/2, thickness/2]) door_mass_with_clearance(width, height, thickness);
    }
}


translate([door_width + 4*thickness, 0, -thickness/2]) door(door_width, door_height, thickness, true, revision);

frame(door_width, door_height, thickness);