// multiple material guide: https://mattshub.com/blogs/blog/material-change
include<./includes/config.scad>
use<./includes/utils.scad>
use<./includes/models.scad>

module coin_p3a() {
  simple_coin() {
    union() {
      linear_extrude(img_h1)
        translate([0, 3])
          offset(delta = 0.18)
            text("JB", font = "Party LET", halign = "center", size = 6.5);
      pheasant3();
    }
  }
}


module coin_p3b() {
  simple_coin() {
    union() {
      linear_extrude(img_h1)
        translate([0, 2])
          offset(delta = 0.18)
            text("I.B.", font = "SignPainter:style=HouseScript Semibold", halign = "center", size = 7);
      pheasant3();
    }
  }
}

module coin_p4a() {
  simple_coin() {
    translate([0, - 3]) difference() {
      pheasant4();
      linear_extrude(img_h1)
        translate([0, - 1])
          text("JB", font = "SignPainter:style=HouseScript Semibold", halign = "center", size = 5);
    }
  }
}

module coin_p4b() {
  simple_coin() translate([0, - 3]) pheasant4();
}

module coin_d1() {
  simple_coin () translate([- 1, - 3]) deer1();
}

module coin_d2() {
  simple_coin () translate([- 1, - 3]) deer2();
}


* coin_d1();
* coin_d2();
* coin_p3a();
coin_p3b();
* coin_p4a();
* coin_p4b();
* coin_with_text("1940 1962 1986 2017 2020 ") flower2();

