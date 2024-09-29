h=3;
alpha=15;

module side_hole() {
    translate([0, 29, 0]) {
        difference() {
            cube([60,5,h+2], center=true);
            cube([10,5,h+2], center=true);
        }
    }
}

difference() {
    cube([70,70,h], center=true);
    cube([46,46,h+1], center=true);
    side_hole();
    rotate([0,0,180])side_hole();
    rotate([0,0,-alpha]) {
        rotate_extrude(angle=2*alpha, $fn=360) translate([30,0]) square(5, center= true);
        rotate_extrude(angle=2*alpha, $fn=360) translate([-30,0]) square(5, center= true);
    }
    translate([-40, -40, -h/2]) rotate([0,-2,0]) cube([80,80,2*h]);
}
