module single_hole(tx =0) {
    translate([tx, 0, 7]) rotate([0, 45, 0]) 
        cube([6, 20, 6], center=true);
}

module half() {
    difference() {
        linear_extrude(15) polygon([
          [0,-10],
          [12,-10],
          [35,0],
          [40,5],
          [40,15],
          [35,20],
          [30,20],
          [30,18],
          [33,18],
          [33,8],
          [0,8]
         ]);
        single_hole();
        single_hole(20);
    }
}

union() {
    half();
    mirror([1, 0, 0]) half();
}