use <promitacka.scad>
use <kolecka-slot.scad>
use <../door/door.scad>
use <krabicka_dekorace.scad>

halfwidth = 44.5;
halflength = 24.6;
height = 144;
module main_body() {
    spaceHeight = 15;

    translate([0, 0, - 2]) difference() {
        hull() {
            for (x = [- 1, 1]) {
                for (y = [- 1, 1]) {
                    translate([x * (halfwidth - 1), y * (halflength - 1), 0]) cylinder(r = 1, h = height, $fn = 10);
                }
            }
        }

        color("blue") hull() {
            for (x = [- 1, 1]) {
                for (y = [- 1, 1]) {
                    translate([x * (halfwidth - 7), y * (halflength - 7), height - spaceHeight])
                        cylinder(r = 1, h = spaceHeight, $fn = 10);
                }
            }
        }
    }
}

module device_holes() {
    scale_factor = 37 / 36;

    color("red") scale([scale_factor, scale_factor, 1])
        union() {
            translate([19.45, 0, 0])
                rotate([0, 0, 60])
                    promitacka();

            translate([- 18.95, 0.5, 0])
                rotate([0, 0, 90])
                    union() {
                        koleckaSlot();
                        topCap();
                    }
        }
}

module box_door_hole() {
    thickness = 3;
    doubleThickness = thickness * 2;

    translate([0, thickness / 2 - 0.1, 144 - thickness - 2 - 0.2])
        rotate([0, 0, 180])
            door_mass_with_clearance((halfwidth - doubleThickness) * 2, halflength * 2 - doubleThickness, thickness);
}

module box_door() {
    thickness = 3;
    doubleThickness = thickness * 2;

    translate([halfwidth, halflength, thickness])
        // to much clearance, fix this manually
        door((halfwidth - doubleThickness) * 2, halflength * 2 - doubleThickness + 0.2, thickness + 0.2, true);
}

module dekorace() {
    module sky() {
        module h1(d) {
            rotate([90, 0, 0]) rotate([0, 0, 18]) hvezda_b(d, 5);
        }

        module h2(d) {
            rotate([90, 0, 0]) hvezda_c(d, 8);
        }

        module h3(d) {
            rotate([90, 0, 0]) hvezda_b(d, 4);
        }

        translate([0, halflength, 100]) rotate([90, 0, 0]) mesic(35);

        for (i = [- 1, 1]) {
            translate([15, i * halflength, 125]) h1(12);
            translate([- 15, i * halflength, 70]) h1(16);
            translate([- 21, i * halflength, 10]) h1(14);

            translate([10, i * halflength, 50]) h2(20);
            translate([30, i * halflength, 20]) h2(9);
            translate([13, i * halflength, 12]) h2(8);
            translate([15, i * halflength, 30]) h2(11);
            translate([- 30, i * halflength, 120]) h2(12);
            translate([24, i * halflength, 100]) h2(15);

            translate([- 25, i * halflength, 40]) h3(10);
            translate([- 5, i * halflength, 30]) h3(15);
            translate([20, i * halflength, 70]) h3(10);
        }
    }

    module side_a() {
        module h1(d) {
            rotate([0, 90, 0]) rotate([0, 0, 90]) hvezda_c(d, 4);
        }

        translate([halfwidth, 0, 0]) {
            translate([0, 10, 8]) h1(18);
            translate([0, 10, 17]) h1(6);
            translate([0, - 2, 8]) h1(6);

            translate([0, - 11, 132]) rotate([0, 90, 0]) hvezda_b(14, 4);

            translate([0, 0, 71])
                rotate([90, 90, 90])
                    linear_extrude(2, center = true)
                        text("Na dobrou noc", 13, halign = "center", valign = "center");
        }
    }

    module side_b() {
        translate([-halfwidth, 0, 0]) {
            translate([0, 0, 128]) rotate([0, -90, 0]) hvezda_b(14, 5);
            translate([0, 0, 12]) rotate([0, 90, 0]) hvezda_b(14, 5);

            translate([0, 0, 71])
                rotate([-90, 90, 90])
                    linear_extrude(2, center = true)
                        text("Promítačka", 13, halign = "center", valign = "center");
        }
    }

    side_b();
    side_a();
    sky();
}


difference() {
    main_body();
    device_holes();
    box_door_hole();
    dekorace();
}
/**/
//box_door();
