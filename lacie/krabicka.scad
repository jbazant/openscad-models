use<../door/door.scad>

// size of disk (inner size of box)
diskSize = [135, 87, 28];

// one cable hole size
cableSize = [100, 31, 14]; //[100, 28, 10];

// thickness of walls (size of box is diskSize + 2*wallThickness + cableSize_height)
wallThickness = 3;
wallThicknessB = 4;

// rounded corners radius
cornerRadius = 10;

// COMPUTDED
// real size of the box
boxSize = diskSize + [2 * wallThickness, 2 * wallThicknessB, wallThickness + cableSize[2]];

module tube(radius, outerSize) {
    bcorner = [outerSize[0] / 2 - radius, outerSize[1] / 2 - radius, radius];
    tcorner = [bcorner[0], bcorner[1], outerSize[2]]; // last one should be outerSize[2] - 1

    hull() {
        translate(bcorner) sphere(r = radius, $fn = 50);
        translate([- bcorner[0], bcorner[1], bcorner[2]]) sphere(r = radius, $fn = 50);
        translate([- bcorner[0], - bcorner[1], bcorner[2]]) sphere(r = radius, $fn = 50);
        translate([bcorner[0], - bcorner[1], bcorner[2]]) sphere(r = radius, $fn = 50);

        translate(tcorner) cylinder(r = radius, h = 1, $fn = 50);
        translate([- tcorner[0], tcorner[1], tcorner[2]]) cylinder(r = radius, h = 1, $fn = 50);
        translate([- tcorner[0], - tcorner[1], tcorner[2]]) cylinder(r = radius, h = 1, $fn = 50);
        translate([tcorner[0], - tcorner[1], tcorner[2]]) cylinder(r = radius, h = 1, $fn = 50);
    }
}

module roundedBox(radius, outerSize) {
    bcorner = [outerSize[0] / 2 - radius, outerSize[1] / 2 - radius, radius];
    tcorner = [bcorner[0], bcorner[1], outerSize[2] - radius];

    hull() {
        translate(bcorner) sphere(r = radius, $fn = 50);
        translate([- bcorner[0], bcorner[1], bcorner[2]]) sphere(r = radius, $fn = 50);
        translate([- bcorner[0], - bcorner[1], bcorner[2]]) sphere(r = radius, $fn = 50);
        translate([bcorner[0], - bcorner[1], bcorner[2]]) sphere(r = radius, $fn = 50);

        translate(tcorner) sphere(r = radius, $fn = 50);
        translate([- tcorner[0], tcorner[1], tcorner[2]]) sphere(r = radius, $fn = 50);
        translate([- tcorner[0], - tcorner[1], tcorner[2]]) sphere(r = radius, $fn = 50);
        translate([tcorner[0], - tcorner[1], tcorner[2]]) sphere(r = radius, $fn = 50);
    }
}

module box() {
    difference() {
        // box
        roundedBox(1, boxSize);

        // space for a disk
        translate([0, 0, 1 + cableSize[2]]) tube(cornerRadius, diskSize);

        // space for cables
        translate([0, cableSize[1] / 2 + 1, 1]) tube(cornerRadius/2, cableSize);
        translate([0, - (cableSize[1] / 2 + 1), 1]) tube(cornerRadius/2, cableSize);

        // door hole
        translate([0.5, 0, boxSize[2] - 2])
            rotate([0, 0, 90])
                door_mass_with_clearance(diskSize[1], diskSize[0] + wallThickness, 2, 0.15);
    }
}

module box_door() {
    roundedEdgeLength = diskSize[1] + 4;
    difference() {
        door(diskSize[1], diskSize[0] + wallThickness, 2, true, "Lacie backup disk");
        translate([- roundedEdgeLength / 2, - (diskSize[0] + wallThickness) / 2, 0])
            rotate([180, 0, 0])
                rotate([0, 90, 0])
                    difference() {
                        cube([1, 1, roundedEdgeLength]);
                        cylinder(r = 1, h = roundedEdgeLength, $fn = 50);
                    }
    }
}

module box_label() {
    translate([boxSize[0]/2, 0, boxSize[2]/2])
        rotate([90,0,90])
            linear_extrude(1)
                text("backup disk", halign="center", valign="center");
}

box();
box_label();
//box_door();
