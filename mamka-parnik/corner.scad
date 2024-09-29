d1=16;
d2=22;

delta=3;
dd=d2-delta;

// ------------

final("T");

module final(v) {
    if (v == "S") {
        partV(85, 1, "S");
    } else if (v == "I") {
        partV(75, 2, "I");
    } else if (v == "J") {
        partV(115, -4, "J");
    }  else if (v == "T") {
        partT();
    } else {
        echo("UNKNOWN VARIANT!");
    }
}

// ------------
module single_tube_z(l=58, l2=d2, t="") {
    difference() {
        cylinder(d=d2, h=l, $fn=6);
        translate([0,0,l2]) cylinder(d=d1, h=l, $fn=100);
        translate([0,0,l-1]) cylinder(d1=d1, d2=d1+1, h=1, $fn=100);
    }
    translate([-dd/2+1, 3, l/2])
    rotate([0, -90, -30])
        linear_extrude(1)
        text(t, halign="center", size=5);
    
}

module single_tube_y(rz) {
    l=58-d2/2;
    l2=d2/2;
    
    translate([0,0,(d2-delta)/2]) 
        rotate([90, 0, rz])
        single_tube_z(l, l2);
}

module single_hole_fix(rz) {
    l=58-d2/2;
    l2=d2/2;
    
    translate([0,0,(d2-delta)/2]) 
        rotate([90, 0, rz])
        translate([0,0,l2]) 
        cylinder(d=d1+.2, h=l, $fn=100);
}

module support_triangle_base(alpha=90) {
    translate([0, 0, -.5])
        linear_extrude(1)
        scale([10,10])
        polygon([[0,0], [1,0], [cos(alpha), sin(alpha)], [0,0]]);
}

module support_triangle_xy(alpha=90, fix_my_math=0) {
     translate([d2/2-.5, -d2/2+.5-fix_my_math, dd/2])
        rotate([0, 0, -90]) 
        support_triangle_base(alpha);
}

module support_triangle_xz(alpha=90, rz=0) {
    rotate([0, 0, rz])
        translate([dd/2, 0, dd])
        rotate([90, 0, 0]) 
        support_triangle_base(alpha);
}

module support_triangle_yz(alpha=90, rz=0) {
    rotate([0, 0, rz])
        translate([0, -dd/2, dd])  
        rotate([180, -90, 0]) 
        support_triangle_base(alpha);
}


module partV(rz=90, fix_my_math=0, t="") {
    difference() {
        union() {
            rotate([0, 0, rz/2]) single_tube_z(t=t);
            single_tube_y(0);
            single_tube_y(rz);
        }
        single_hole_fix(0);
        single_hole_fix(rz);
    }
    
    support_triangle_yz(90);
    support_triangle_xz(90, rz-90);
    support_triangle_xy(rz, fix_my_math);
}

module partT() {
        difference() {
        union() {
            single_tube_z();
            single_tube_y(0);
            single_tube_y(180);
        }
        single_hole_fix(0);
        single_hole_fix(180);
    }
    
    support_triangle_yz(90);
    support_triangle_yz(90, 180);
}



module testik() {
    difference() {
        single_tube_y(0);
        single_hole_fix(0);
    }
}