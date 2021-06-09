module sierpinsky_triangle(width, rec_steps, delta = 0.001) {
  function midpoint_h(a) = a * sin(60) / 3;

  module triangle(a) {
    translate([- a / 2, - midpoint_h(a)])
      polygon([[0, 0], [a, 0], [a / 2, sin(60) * a]]);
  }

  module rec_triangle(a, rec_steps) {
    if (rec_steps > 1) {
      triangle(a);
      for (i = [0:2]) {
        rotate(i * 120)
          translate([0, - 2 * midpoint_h(a)])
            rec_triangle(a / 2, rec_steps - 1);
      }
    }
  }

  offset(delta = delta)
    difference() {
      rotate(60) triangle(width);
      rec_triangle(width / 2, rec_steps);
    }
}

module sierpinsky_triangle_multilayer(height, width, rec_steps, delta = 0.001) {
  function midpoint_h(a) = a * sin(60) / 3;

  module one_step(a, curr_step, depth) {
    layer_height = height * depth / rec_steps;

    linear_extrude(layer_height)
      sierpinsky_triangle(a, curr_step, delta);

    if (curr_step > 1) {
      half_a = a / 2;

      rotate([0, 0, 180])
        one_step(half_a, curr_step - 1, depth - 1);

      for (i = [0:2])
        rotate([0, 0, i * 120])
          translate([0, - 2 * midpoint_h(half_a)])
            one_step(half_a, curr_step - 1, depth);
    }
  }

  one_step(width, rec_steps, rec_steps);
}

* sierpinsky_triangle(100, 5);
* sierpinsky_triangle_multilayer(10, 100, 5);
