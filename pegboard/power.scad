h=8;
hh=h/2;

module skadisHook() {
    rotate([0,-90,0]) import("skadisHook.stl");
}

translate([0,0,hh]) difference() {
    union() {
        translate([19, -2.5, 3.16 - hh]) skadisHook();
        minkowski() {
            cube([37, 18, h - 2],center=true);
            sphere(r=1);
        }
    }

    cylinder(h=h, d=3, $fn=50, center=true);
    cylinder(h=hh, d=6.2, $fn=6);    
}