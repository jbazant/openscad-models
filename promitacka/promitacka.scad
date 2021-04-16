promitacka_d = 36;
promitacka_l = 138;

stred_l = 24;

promitacka_madlo_l = 74;
promitacka_madlo_w = 22;

predek_l = 40;

// ?
cudlik_d = 7;
cudlik_h = 4.5;

module madlo(l) {
    intersection() {
        cylinder(d = promitacka_d, h = l, center = true, $fn = 50);
        cube([promitacka_madlo_w, promitacka_d, l], center = true);
    }
}
*madlo();

module predek() {
    cylinder(d = promitacka_d, h = predek_l, center = true, $fn = 50);
}
*predek();

module telo() {
    // aproximace prechodu
    hull() {
        translate([0, 0, predek_l / 2 + 24]) predek();
        translate([0, 0, 1 / 2]) madlo(1);
    }

    // hack na odstraneni diry od intersection
    madlo(promitacka_madlo_l / 5);

    // madlo
    translate([0, 0, - promitacka_madlo_l / 2]) intersection() {
        madlo(promitacka_madlo_l);
        sphere(d = promitacka_madlo_l, $fn = 50);
    }
}
*telo();

module cudlik() {
    translate([0, 36 / 2, - cudlik_d / 2])
        rotate([90, 0, 0])
            cylinder(d = cudlik_d, h = 2 * cudlik_h, center = true, $fn = 20);
}
*cudlik();

module cudlik_zasuvka() {
    hull() {
        translate([0, 0, - 5]) cudlik();
        translate([0, 0, predek_l + stred_l + cudlik_d / 2]) cudlik();
    }
}
*cudlik_zasuvka();

module promitacka() {
    translate([0, 0, promitacka_madlo_l]) union() {
        telo();
        cudlik_zasuvka();
    }
}

promitacka();