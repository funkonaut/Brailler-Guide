//Base parameters
base_length = 222.25; //8.75"
base_width = 30;
base_height = 10.1;
base_rad = base_width;

//Finger Slot parameters
slot_height = 82.1; //92.2-10.1
slot_width = base_width;
slot_thickness = 3.175; //3.175 1/8" material thickness

//position of middle of slots on base 
slot_distance = 94.5; //distance inbetween slots
slot_gap = 20;
slot1_x = slot_distance/2 +slot_thickness/2; //94.5 from outside of slot to slot
//slot1_x = 68-slot_thickness/2; 
slot2_x = slot1_x + slot_gap + slot_thickness; //this right?

//error and cut thru term
e = .1;

module tabs(w, rad, slot_x,slot_y,tab_width,tab_height){
    //base  width, base end curve radius, slot position from end, slot position from bottom, slot tab width
    translate([slot_x,slot_y,0])
        cube([slot_thickness,tab_width/4,tab_height],center=true); //slot material thickness by 25% of width
}

module base(w,d,z,rad){
    //slots
    difference(){
    //solid base
    union(){
        cube([w-rad,d,z],center=true);
        translate([(w-rad)/2,0,0])
            cylinder(h = z,r = rad,center=true);
        translate([-(w-rad)/2,0,0])
            cylinder(h = z,r = rad,center=true);
        }
    //slot tabs
    tabs(w, rad, slot1_x, d/4, d, base_height+e);
    tabs(w, rad, slot2_x, d/4, d, base_height+e);
    tabs(w, rad, slot1_x, -d/4, d, base_height+e);
    tabs(w, rad, slot2_x, -d/4, d, base_height+e);
    tabs(-w, -rad, -slot1_x, d/4, d, base_height+e);
    tabs(-w, -rad, -slot2_x, d/4, d, base_height+e);

    tabs(-w, -rad, -slot1_x, -d/4, d, base_height+e);
    tabs(-w, -rad, -slot2_x, -d/4, d, base_height+e);       
    }
}

module slot(w, rad, slot_x, d,slot_height){
    slot_height = slot_height-slot_width/2;
    union(){
        translate([(w-rad)/2-slot_x,0,slot_height/2])
    cube([slot_thickness,slot_width,slot_height],center=true);
    tabs(w, rad, slot_x, d/4, d,3*base_height/4);
    tabs(w, rad, slot_x, -d/4, d,3*base_height/4);
        
        translate([(w-rad)/2-slot_x,0,slot_height])
        rotate([0,90,0])
    cylinder(h=slot_thickness,r=slot_width/2,center=true);
 
        }
} 


projection(){
base(base_length,base_width,base_height,base_width/2);
    }

/*
projection()
rotate([0,90,0])
slot(base_length, base_width/2, slot1_x, base_width,slot_height);
*/