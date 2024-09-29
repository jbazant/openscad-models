$fn=$preview ? 20 : 50;

a=20;
b=31;
c=140;
t1=100;
t2=208;

module point(x,y,z) {
    translate([x,y,z]) sphere(d=1.6);
}

module one_side() {
    union() {
        // bottom cube
        hull() {
            point(0,0,0);
            point(0,a,0);
            point(0,0,t1);
            point(0,a,t1);
        }
        hull() {
            point(0,a,0);
            point(0,a,t1);
            point(c,b,0);
            point(c,b,t1);
            
        }
        hull() {
            point(c,0,0);
            point(c,b,0);
            point(c,0,t1);
            point(c,b,t1);
        }
        
        // roof walls
        hull() {
            point(0,0,t1);
            point(0,a,t1);
            point(c/2-20,0,t2);
            point(c/2-20,5,t2);

        }
        hull() {
            point(c,0,t1);
            point(c,b,t1);
            point(c/2+20,0,t2);
            point(c/2+20,8,t2);
        }
        hull() {
            point(c,b,t1);
            point(0,a,t1);
            point(c/2-20,5,t2);
            point(c/2+20,8,t2);
        }
        
        // ceiling
        hull() {
            point(c/2-20,0,t2);
            point(c/2-20,5,t2);
            point(c/2+20,0,t2);
            point(c/2+20,8,t2);
        }
    }
}

difference() {
    union() {
        one_side();
        mirror([0,1,0]) one_side();
    }
    // makes bottom flat
    translate([0,0,-1]) cube([300,300,2], center=true);
}
    