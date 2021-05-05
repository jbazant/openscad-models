include<./includes/config.scad>
use<./includes/utils.scad>
use<./includes/models.scad>
use<../utils/circle-text.scad>

text_size = 3;
coin_base_outline = text_size + 2;

module coin_f1(t) {
  union() {
    flower2();
    difference() {
      coin_base(outline_width = coin_base_outline);
      translate([0, 0, top_h - 0.5]) circle_text(t, r = r - text_size - 1, s = text_size);
    }
  }
}

coin_f1("1940 1962 1986 2017 2020 ");