use <MCAD/boxes.scad>
use <MCAD/triangles.scad>

// size of disk (inner size of box)
diskSize=[135, 87, 28];

// one cable hole size
cableSize=[100, 28, 10];

// gap between holes
gap=2;

// thickness of walls (size of box is diskSize + 2*wallThickness + cableSize_height)
wallThickness=3;

// rounded corners radius
cornerRadius=10;

// approx lenght of hinges (some clearance is added)
hingeSize=10;

// hole fore finger to allow removing disk from the box
diskRemovalDHoleDiameter=30;


// COMPUTDED

// size of the latch
latchHoleWidth = diskRemovalDHoleDiameter + 2; // 1mm to both sides

// real size of the box
boxSize=diskSize+[2*wallThickness, 2*wallThickness, wallThickness+cableSize[2]];

halfWall=wallThickness/2;
outerCornerRadius=cornerRadius+wallThickness;

module tube(size, r) {
    difference() {
        roundedCube(size+[0,0,r], r);
        // todo why to I need 0.1?
        translate([0,0,size[2]+0.1]) cube(size + [0,0, r-size[2]]);
    }
}

module diskSpace() {
    translate([0,0,cableSize[2]]) tube(diskSize, cornerRadius);


    for(y=[0,1]) {
        xOffset = (diskSize[0]-cableSize[0])/2;
        yOffset = y*(cableSize[1]+gap) + (diskSize[1]-2*cableSize[1]-gap)/2;
        translate([xOffset,yOffset,0]) tube(cableSize, cornerRadius);
    }
}

module diskBox() {
    difference() {
        roundedCube(boxSize, outerCornerRadius, true); 
        translate([wallThickness, wallThickness, wallThickness]) diskSpace();
    }
}

module hingeHole() {
    difference() {
        union() {
            cube([hingeSize, wallThickness, halfWall]);
            rotate([0,90,0]) translate([-halfWall,halfWall,0]) cylinder(h=hingeSize, r=halfWall, $fn=10);
        }
        rotate([0,90,0]) translate([-halfWall,halfWall,0]) cylinder(h=hingeSize, r=halfWall/2, $fn=10);
    }
}

module hingeV2(width) {
    cylinderDepth=1;
    hingeRadius=halfWall;
    
    rotate([0,90,0]) translate([-halfWall,halfWall,0]) 
     difference() {
        union() {
            translate([-wallThickness/2-wallThickness*0.1, -wallThickness/2, 0]) 
             cube([wallThickness, wallThickness*1.1, width]);
            //cylinder(h=width, r=hingeRadius, $fn=20);
            // triangle under hinde - use only as a spacer for difference
            translate([wallThickness/2-wallThickness*0.1, -wallThickness/2, 0]) 
             triangle(wallThickness, 1, hingeSize);
        }
        cylinder(cylinderDepth, hingeRadius, 0, $fn=20);
        translate([0,0,width]) rotate([180, 0, 0]) cylinder(cylinderDepth, hingeRadius, 0, $fn=20);
        
    }
}

module hingeHole(hingeSize, holesCount) {
    color("red") union() {
        translate([0, -halfWall, boxSize[2]-wallThickness]) {
            translate([0, wallThickness, halfWall]) 
             difference() {
                translate([0, -wallThickness/2, 0]) cube([boxSize[0], wallThickness/2, wallThickness/2]);
                rotate([0,90,0]) cylinder(boxSize[0], r=halfWall, $fn=20);
             }
             
            translate([0, halfWall, 0])
             for(n=[0:holesCount-1]) {
                dx=n*(boxSize[0]-hingeSize-2*outerCornerRadius)/(holesCount-1);
                 
                translate([dx+outerCornerRadius, 0, 0]) hingeV2(hingeSize);
                
                    
            }
        }
    }
}

module latchHole(latchWidth) {
    latchHeight=latchWidth/2+5;
    cutWidth=latchWidth-10;
    
    translate([(boxSize[0]-latchWidth)/2, boxSize[1]-wallThickness, boxSize[2]]) 
     union() {
        cube([latchWidth, wallThickness+1, wallThickness+1]);
        translate([(latchWidth-cutWidth)/2, wallThickness, -latchHeight]) 
         rotate([45, 0, 0])
         cube([cutWidth, halfWall, halfWall]);
    }
}

module diskRemovalHole(holeDia) {
    translate([boxSize[0] / 2, boxSize[1], boxSize[2]]) rotate([90,0,0]) cylinder(h=2*wallThickness, d=holeDia);
}

module coverframe() {
    color("blue") 
     translate([0, 0, boxSize[2]]) 
     difference() {
        roundedCube([boxSize[0], boxSize[1], halfWall], outerCornerRadius, true);
        
        translate([halfWall, halfWall, 0]) 
         roundedCube(boxSize-[wallThickness, wallThickness, 0], outerCornerRadius-halfWall, true); 
        
        translate([halfWall, 0, 0]) 
         cube([diskSize[0]+wallThickness, outerCornerRadius, wallThickness]);
    }
    
    
}

module main() {
    difference() {
        union() {
            diskBox();
            coverframe();
        }
        hingeHole(hingeSize, 3);
        // todo more hinge space
        
        // todo improve!
        latchHole(latchHoleWidth);
        diskRemovalHole(diskRemovalDHoleDiameter);
        
        // todo text
    }
}

module cover() {
    //roundedCube([boxSize[0], boxSize[1], wallThickness], outerCornerRadius, sidesonly=true, center=true);
    hull();
    // todo maybe use reference object "roundedbox - main"
    // todo with clearance 0.2mm
}

main();
cover();

//hingeHole(hingeSize, 3);





