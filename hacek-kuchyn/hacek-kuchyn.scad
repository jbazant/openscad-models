// Diameter of the "wire" you want to use for hook.
wire_width = 5;

// "Runded" end of wire length, use 0 for straight.
wire_cap_length = 1;

// Diameter of top hook. Note that this specifies diameter of pipe this hook should fit. Real diameter will be extended by wire width.
top_hook_inner_diameter = 28;

// Diameter of bottom hook. Note that this specifies diameter of pipe this hook should fit. Real diameter will be extended by wire width.
bottom_hook_inner_diameter= 12;

// Length of straight extension of bottom hook.
bottom_hook_length=15;


module simple_hook(w, d1, d2, l2, cl=1) {
    wire_radius = w/2;
    top_hook_radius = d1/2 + wire_radius;
    bottom_hook_radius = d2/2 + wire_radius;
    center_length = top_hook_radius + bottom_hook_radius;

    module wire_face() {
        rotate([0, 0, 22.5]) 
         circle(wire_radius, $fn=8);
    }

    module curved_wire(rad, angle) {
       rotate_extrude(angle=angle) 
        translate([rad, 0, 0]) 
        wire_face(); 
    }

    module straight_wire(length) {
        rotate([90, 0, 0]) 
         linear_extrude(length) 
         wire_face();
    }

    module wire_cap() {
        rotate([90, 0, 0]) 
         rotate([0, 0, 22.5]) 
         cylinder(h=cl, r1=wire_radius, r2=wire_radius/2, $fn=8);
    }

    module top_hook() {
        rotate([0, 0, 45])
         translate([-top_hook_radius, 0, 0])
         wire_cap();
        
        curved_wire(top_hook_radius, 225);
        
        translate([top_hook_radius, 0, 0])
         straight_wire(center_length);

        translate([center_length, -center_length, 0])
         rotate([0, 0, 180])
         curved_wire(bottom_hook_radius, 45);
    }

    module bottom_hook() {
        curved_wire(bottom_hook_radius, 180);
        
        translate([-bottom_hook_radius, 0, 0]) {
            straight_wire(l2*2/3);
            translate([0, -l2*2/3, 0]) wire_cap();
        }
        
        translate([bottom_hook_radius, 0, 0]) straight_wire(l2);
    }

    translate([top_hook_radius, 0 , 0]) 
     rotate([0, 0, -45])
     translate([2*top_hook_radius, -(top_hook_radius+center_length), wire_radius]) {
        translate([-top_hook_radius, center_length + sin(45)*bottom_hook_radius, 0])
         top_hook();

        translate([bottom_hook_radius - cos(45)*bottom_hook_radius, 0, 0])
         rotate([0, 0, 225])
         translate([-bottom_hook_radius, l2, 0])
         bottom_hook();
    }
}


simple_hook(wire_width, top_hook_inner_diameter, bottom_hook_inner_diameter, bottom_hook_length, wire_cap_length);



