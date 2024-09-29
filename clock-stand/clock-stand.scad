x=42;
y=222;
y_hole=155;
z=13;
z2=2*(2.5+0.8)+3.5;

difference() {
    union() {
        translate([-x/2, 0, 0]) {
            cube([x, y, 2.5+0.8]);
            translate([0, y_hole, 0]) cube([x, y-y_hole, z2]);
        }
        
        translate([0, y_hole, 0]) {
            cylinder(d=x, h=z2, $fn=100);
            cylinder(d=10, h=z, $fn=50);
        }
        
        translate([0, y, 0]) {
            translate([0, 0,-8]) cylinder(d=x, h=4, $fn=100);
            cylinder(d=x, h=z2, $fn=100);
        }
        
        intersection() {
            translate([-x/2, 0, -4]) cube([x, y+6, z]);
            translate([0, y, -4]) cylinder(d=x, h=4, $fn=100);
        }
        translate([0, y+11.5-3.75+6, -4]) cylinder(r=3.75, h=4, $fn=50);
    }
    
    // screw hole 
    translate([0, y_hole, 0]) {
        cylinder(d=3, h=z, $fn=50);
        translate([0, 0, z-3]) cylinder(d=5.5, h=3, $fn=50);
        cylinder(d=6, h=2.5, $fn=6);
    }
    
    translate([-x/2, 0, 2.5+0.8]) {
        cube([x, 206, 3.5]);
    }
    
    translate([0,y+18,10]) rotate([160,0,0]) cube([x,2*x,10], center=true);
}
