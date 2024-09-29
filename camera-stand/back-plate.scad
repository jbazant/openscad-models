x1=20;
y1=14;
r1=4;
r2=1.6;
z=2;

fn=50;

module v1() {
    difference() {
        hull() {
            for(i=[-1,1]){
                for(j=[-1,1]){
                    translate([i*x1, j*y1, 0]) cylinder(r=r1,h=z, $fn=fn);
                }
            }
        }
        
        for(i=[-1,1]){
            for(j=[-1,1]){
                translate([i*x1, j*y1, 0]) cylinder(r=r2,h=z, $fn=fn);
            }
            translate([i*30, 0, 0]) cylinder(r=8,h=z, $fn=fn);
        }
        
        cylinder(r=8,h=z, $fn=fn);
    }
}

module v2() {
    difference() {
    union() {
        for(i=[-1,1]){
            hull() {
                translate([x1, i*y1, 0]) cylinder(r=r1,h=z, $fn=fn);
                translate([-x1, -i*y1, 0]) cylinder(r=r1,h=z, $fn=fn);
            }
        }
        cylinder(r=12,h=z, $fn=fn);
    }
    
    for(i=[-1,1]){
        for(j=[-1,1]){
            translate([i*x1, j*y1, 0]) cylinder(r=r2,h=z, $fn=fn);
        }
    }
    
    cylinder(r=8,h=z, $fn=fn);
    }
}

v2();