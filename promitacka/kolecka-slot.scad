maxLength = 138;

circleWidth = 3.8;
circleDia = 33;

wallWidth = 2;

lockWidth = 2;
lockHeight = 6;
lockShiftY = 0.6;

handleWidth = 10;

doubleWall = 2 * wallWidth;
cubeMassHeight = (circleDia + doubleWall) / 2;
cubeMassWidth = circleDia + doubleWall;
cubeMassLength = circleWidth + doubleWall;

nOffSegments = floor((maxLength - (handleWidth + doubleWall + 2)) / cubeMassLength);

realLength = nOffSegments * cubeMassLength + doubleWall;

echo("kolecka slot length ", realLength);

module cubeMass() {
    translate([0, (realLength) / 2, 0])
        intersection() {
            translate([0, 0, cubeMassHeight / 2])
                cube([cubeMassWidth, realLength + doubleWall, cubeMassHeight], center = true);

            translate([0, 0, (3 / 4) * cubeMassHeight])
                rotate([0, 45, 0])
                    cube([cubeMassWidth, realLength + doubleWall, cubeMassWidth], center = true);
        }
}

module cylinderMass() {
    translate([0, (realLength + wallWidth) / 2, cubeMassHeight])
        rotate([90, 0, 0])
            cylinder(h = realLength + wallWidth, d = circleDia, center = true);

    translate([0, 0, cubeMassHeight])
        rotate([90, 0, 0])
            cylinder(h = wallWidth, d = 2, center = true, $fn = 20);
}

module koleckaSlot() {
    translate([- cubeMassHeight, 0, wallWidth])
        rotate([90, 0, 90])
            union() {
                cubeMass();
                cylinderMass();
            }
}

module topCap() {
    translate([- cubeMassHeight, 0, realLength + doubleWall])
        rotate([90, 0, 90]) {
            hull() {
                translate([0, .5, 0])
                    intersection() {
                        translate([0, 0, cubeMassHeight / 2])
                            cube([cubeMassWidth, 1, cubeMassHeight], center = true);

                        translate([0, 0, (3 / 4) * cubeMassHeight])
                            rotate([0, 45, 0])
                                cube([cubeMassWidth, 1, cubeMassWidth], center = true);
                    }

                for (x = [- 1, 1]) {
                    for (z = [0, 1]) {
                        translate([x * (cubeMassWidth / 2 - 1), .5 + handleWidth, z * (cubeMassHeight - 2+ circleDia /
                            2) + 1])
                            rotate([90, 0, 0])
                                cylinder(r = 1, h = 1, $fn = 10);
                    }
                }
            }

            hull() {
                translate([0, .5, cubeMassHeight])
                    rotate([90, 0, 0])
                        cylinder(h = 1, d = circleDia, center = true);

                for (x = [- 1, 1]) {
                    for (z = [0, 1]) {
                        translate([x * (cubeMassWidth / 2 - 1), .5 + handleWidth, z * (cubeMassHeight - 2 + circleDia /
                            2) + 1])
                            rotate([90, 0, 0])
                                cylinder(r = 1, h = 1, $fn = 10);
                    }
                }
            }
        }
}

union() {
    //koleckaSlot();
    topCap();
}