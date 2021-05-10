module circle_text(t, r = 20, s = 5, ex = 1) {
  t_len = len(t);
  step = 360 / t_len;

  for (i = [0 : t_len - 1])
    rotate([0, 0, - i * step])
      translate([0, r, 0])
        linear_extrude(ex)
          text(t[i], valign = "baseline", halign = "center", size = s, font="style:bold");
}
