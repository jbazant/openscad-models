nOffSegments=3;

circleWidth=3.8;
circleDia=33;

wallWidth=2;

lockWidth=2;
lockHeight=6;
lockShiftY=0.6;

doubleWall=2*wallWidth;
cubeMassHeight=(circleDia+doubleWall)/2;
cubeMassWidth=circleDia+doubleWall;
cubeMassLength=circleWidth+doubleWall;


module cubeMass() {
    intersection() {
        translate([0, 0, cubeMassHeight/2])
         cube([cubeMassWidth, cubeMassLength, cubeMassHeight], center=true);
        
        translate([0, 0, (3/4)*cubeMassHeight])
         rotate([0, 45, 0])
         cube([cubeMassWidth, cubeMassHeight, cubeMassWidth], center=true);
    }  
}

module cylinderHole() {
    translate([0, 0, cubeMassHeight]) 
     rotate([90, 0, 0]) 
     union() {
        cylinder(h=circleWidth, d=circleDia, center=true);
        cylinder(h=cubeMassLength, d=circleDia-5, center=true);
    }
}

module lock() {
    translate([-lockWidth/2, circleWidth/2-lockShiftY, wallWidth]) {
        color("blue")
         cube([lockWidth, wallWidth+lockShiftY, lockHeight]);

        color("white") 
         hull() {
            translate([0,0,lockHeight])          
             cube([lockWidth, wallWidth+lockShiftY, 0.1]);
        
            translate([lockWidth/2, wallWidth/2, lockHeight]) 
             rotate([30,0, 0]) 
             rotate([0, 90, 0]) 
             cylinder(h=lockWidth, d=wallWidth+lockShiftY, center=true, $fn=6);
        }
    }
}

for(y=[1:nOffSegments]) {
translate([0, y*cubeMassLength-cubeMassLength/2, 0]) union() {
    difference() {
        cubeMass();
        cylinderHole();
    }
    lock();
}
}
    