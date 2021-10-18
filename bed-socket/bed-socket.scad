socket_height=50;
hook_height=30;
socket_width=17.5;
socket_lenght=4.5;
top_lenght=28.5;
mass=5;

outer_width=socket_width + mass;

rotate([180,0,0]) union() {
    // hook
    translate([-top_lenght-1, 0, -hook_height/2 + mass])
     cube([mass, outer_width, hook_height], center=true);
    
    // top part
    translate([-top_lenght, -outer_width/2, 0]) 
     cube([top_lenght, outer_width, mass]);
    
    // socket
    translate([(socket_lenght+mass)/2, 0, -socket_height/2 + mass]) difference(){
      cube([socket_lenght+mass, outer_width, socket_height], center=true);
      
      translate([0,0,mass/2])
       cube([socket_lenght, socket_width, socket_height], center=true);
      
      translate([mass/4,0,0])
       cube([socket_lenght+mass/2, socket_lenght+mass/2, socket_height], center=true);
    }
}