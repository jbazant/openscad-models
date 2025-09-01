include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

module plate() {
    color("blue") downcube([200, 45, 2]);
}

module single_line(line, size=7) {
    linear_extrude(1) text(
        line, 
        font="Montserrat:style=Bold", 
        halign="center", valign="center", 
        size=size
    );
}

module double_line(line1, line2, size=7) {
    ty=12;
    
    ymove(ty/2) single_line(line1, size=size);
    ymove(-ty/2) single_line(line2, size=size);
}

module tripple_line(line1, line2, line3, size=7) {
    ty=12;
    
    ymove(ty) single_line(line1, size=size);    
    single_line(line2, size=size);
    ymove(-ty) single_line(line3, size=size);
}

module plate_with_text(line1, line2="", line3="", size=7) {
    plate();
    if (line2 == "") {
        single_line(line1, size=size);  
    } else if (line3 == "") {
        double_line(line1, line2, size=size);
    } else {
        tripple_line(line1, line2, line3, size=size); 
    }
}

/* ------ ------ ------ */

xdistribute(205) {
    ydistribute(50) {
        plate_with_text(
            "Remember when I asked for your opinion?",
            "Yeah, me neither.",
            size=6
        );


        plate_with_text(
            "The beatings will continue",
            "until morale improves."
        );

        plate_with_text(
            "I don't know.",
            "I just work here."
        );

        plate_with_text(
            "I would like to apologize",
            "to anyone I have not offended yet.",
            "Please be patient, you are in a queue.",
            size=6
        ); 
        
        plate_with_text(
            "I just give enough fucks",
            "to stay employed and out of jail.",
            "No more, no less.",
            size=6
        );
        
        plate_with_text(
            "Do you believe in life after work?"
        );
    }
    
    ydistribute(50) {
        plate_with_text(
            "My people skills are fine.",
            "It's my tolerance to idiots that needs work.",
            size=6
        );
        
        plate_with_text(
            "I'm trying to cut down on my swearing.",
            "Let's see how the fuck that goes.",
            size=6
        );
        
        plate_with_text(
            "Of course I talk to myself.",
            "Sometimes I need expert advice."
        );
        
        plate_with_text(
            "Shit show supervisor"
        );
        
        plate_with_text(
            "That's above my pay grade."
        );
        
        plate_with_text(
            "See? This is why I wanted to stay home.",
            "This. All this right here.",
            size=6
        );
    }
}
/**/
