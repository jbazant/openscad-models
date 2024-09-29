tolerance=0.5;
d_1=70;
d_1_inner=45;
d_2=40;
d_2_inner=d_2-2;
brim=10;
h_bottom=26;
drilling_x_translate=60;
drilling_translate=[drilling_x_translate,0,0];
suck_x_translate=d_2/2;
suck_translate=[-suck_x_translate,0,0];

$fn=$preview ? 30 : 200;;
bottom_clearance=2;
top_clearance=1;
mid_height=h_bottom - top_clearance - bottom_clearance;

module drilling_mass() {
    difference() {

        
        // main hole
        cylinder(h=100, d=d_1+tolerance);
    }
}

module suck_mass() {
    difference() {
        union() {
            // bottom
            hull() {
                translate([0,0,h_bottom-1]) cylinder(h=1, d=d_2+brim);
                translate([0,0,h_bottom+4]) cylinder(h=1, d=d_2+4);
            }

            // top
            hull() {
                translate([0,0,h_bottom+5+10]) cylinder(h=0.1, d=d_2+4);
                translate([0,0,h_bottom+5+10+1]) cylinder(h=1, d=d_2+5);
            }
            
            // mid
            translate([0,0,h_bottom+5]) cylinder(h=10, d=d_2+4);
        }
        
        // cuts
        for(rz=[0:120:360]) {
            rotate([0,0,rz]) 
                translate([0,0,h_bottom+5+10]) cube([2.5, 100, 20],center=true);
        }
         
        // main hole
        cylinder(h=100, d=d_2+tolerance);
    }
}


module bottom_mass() {
    difference() {
        base_mass(h_bottom, brim)
        brushes();    
    }
}

module base_mass(h,b) {
    hull() {    
        translate(drilling_translate) cylinder(h=h, d=d_1+b);
        translate(suck_translate) cylinder(h=h, d=d_2+b);
    }
}

module brushes() {
    difference() {
        base_mass(h_bottom, brim+2);
        union() {
            base_mass(h_bottom, brim-2);
            hull() {
                translate([0,0,h_bottom-3]) base_mass(1, brim-2);
                translate([0,0,h_bottom-2]) base_mass(2, brim);
            }
        }

    }
}

module midhole() {
   translate([0,0,bottom_clearance + mid_height/2]) translate(suck_translate)
    rotate([0,90,0]) scale([mid_height/d_2_inner,1,1])
        {
        cylinder(h=drilling_x_translate + suck_x_translate, d=d_2_inner);
         sphere(d=d_2_inner);
    }
}




difference () {
    union() {
        bottom_mass();
        translate(suck_translate) suck_mass();
    }
    translate(drilling_translate) {
        cylinder(h=100, d=d_1_inner);
        translate([0,0,bottom_clearance]) cylinder(h=mid_height, d1=d_1, d2=d_1_inner);
    }
    translate(suck_translate) {
         translate([0,0,bottom_clearance + mid_height/2]) {
             cylinder(h=100, d=d_2_inner);
         }
    }
    midhole();
    brushes();
}
/**/