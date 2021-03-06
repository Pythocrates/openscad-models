//*************************************************************//
//   [EN]  ---   DIGITAL SUNDIAL
//   [FR]  ---   CADRAN SOLAIRE NUMERIQUE
//*************************************************************//
//
//      Author: Mojoptix
//      website: www.mojoptix.com
//      Email: julldozer@mojoptix.com
//      Date: 13 october 2015
//      License: Creative Commons CC-BY (Attribution)
//
//*************************************************************//

//
//   [EN]   The episode #001 of the video podcast Mojoptix describes this sundial in details:
//              http://www.mojoptix.com/fr/2015/10/12/ep-001-cadran-solaire-numerique
//

//
//   [FR]   L'episode #001 du podcast video mojoptix decrit ce cadran solaire en detail:
//              http://www.mojoptix.com/fr/2015/10/12/ep-001-cadran-solaire-numerique
//

//*************************************************************//

include <gnomon.scad>


// Choose what you want to print/display:
// 1: the gnomon
// 2: the central connector piece
// 3: the top part of the lid
// 4: the bottom part of the lid
// 10: display everything
PRINT_SELECTION =
//1.28;
//1;
20;

FN = 120;

IS_NORTHERN_HEMISPHERE = true;  // set to true for Northen Hemisphere, set to false for Southern Hemisphere

ADD_BOTTOM_LID_SUPPORT = true;    // Add some support structure for the lid teeth


/* ************************************************************************/
/* PARAMETERS *************************************************************/
/*************************************************************************/
// used to ensure openscad is not confused by almost identical surfaces
EPSILON_THICKNESS = 0.02; 
// set to 0 if viewing directly the characters on the blocks, set to 1 if viewing their reflection of a surface
MIRROR_X_CHARACTERS = true;

gnomon_radius = 30; // (change at your own risks !)

PIXEL_SIZE = [gnomon_radius * 8.0 / 40.0, gnomon_radius * 1.0 / 40.0];
PIXEL_PITCH = [gnomon_radius * 10.0 / 40.0, gnomon_radius * 10.0 / 40.0];

GRID_PIXEL_DEPTH = 0.1;

nn = 40.0 / gnomon_radius;


module Block_rotating_base_upper(align=V_CENTER) {
    /* Build the upper part of the rotating base */
    gnomon_thickness = 2 / 3 * gnomon_radius;
    Screw_hole_diameter = 6.5;
    Nut_width_blocking = 8.8 + 1.3;
    Nut_width_non_blocking = 11.2;
    Washer_Diameter = 11.9;
    Washer_thickness = 1.3;

    translate([align.x * gnomon_thickness / 2, align.y * gnomon_radius, align.z * gnomon_radius])
    difference() {
        // Build The gnomon shape
        half_of() xcyl(r=gnomon_radius, h=gnomon_thickness, $fn=FN);

        // The negative space for the screw, nut and washer
        zmove(Washer_Diameter / 2 + 3) ycyl(r=Screw_hole_diameter / 2, h=2 * gnomon_radius, $fn=FN);
        translate([gnomon_thickness * (0.45 - 1 / 3), 0, Washer_Diameter / 2 + 3])
            ycyl(r=Washer_Diameter / 2 + 4, h=Washer_thickness + 2, $fn=FN);
        xmove(gnomon_thickness * 7 / 40)
            cuboid([Washer_thickness + 2, Washer_Diameter + 8, Washer_Diameter / 2 + 3], align=V_TOP);
        xmove(-gnomon_thickness * 0.4)
            cuboid([gnomon_thickness * 1.2 + 1, Nut_width_blocking, Washer_Diameter / 2 + 3], align=V_TOP);
        intersection() {
            translate([gnomon_thickness * (-13/40), 0, Washer_Diameter / 2 + 3])
                cuboid([gnomon_thickness * 3 / 2, 2 * (Nut_width_non_blocking / 2 + 1), 2 * (Nut_width_non_blocking / 2 + 1)]);
            translate([gnomon_thickness * 1.2, 0, Washer_Diameter / 2 + 3 - EPSILON_THICKNESS])
                cuboid([gnomon_thickness + 1, Nut_width_blocking, gnomon_radius]);
        }
        xmove(-13 / 40 * gnomon_thickness) cuboid([gnomon_thickness + 1, Nut_width_blocking + 1, 1]);
    }
}


module Block_rotating_base_mid(align=V_CENTER) {
    /* Build the mid part of the rotating base */
    gnomon_thickness = 1.3 * gnomon_radius;
    Screw_hole_diameter = 6.5;
    Washer_Diameter = 11.9;

    // The connection to the gnomon
    if (align == "hole") translate([-gnomon_thickness / 2, 0, -gnomon_radius / 2])
    difference() {
        union() {
            // The gnomon shape
            half_of() xcyl(r=gnomon_radius, h=gnomon_thickness, align=V_LEFT, $fn=FN);
            // The connection to the base
            intersection(){
                cuboid([gnomon_thickness * 0.7, 0.8 * gnomon_radius, gnomon_radius], align=V_RIGHT + V_UP);
                xcyl(r=gnomon_radius, h=gnomon_thickness * 0.7, align=V_RIGHT, $fn=FN);
            }
        }
        // The negative space for the screw and washer
        zmove(Washer_Diameter / 2 + 3)
            xcyl(d=Screw_hole_diameter, h=2 * gnomon_thickness, $fn=FN);
        xmove(-gnomon_thickness / 2)
            cuboid([gnomon_thickness * 3 / 4, Washer_Diameter + 4, 2 * (Washer_Diameter / 2 + 3)], align=V_TOP);
        translate([-gnomon_thickness / 2, 0, Washer_Diameter + 4])
            scale([0.37, 1, 0.2]) ycyl(r=gnomon_thickness, h=Washer_Diameter + 4, $fn=FN);
        translate([gnomon_thickness / 2, 0, gnomon_radius / 2.0])
            ycyl(d=Screw_hole_diameter, h=0.8 * gnomon_radius, $fn=FN);
    }
}


module Block_jar_lid_top(align=V_CENTER) {
    gnomon_thickness = 2 * gnomon_radius;
    Screw_hole_diameter = 6.5;
    Washer_Diameter = 11.9;
    Base_Wall_thickness = 3.0;
    Base_diameter = 70;
    Base_radius = Base_diameter / 2;
    Connector_x_offset = 10 + 5;
    Connector_y_offset = 0.875 * gnomon_radius + Base_Wall_thickness;

    // The Connector
    translate([align.x * Base_diameter / 2, align.y * Base_diameter / 2, align.z * (Connector_y_offset + gnomon_radius * 0.6) / 2])
    zmove(-(Connector_y_offset + gnomon_radius * 0.6) / 2)
    difference() {
        //General shape
        hull() {
            xmove(-Connector_x_offset) 
                zmove(Connector_y_offset)
                    ycyl(d=gnomon_radius * 1.2, h=gnomon_thickness * 0.65, $fn=FN);
            zcyl(d=Base_diameter, h=Base_Wall_thickness, align=V_TOP, $fn=FN);
        }

        xspread(1.1 * Base_diameter / 3) {
            // Flat surfaces for the two bottom screws
            zmove(Base_Wall_thickness) zcyl(d=1.5 * Washer_Diameter, h=gnomon_thickness, align=V_TOP, $fn=FN);
            // Holes for the two bottom screws
            zcyl(d=Screw_hole_diameter, h=Base_Wall_thickness, align=V_TOP, $fn=FN);
        }

        xmove(-Connector_x_offset) {
            zmove(Connector_y_offset) {
                // Space to rotate the gnomon
                ycyl(r=gnomon_radius * 0.7, h=0.8 * gnomon_radius + 2 * EPSILON_THICKNESS, $fn=FN);
                // Hole for the top screw
                ycyl(d=Screw_hole_diameter, h=Base_diameter, $fn=FN);
                // Flat surface for the top screw & washer/nut
                yflip_copy(gnomon_radius * 0.73 - 2)
                    ycyl(d=1.5 * Washer_Diameter, h=Base_radius - (gnomon_radius * 0.73 - 2), align=V_BACK, $fn=FN);
            }

            zmove(Base_Wall_thickness) {
                zmove(0.315 * gnomon_radius) {
                    cuboid([Base_radius - Connector_x_offset, 0.8 * gnomon_radius, gnomon_radius], align=V_TOP + V_LEFT);
                    zscale(0.3) xcyl(r=0.4 * gnomon_radius, h=Base_radius - Connector_x_offset, align=V_LEFT, $fn=FN);
                }

                zmove(1.025 * gnomon_radius) {
                    zscale(1.5) xcyl(r=0.4 * gnomon_radius, h=Base_radius + Connector_x_offset, align=V_RIGHT, $fn=FN);
                }
            }
        }
    }
}


module Block_jar_lid_bottom(align=V_CENTER) {
    //Dimensions for a Bonne Maman jam jar
    Lid_diameter_outside = 88;
    Lid_diameter_inside = 82;
    Lid_thickness = 3.0;
    Lid_skirt_height_under_teeth = 0;
    Lid_skirt_full_height = 15 + Lid_thickness + Lid_skirt_height_under_teeth;
    Teeth_thickness = 2.0;
    Teeth_depth = 1.7;
    Teeth_length = 10.0;
    Connector_x_offset = 10;
    Base_diameter = 70;
    gnomon_thickness = 2 * gnomon_radius;
    Screw_hole_diameter = 6.5;
    Logo_font_size = 6;
    Logo_negative_depth = 2;
    Logo_positive_depth = 2;
    Logo_inside_cylinder_depth = 0;
    Support_horizontal_gap = 0.2;
    Support_vertical_gap = 0.1; // should 1 layer thickness
    Support_thickness = 1.2;
    Support_height_above = 5; // for an easier removal

    translate([align.x * Lid_diameter_outside / 2, align.y * Lid_diameter_outside / 2, align.z * 20])
    zmove(20)
    {
        //The skirt of the lid
        difference() {
            union() {
                //Outside shape for the skirt
                hull() {
                    // factor 1.035 because it has 12 faces: Lid_diameter_outside/2 is the minimum distance, instead of the maximum distance
                    zmove(-Lid_skirt_full_height + 1 / 2) zcyl(r=Lid_diameter_outside / 2 * 1.035, h=1, $fn=12);
                    zmove(-Lid_thickness - 1 / 2) zcyl(r=Lid_diameter_outside / 2, h=1, $fn=FN);
                }
                // Add the MOJOPTIX Logo (positive shape)
                for (angle=[90, -30, 210]) zrot(angle)
                    translate([0,-Lid_diameter_outside / 2 + Logo_negative_depth + 20, -Lid_skirt_full_height / 2])
                        xrot(90)
                            linear_extrude(20)
                                text("MOJOPTIX", size=Logo_font_size, halign="center", valign="center", font="Comic Sans MS:style=Bold");
            }
            //Trim the Positive shape of the MOJOPTIX Logo with a tube
            difference() {
                zcyl(r=10 * Lid_diameter_outside / 2 + Logo_positive_depth, h=1000, $fn=FN);
                zcyl(r=Lid_diameter_outside / 2 + Logo_positive_depth, h=1000, $fn=FN);
            }
            // Add the MOJOPTIX Logo (negative shape)
            for (angle=[90, -30, 210]) zrot(angle)
                translate([0,-Lid_diameter_outside/2+Logo_negative_depth,-Lid_skirt_full_height/2])
                    rotate([90,0,0])
                        linear_extrude(100)
                            text("MOJOPTIX",size=Logo_font_size,halign="center", valign="center",font="Comic Sans MS:style=Bold");
            //Trim the Negative shape of the MOJOPTIX Logo with a cylinder
            cylinder(r=Lid_diameter_outside/2-Logo_inside_cylinder_depth,h=1000,center=true, $fn=100);
            //Inside shape for the skirt
            translate([0,0,-Lid_skirt_full_height/2]) rotate([0,0,0]) cylinder(r=Lid_diameter_inside/2 ,h=2*Lid_skirt_full_height, center=true, $fn=100);
        }
        //The Teeth
        translate([0,0,-Lid_skirt_full_height+Teeth_thickness/2+Lid_skirt_height_under_teeth]) intersection(){
            difference(){
                cylinder(r=(0.5*Lid_diameter_inside+0.5*Lid_diameter_outside)/2 ,h=Teeth_thickness, center=true, $fn=100);
                cylinder(r=Lid_diameter_inside/2-Teeth_depth ,h=2*Teeth_thickness, center=true, $fn=100);
            }
            union() {
                cuboid([2*Lid_diameter_outside,Teeth_length,2*Teeth_thickness]);
                zrot(60) cube([2*Lid_diameter_outside,Teeth_length,2*Teeth_thickness], center=true);
                zrot(120) cube([2*Lid_diameter_outside,Teeth_length,2*Teeth_thickness], center=true);
            }
        }

        //The flat part of the lid
        difference(){
            translate([0,0,-Lid_thickness]) rotate_extrude(convexity = 10, $fn = 100) {
                square([Lid_diameter_outside/2-Lid_thickness,Lid_thickness], center=false);
                intersection(){
                    translate([Lid_diameter_outside/2-Lid_thickness+EPSILON_THICKNESS,0,-Lid_thickness]) scale([1,1]) circle(r=Lid_thickness);
                    square([Lid_diameter_outside/2+EPSILON_THICKNESS,Lid_thickness+EPSILON_THICKNESS], center=false);
                }
            }
            // Holes for the two screws
            translate([1.1 * Base_diameter / 6, 0, gnomon_radius / 2.0])
                rotate([0, 0, 0]) cylinder(r=Screw_hole_diameter / 2, h=2 * gnomon_thickness, center=true, $fn=FN);
            translate([-1.1 * Base_diameter / 6,0, gnomon_radius / 2.0])
                rotate([0, 0, 0]) cylinder(r=Screw_hole_diameter / 2, h=2 * gnomon_thickness, center=true, $fn=FN);
            // A single line on the 1st layer to have a custom scarring (instead of some scarring at a random place)
            translate([0, 0, 0]) cube([100, 0.1, 0.5], center=true);
        }

        // Support structure for the teeth
        if (ADD_BOTTOM_LID_SUPPORT) {
            color("red") difference(){
                translate([0, 0, -Lid_skirt_full_height / 2 - Lid_thickness / 2 - Support_vertical_gap - Support_height_above / 2])
                    rotate([0, 0, 0])
                        cylinder(r=Lid_diameter_inside/2-Teeth_depth-Support_horizontal_gap,h=Lid_skirt_full_height-Lid_thickness+Support_height_above, center=true, $fn=100);
                translate([0,0,-Lid_skirt_full_height/2-Lid_thickness]) rotate([0,0,0]) cylinder(r=Lid_diameter_inside/2-Teeth_depth-Support_horizontal_gap-Support_thickness ,h=2*Lid_skirt_full_height+2*Support_height_above, center=true, $fn=100);
                cube([2,1000,1000],center=true);
            }

        }
    }
}


/* ************************************************************************/
/* MAIN *******************************************************************/
/* ************************************************************************/

// Choose what you want to print/display:
// 1: the gnomon
if (PRINT_SELECTION == 1) Gnomon(nn);
if (PRINT_SELECTION == 1.1) Gnomon_Bottom_Connector(nn);
if (PRINT_SELECTION == 1.2) Gnomon_Digits(nn);
if (PRINT_SELECTION == 1.21) Block_hours_tens();
if (PRINT_SELECTION == 1.22) build_spacer_block(2/nn);
if (PRINT_SELECTION == 1.23) Block_hours_units();
if (PRINT_SELECTION == 1.24) build_spacer_block(10/nn);
if (PRINT_SELECTION == 1.25) Block_semicolon();
if (PRINT_SELECTION == 1.26) Block_minutes_tens();
if (PRINT_SELECTION == 1.27) build_spacer_block(10/nn);
if (PRINT_SELECTION == 1.28) Block_minutes_units();
if (PRINT_SELECTION == 1.3) Gnomon_Rounded_Top(nn);
// 2: the central connector piece
if (PRINT_SELECTION == 2) Central_Connector(nn);
// 3: the top part of the lid
if (PRINT_SELECTION == 3)
    Block_jar_lid_top();
    //translate([-14,0,0]) Jar_Lid_Top(nn);
// 4: the bottom part of the lid
if (PRINT_SELECTION == 4) Jar_Lid_Bottom(nn);
// 10: everything
if (PRINT_SELECTION == 10)
{
    xmove(9 - 110 / nn)
        zmove(-3.75 + 24 / nn)
            Gnomon(nn);

    xmove(-34.5) zmove(14.25) Central_Connector(nn);
    Jar_Lid_Top(nn);
    Jar_Lid_Bottom(nn);
}
// 20: graph-based
if (PRINT_SELECTION == 20) root_node();

module root_node() {
    jar_lid_bottom_node(align=V_DOWN);
}

module jar_lid_bottom_node(align=V_CENTER) {
    size = [88, 88, 20];
    Block_jar_lid_bottom(align=align);

    // Child nodes
    translate(0.5 * hadamard(align, size))  // account for alignments
        jar_lid_top_node(align=V_TOP);
}

module jar_lid_top_node(align=V_CENTER) {
    Base_diameter = 70;
    Base_Wall_thickness = 3;
    Connector_x_offset = 15;
    Connector_y_offset = 0.875 * gnomon_radius + Base_Wall_thickness;
    size = [Base_diameter, Base_diameter, Connector_y_offset + gnomon_radius * 0.6];
    Block_jar_lid_top(align=align);

    // Child nodes
    translate(0.5 * hadamard(align, size))  // account for alignments
        xmove(-Connector_x_offset) zmove(Connector_y_offset / 2 - gnomon_radius * 0.3)
            rotating_base_mid_node(align="hole");
}

module rotating_base_mid_node(align=V_CENTER) {
    gnomon_thickness = 1.3 * gnomon_radius;
    Block_rotating_base_mid(align=align);

    if (align == "hole") translate([-gnomon_thickness / 2, 0, -gnomon_radius / 2])
        xmove(-gnomon_thickness)
            rotating_base_upper_node(align=V_LEFT);
}

module rotating_base_upper_node(align=V_CENTER) {
    gnomon_thickness = 2 / 3 * gnomon_radius;
    size = [gnomon_thickness, gnomon_radius, gnomon_radius];
    Block_rotating_base_upper(align=align);

    // Child nodes
    translate(0.5 * hadamard(align, size))  // account for alignments
        xmove(-size.x / 2)  // desired offset from own origin
    //if (IS_NORTHERN_HEMISPHERE) {
            hours_tens_node(align=V_LEFT);
}
