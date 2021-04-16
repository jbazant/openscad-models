maxLength = 138;

circleWidth=3.8;
circleDia=33;

wallWidth=2;

lockWidth=2;
lockHeight=6;
lockShiftY=0.6;

handleWidth=10;

doubleWall=2*wallWidth;
cubeMassHeight=(circleDia+doubleWall)/2;
cubeMassWidth=circleDia+doubleWall;
cubeMassLength=circleWidth+doubleWall;



nOffSegments= floor((maxLength - (handleWidth + doubleWall + 2))/cubeMassLength);

realLength=nOffSegments*cubeMassLength;

module cubeMass() {
    translate([0, (realLength)/2, 0])
    intersection() {
        translate([0, 0, cubeMassHeight/2])
         cube([cubeMassWidth, realLength+doubleWall, cubeMassHeight], center=true);
        
        translate([0, 0, (3/4)*cubeMassHeight])
         rotate([0, 45, 0])
         cube([cubeMassWidth, realLength+doubleWall, cubeMassWidth], center=true);
    }  
}

module cylinderHole() {
    translate([0, realLength/2, cubeMassHeight]) 
     rotate([90, 0, 0]) 
     cylinder(h=realLength, d=circleDia-5, center=true);
    
    translate([0, realLength, cubeMassHeight]) 
     rotate([90, 0, 0]) 
     cylinder(h=wallWidth, d=2, center=true, $fn=10);
}
*cylinderHole();

module singleCylinder() {
    translate([0, circleWidth/2, cubeMassHeight]) 
     rotate([90, 0, 0]) 
     cylinder(h=circleWidth, d=circleDia, center=true);
}

module lock() {
    translate([-lockWidth/2, -lockShiftY, wallWidth]) {
        color("blue")
         cube([lockWidth, wallWidth+lockShiftY, lockHeight]);

        color("white") 
         hull() {
            translate([0,0,lockHeight])          
             cube([lockWidth, wallWidth+lockShiftY, 0.1]);
        
            translate([lockWidth/2, wallWidth/2-0.1, lockHeight]) 
             rotate([30,0, 0]) 
             rotate([0, 90, 0]) 
             cylinder(h=lockWidth, d=wallWidth+lockShiftY, center=true, $fn=6);
        }
    }
}
*lock();

module handle() {
    hull() {
        translate([0,-1,2]) sphere(d=2, $fn=10);
        translate([0,-8,8]) sphere(d=2, $fn=10);
        translate([0,-8,cubeMassHeight-2]) sphere(d=2, $fn=10);
        translate([0,-1,cubeMassHeight-2]) sphere(d=2, $fn=10);
    }
}

module main() {
    union() {
        difference() {
            cubeMass();
            cylinderHole();
            for(y=[0:nOffSegments-1]) {
                translate([0, y*cubeMassLength+wallWidth, 0])
                 singleCylinder();
            }

        }

        for(y=[0:nOffSegments-1]) {
            translate([0, y*cubeMassLength+wallWidth+circleWidth, 0])
             lock();             
        }
        
        handle();
    }
}
main();