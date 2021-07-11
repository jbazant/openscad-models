
module logo(name, height) {
  color("blue")
  translate([-10, -10, 0])
  linear_extrude(height)
  scale([1/10, 1/10])
    import(str("./assets/", name, ".svg"));
}

module logoA() {
  h = 1;
  translate([1, 1, -h])
  scale([1.3, 1.3, 1])
    logo("cloudy", h);
}

module logoB() {
  h = 1;
  translate([-1, 0, -h])
    scale([1.1, 1.1, 1])
  logo("cloudy-day", h);
}

module logoC() {
  translate([1, 1, 0])
    scale([1.3, 1.3, 1]) {
      logo("v1", .6);
      logo("v1-cloudA", 1);
    }
}
