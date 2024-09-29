


module lock() {
    halfWidth=30/2-1.5;
    for(x=[-halfWidth, halfWidth]) {
        translate([x,-30/2+2.5,0])
         rotate([0,0,45]) 
         cube([1,1,2], center=true);
    }
}

module frameWithLock() {
    difference() {
        frame();
        lock();
    }
}

module door() {
    cube([25, 27.5, 4], center=true);
    translate([0, 0.5, 0]) cube([27, 28.5, 2], center=true);
    lock();
}

module frame() {
    difference() {
        translate([0, 1.25, 0]) cube([30, 30, 4], center=true);
        scale([1.01, 1.01, 1.01]) door();
    }
}

module doorHandle() {
    difference() {
        scale([1, 1, 0.3]) sphere(r=5);
        translate([0, -5, 0]) cube([10,10,10], center=true);
    }
    
}

module doorWithHandle() {
    difference() {
        door();
        translate([0,-30/2 + 4,2])doorHandle();
    }
}

translate([0, 5, 0]) rotate([90, 0, 0]) doorWithHandle();
translate([0, -5, 2.5]) rotate([-90, 0, 0]) frame();