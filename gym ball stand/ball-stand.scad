ball_radius=250;
precision=200;

module roundedCube(size, r, sidesonly, center) {
  s = is_list(size) ? size : [size,size,size];
  translate(center ? -s/2 : [0,0,0]) {
      hull() {
        translate([     r,     r]) cylinder(r=r, h=s[2], $fn=precision/2);
        translate([     r,s[1]-r]) cylinder(r=r, h=s[2], $fn=precision/2);
        translate([s[0]-r,     r]) cylinder(r=r, h=s[2], $fn=precision/2);
        translate([s[0]-r,s[1]-r]) cylinder(r=r, h=s[2], $fn=precision/2);
      }
    }
}

module mainBody() {
    difference() {
        translate([0,0,25]) 
         roundedCube([210,210,50], 20, center=true, sidesonly=true);
        
        translate([0,0,ball_radius]) 
         color("blue") 
         sphere(r=ball_radius, $fn=precision);
    }
} 

module description() {
    font="Verdana";
    
    color("red") 
     mirror([1,0,0]) 
     linear_extrude(1) {
        text("Gym ball stand", 5, font);
        
         translate([0, -10, 0]) 
         text("v0.1", 5, font);
     }
}

difference() {
    mainBody();
    cylinder(r=60, h=50, $fn=precision);
    translate([90, 80, 0]) description();
}
