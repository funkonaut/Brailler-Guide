// Brailler Finger Guide Code
// Chris Correll 22_8_7 

//resolution
$fn = 45;
//error and cut thru term
e = .01;


module tabs(slot_x,slot_y,slot_width){
    //slot position from end, slot position from bottom, slot width (same size as base width), tab height (same as material thickness and error)
    tab_height = material_thickness+e;
    translate([slot_x,slot_y,0])
        cube([slot_hole,slot_width/4,tab_height],center=true); //slot material thickness by 25% of width
}

//braille guide base with slot holes
module base(){
    //end curvature
    base_rad = base_width/2;

    difference(){
        
    //solid base
        union(){
            cube([base_length-base_rad,base_width,material_thickness],center=true);
            translate([(base_length-base_rad)/2,0,0])
                cylinder(h = material_thickness,r = base_rad,center=true);
            translate([-(base_length-base_rad)/2,0,0])
                cylinder(h = material_thickness,r = base_rad,center=true);
        }
        
    //8 slot holes
    slot1_x = slot_distance/2 + slot_hole/2;  //+/- center of middle slots X
    slot2_x = slot1_x + slot_gap + slot_hole; //+/- center of outside slots
    
    tabs(slot1_x, base_width/4, base_width);
    tabs(slot2_x, base_width/4, base_width);
    tabs(slot1_x, -base_width/4, base_width);
    tabs(slot2_x, -base_width/4, base_width);
    tabs(-slot1_x, base_width/4, base_width);
    tabs(-slot2_x, base_width/4, base_width);
    tabs(-slot1_x, -base_width/4, base_width);
    tabs(-slot2_x, -base_width/4, base_width);       
    }
}

module slot(){
    union(){
        translate([0,0,slot_height/2])
            cube([slot_hole,slot_width,slot_height],center=true);
        
        translate([0,0,-(material_thickness+e)/2])
            tabs(0,slot_width/4,slot_width);
        translate([0,0,-(material_thickness+e)/2])
            tabs(0,-slot_width/4,slot_width);
        
        translate([0,0,slot_height])
            rotate([0,90,0])
            cylinder(h=slot_hole,r=slot_width/2,center=true);
        }
} 



//Material Parameters
material_thickness = 3.2;

//Base parameters
base_length = 222.25; //8.75"
base_width = 30;
base_height = 10.1;


//Finger Slot parameters
slot_height = 82.1; 
slot_width = base_width;
slot_hole = material_thickness * .95;// go around 5% less for tight fit?

//Position of slots on base 
slot_distance = 94.5; //distance inbetween middle slots (outsides)
slot_gap = 21; //distance between slots (insides)


//2D render
projection(){
    base();
    
    translate([0, 2*base_height+slot_width/2, 0])
    rotate([0,90,0])
    slot();
    
    translate([-base_length/2, 2*base_height+slot_width/2, 0])
    rotate([0,90,0])
    slot();
    
    translate([0, 4*base_height+slot_width, 0])
    rotate([0,90,0])
    slot();
    
    translate([-base_length/2, 4*base_height+slot_width, 0])
    rotate([0,90,0])
    slot();
}
*/
