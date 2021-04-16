use <promitacka.scad>
use <kolecka-slot.scad>
use <../door/door.scad>

halfwidth= 45;
halflength= 27.2;
module main_body() {

    
    translate([0, 2.5, 0]) difference() {
        hull() {
            for (x = [- 1, 1]) {
                for (y = [- 1, 1]) {
                    translate([x * (halfwidth - 1), y * (halflength -1), 72]) cylinder(r = 1, h = 150, center = true, $fn=10);
                }
            }
        }

        hull() {
            for (x = [- 1, 1]) {
                for (y = [- 1, 1]) {
                    translate([x * (halfwidth - 7), y * (halflength -7), 140])cylinder(r = 1, h = 10, center = true, $fn=10);
                }
            }
        }
    }
}

module device_holes() {
    scale_factor=37/36;
    
    color("red") scale([scale_factor,scale_factor,scale_factor])  union() {
        translate([19.9, -0.15, 0]) promitacka();

        translate([- 19.4, 0.4, 7])
            rotate([0, 0, 90])
                koleckaSlot();
    }
}

module box_door_hole() {
    thickness=3;
    doubleThickness=thickness*2;
    
    translate([0,3.85,145.4]) 
     rotate([0,0,180])
     door_mass_with_clearance((halfwidth-doubleThickness)*2, halflength*2 - doubleThickness, thickness);
}

difference() {
    main_body();
    device_holes();
    box_door_hole();
}