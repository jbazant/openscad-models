difference() {
    hull() {
        translate([0,0,0]) cylinder(r=2, h=0.8, center=true, $fn=20);
        translate([81,0,0]) cylinder(r=2, h=0.8, center=true, $fn=20);
        translate([81,50,0]) cylinder(r=2, h=0.8, center=true, $fn=20);
        translate([0,50,0]) cylinder(r=2, h=0.8, center=true, $fn=20);
    }

    translate([3,23,0]) cube([75, 0.4, 1]);

    translate([3, 0, 0])linear_extrude(1) {
        translate([0, 40]) text("Ing. Jiří Bažant", 6);
        translate([0, 33]) text("konzultace a vývoj software", 4);
        translate([0, 27]) text("pro web a mobil", 4);
        
        translate([16, 16]) text("WEB", 4, halign="right");
        translate([19, 16]) text("bazant.dev", 4);
        
        translate([16, 10]) text("GSM", 4, halign="right");
        translate([19, 10]) text("+420 723 734 678", 4);
        
        translate([16, 4]) text("EMAIL", 4, halign="right");
        translate([19, 4]) text("j.bazant+v@gmail.com", 4);
    }
};
