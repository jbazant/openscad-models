// SVG models inspiration: https://www.autonalepky.cz/kategriorie-nalepek/zvirata/bazanti/
// SVG models edit tool: https://yqnn.github.io/svg-path-editor/
// multiple material guide: https://mattshub.com/blogs/blog/material-change

r = 24.4 / 2;
total_h = 2.6;

bottom_h = 1.2;
top_h = total_h - bottom_h;
img_h1 = top_h - 0.4;
img_h2 = img_h1 - 0.4;
img_h3 = img_h1 - 0.6;

fn = 100;
preview_bottom = false;

module pheasant3() {
  s = r / 90;
  rotate([0, 0, 5])
    scale([s, s, 1])
      translate([- 70, - 75, 0])
        union() {
          linear_extrude(img_h2)
            offset(delta = 0.7)
              import("./b-coins/models/pheasant3.svg");
          linear_extrude(img_h1)
            offset(delta = 0.7)
              import("./b-coins/models/grass.svg");
        }
}

module pheasant4() {
  s = r / 90;
  scale([s, s, 1])
    translate([- 70, - 75, 0])
      union() {
        linear_extrude(img_h2)
          import("./b-coins/models/pheasant4a.svg");
        linear_extrude(img_h1)
          import("./b-coins/models/pheasant4b.svg", convexity=50);
        translate([-17, 0, 0]) linear_extrude(img_h3)
          import("./b-coins/models/high-grass.svg", convexity=10);
      }
}

module deer1() {
  s = r / 110;
  scale([s, s, 1])
    translate([- 70, - 75, 0])
      union() {
        linear_extrude(img_h3)
          import("./b-coins/models/deer1a.svg");
        linear_extrude(img_h2)
          import("./b-coins/models/deer1b.svg");
        linear_extrude(img_h1)
          import("./b-coins/models/deer1c.svg");
      }
}

// too fine for printing
module deer2() {
  s = r / 100;
  scale([s, s, 1])
    translate([- 60, - 85, 0])
      union() {
        linear_extrude(img_h1)
          import("./b-coins/models/deer2.svg");
      }
}

module coin_base(fn) {
  if (!$preview || preview_bottom) {
    translate([0, 0, - bottom_h]) color("aqua")
      cylinder(r = r, h = bottom_h, center = false, $fn = fn);
  }

  difference() {
    cylinder(r = r, h = top_h, center = false, $fn = fn);
    // translate and +2 height just for better preview
    translate([0, 0, - 1])  cylinder(r = r - 2, h = top_h + 2, center = false, $fn = fn);
  }
}

module clear_fix() {
  difference() {
    // translate and +2 height just for better preview
    translate([0, 0, top_h / 2])cube([3 * r, 3 * r, top_h + 2], center = true);
    translate([0, 0, - 1]) cylinder(r = r - 1, h = top_h + 2);
  }
}

// ------ OUTPUT MODELS -----

module coin_p3() {
  union() {
    linear_extrude(img_h1)
      translate([0, 3])
        offset(delta = 0.18)
          text("JB", font = "Party LET", halign = "center", size = 6.5);
    coin_base(fn);
    difference() {
      pheasant3();
      clear_fix();
    }
  }
}

module coin_p3b() {
  union() {
    linear_extrude(img_h1)
      translate([0, 2])
        offset(delta = 0.18)
          text("J.B.", font = "SignPainter:style=HouseScript Semibold", halign = "center", size = 7);
    coin_base(fn);
    difference() {
      pheasant3();
      clear_fix();
    }
  }
}

module coin_p4() {
  union() {
    coin_base(fn);
    difference() {
      translate([0, - 3]) difference() {
        pheasant4();
        linear_extrude(img_h1)
          translate([0, - 1])
            text("JB", font = "SignPainter:style=HouseScript Semibold", halign = "center", size = 5);
      }
      clear_fix();
    }
  }
}

module coin_p4b() {
  union() {
    coin_base(fn);
    difference() {
      translate([0, - 3]) pheasant4();
      clear_fix();
    }
  }
}

module coin_d1() {
  union() {
    coin_base(fn);
    difference() {
      translate([- 1, - 3]) deer1();
      clear_fix();
    }
  }
}

module coin_d1() {
  union() {
    coin_base(fn);
    difference() {
      translate([- 1, - 3]) deer2();
      clear_fix();
    }
  }
}


coin_d1();
coin_d2();
*coin_p3();
*coin_p3b();
*coin_p4();
*coin_p4b();


