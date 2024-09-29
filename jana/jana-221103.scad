h = 20;
l1 = 22+2*8;
l2 = 30;
w = 18;

module beam(h) {
    rotate([0,-90,0]) linear_extrude(h) polygon([
        [0, 0],
        [20, 0],
        [20, 2],
        [10, 8],
        [0, 2],
        [0, 0],
    ]);
}
module hook(h) {
    linear_extrude(h) polygon([
        [-5, 5],
        [-12, 0],
        [-18, 0],
        [-25, 5],
        [-30, 30],
        [-23, 30],
        [-16.5, 15],
        [-16.5, 10],
        [-13.5, 10],
        [-13.5, 15],
        [-5, 33],
        [0, 30],
        [0, 25]
    ]);
}
    
module body() {
    beam(3);
    translate([-w+2, 0, 0]) beam(2);
    cube([3, l1, h]);
    translate([-w, l1, 0]) rotate([0,0,180]) beam(18);
    translate([-w-5, -l2, 0]) cube([5, l1+l2, h]);
    translate([-w, -l2-25]) hook(20);
}

body();