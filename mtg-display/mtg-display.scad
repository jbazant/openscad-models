/* [Card dimensions ] */
// spinbox Card height (including sleeve)
card_l = 93; //[::non-negative float]
// spinbox Card width (including sleeve)
card_w = 67; //[::non-negative float]

/* [Box properties] */
// slider Tilt of the card in the display
display_tilt = 10; //[0:90]
// Overhang in front of the card
display_overhang = 2.2; //[::non-negative float]

module card_display(inner_l, inner_w, tilt = 10, overhang = 2.2) {
    wall = 0.8;
    
    l = inner_l + wall;
    w = inner_w + (2 * wall);
    h = 1 + (2 * wall);
    r = 90 - tilt;

    crl = cos(r) * l;
    srh = sin(r) * h;

    difference() {
        hull() {
            rotate([r, 0, 0]) cube([w, l, h]);
            translate([0, -srh, 0]) cube([w, crl + srh, 1]);
        }
        
        rotate([r,0,0]) translate([ 0, 1, wall]) {
            translate([wall, 0, 0]) cube([w - (2 * wall), l, 1]);
            translate([overhang + wall, overhang, 0]) 
                cube([w - 2 * (wall + overhang), l, h]);
        }
    }
}

card_display(card_l, card_w, display_tilt, display_overhang);