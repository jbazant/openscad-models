$fn=50;
h=6;

module pich_side() {
    linear_extrude(2) polygon([
       [0, 0],
      [10, 0],
      [5, 60],
      [1, 180],
      [0, 180],
      [0, 0]
    ]);
}

module pich() {
  hull() {
    pich_side();
    mirror([1,0,0]) pich_side();
    translate([-1,0,0]) cube([2,50,h]);
  }
}
    

module stitek(texts, size=10, text_rot=0) {
    texts_len=len(texts);
    difference() {
        hull() {
            translate([-20,0,0]) cylinder(h=h,r=2);
            translate([20,0,0]) cylinder(h=h,r=2);
            translate([-20,-20,0]) cylinder(h=h,r=2);
            translate([20,-20,0]) cylinder(h=h,r=2);
        }
        for(position=[0 : texts_len-1]) {
            text=texts[position];
            offset=(position - (texts_len - 1)/2) * size + position;
            
            translate([0,0,2*h/3])
                linear_extrude(h/3) 
                translate([0,offset-8,0])
                rotate([0,0,180-text_rot]) 
                text(text, size=size, halign="center");
            translate([0,0,h/3])
                rotate([0,180,0])
                linear_extrude(h/3) 
                translate([0,offset-8,0])
                rotate([0,0,180-text_rot]) 
                text(text, size=size, halign="center");
        }
    }
}

union() {
    pich();
    stitek(["PIERIS", "JAPANICA"], 6, 0);
}


