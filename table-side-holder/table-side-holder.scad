hook_lenght = 50;

c = 30;
fn = 50;

module rounded_line(a, b, s = 1) {
  module line_end(d) {
    cylinder(d = d, h = c - 4, center = true, $fn = fn);
    cylinder(d = d - 2, h = c, center = true, $fn = fn);

  }


  if (a < b) {
    hull() {
      line_end(a);
      translate([0, b]) line_end(a * s);
    }
  } else {
    hull() {
      line_end(b);
      translate([a, 0]) line_end(b * s);
    }
  }
}

module hook_body() {
  union() {
    difference() {
      rounded_line(60, 12);

      // nut
      sf = 229 / 224;
      translate([40, 15, 0])
        rotate([90, 0, 0])
          scale([sf, sf, 1])
            import_stl("./table-side-holder/Bolt_MK2.stl");

      // better print clearing
      translate([40, 0, 0])
        cube([10, 20, c - 4], center = true);
    }

    rounded_line(8, 66);
    translate([0, 66, 0])
      rotate([0, 0, - 1.83])
        rounded_line(50, 8, .6);
  }
}

module hook_stand(l) {
  translate([- l, 0, 0]) {
    rounded_line(l, 12);
    rotate([0, 0, - 3.4])
      rounded_line(12, 40, .6);
  }
}

hook_body();
hook_stand(hook_lenght);



