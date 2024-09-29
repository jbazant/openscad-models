// SVG models inspiration: https://www.autonalepky.cz/kategriorie-nalepek/zvirata/bazanti/
// SVG models edit tool: https://yqnn.github.io/svg-path-editor/
include<./config.scad>

models_path = "../models/";

module svg(h, name) {
  linear_extrude(h)
    import(str(models_path, name, ".svg"));
}

module pheasant3() {
  s = r / 90;

  rotate([0, 0, 5])
    scale([s, s, 1])
      translate([- 70, - 75, 0])
        union() {
          svg(img_h2, "pheasant3");
          linear_extrude(img_h1)
            offset(delta = 0.7)
              import(str(models_path, "grass.svg"));
        }
}

module pheasant4() {
  s = r / 90;

  scale([s, s, 1])
    translate([- 70, - 75, 0])
      union() {
        svg(img_h2, "pheasant4a");
        svg(img_h1, "pheasant4b");
        translate([- 17, 0, 0]) svg(img_h3, "high-grass");
      }
}

module deer1() {
  s = r / 110;

  scale([s, s, 1])
    translate([- 70, - 75, 0])
      union() {
        svg(img_h3, "deer1a");
        svg(img_h2, "deer1b");
        svg(img_h1, "deer1c");
      }
}

// too fine for printing
module deer2() {
  s = r / 100;

  scale([s, s, 1])
    translate([- 60, - 85, 0])
      svg(img_h1, "deer2");
}

module flower2(scale_base = 180) {
  s = r / scale_base;

  scale([s, s, 1])
    translate([- 82, - 82, 0])
      union() {
        svg(img_h3, "flower2a");
        svg(img_h1, "flower2b");
        svg(img_h2, "flower2c");
      }
}

module mother(scale_base = 80) {
  s = r / scale_base;

  scale([s, s, 1])
    translate([- 43, - 75, 0])
      svg(img_h1, "mother");
}

module atom(scale_base = 180) {
  s = r / scale_base;

  translate([- 6.4, - 6, 0])
    scale([s, s, 1])
      svg(img_h1, "atom");
  cylinder(r=2, h=top_h, $fn=50);
}