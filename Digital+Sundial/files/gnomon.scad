include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

include <font.scad>


module extrude_pixel(direction_angles, pixel_wall_angles) {
    /* Extrude a pixel in a given direction.
       input:
       direction_angle.x: extrusion angle (from the normal to the pixel) in the x direction
       direction_angle.y: extrusion angle (from the normal to the pixel) in the y direction
       Return a (positive) solid that can then be substracted from another solid
       (Origin at the center of the base pixel)
    */
    // compute geometry
    top_pixel_location_z = 2 * gnomon_radius;     // ie: somewhere outside the gnomon
    top_pixel_size = [
        PIXEL_SIZE.x + 2 * top_pixel_location_z * tan(pixel_wall_angles.x),  // account for the non_vertical pixel walls
        PIXEL_SIZE.y + 2 * top_pixel_location_z * tan(pixel_wall_angles.y),
        EPSILON_THICKNESS
    ];
    base_pixel_size = [PIXEL_SIZE.x, PIXEL_SIZE.y, EPSILON_THICKNESS];
    pixel_direction = [direction_angles.y, direction_angles.x, 0];

    // build (positive) geometry: extrude vertically then rotate
    rotate(pixel_direction)     // rotate the whole extrusion in the chosen direction
        hull() {
            // derotate the base pixel (to keep it flat at the bottom)
            rotate(-pixel_direction) cuboid(base_pixel_size);
            zmove(top_pixel_location_z) cuboid(top_pixel_size);
        }
}


module extrude_character(character, direction_angles, pixel_wall_angles) {
    /* Extrude a (pixelated) character in a given direction:
       input:
       font_index: the index of the character in the font array
       direction_angle_x: extrusion angle (from the normal to the pixel) in the x direction
       direction_angle_y: extrusion angle (from the normal to the pixel) in the y direction
       Return a (positive) solid that can then be substracted from another solid
       (Origin at the center of the base character)
    */
    font_index = ord(character) - 48;
    char_pixel_matrix = font_char[font_index];
    i_last_row = len(char_pixel_matrix) - 1;
    i_last_col = len(char_pixel_matrix[0]) - 1;

    for (ty = [0:i_last_row]) {
        y_shift = (ty - i_last_row / 2) * PIXEL_PITCH.y;
        row = char_pixel_matrix[ty];
        ymove(y_shift) {
            for (tx = [0:i_last_col]) {
                indicator_x = MIRROR_X_CHARACTERS ? i_last_col - tx : tx;
                if (row[indicator_x] == 1) {
                    x_shift = (tx - i_last_col / 2) * PIXEL_PITCH.x;
                    xmove(x_shift) extrude_pixel(direction_angles, pixel_wall_angles);
                }
            }
        }
    }
}


module build_create_pixel_grid(pixel_depth, ID_column_OFF=[]) {
    /* Create a grid where each intersection row/column is a potential pixel
        Input:
        pixel_depth: the depth of the pixel grid
        ID_column_OFF: list all the columns that should be left OFF (eg not built), exemple: [0,1]
        Return a (positive) solid that can then be substracted from another solid
        (Origin at the center of the base character)
    */
    if (len(ID_column_OFF) < font_nb_pixel_x) {
        intersection() {
            cube([(font_nb_pixel_x + 1) * PIXEL_PITCH.x, (font_nb_pixel_y) * PIXEL_PITCH.y, pixel_depth * 3], center=true);  // the column imprint only goes from the bottom to the top row
            // Draw the columns
            for (tx = [0:font_nb_pixel_x - 1]) {
                FLAG_draw_this_column = len(search(tx, ID_column_OFF)) ==  0;
                if (FLAG_draw_this_column) {
                    translate([(tx - (font_nb_pixel_x - 1) / 2) * PIXEL_PITCH.x, 0, pixel_depth / 2])
                        //cube([PIXEL_SIZE.x,gnomon_radius*3,pixel_depth+EPSILON_THICKNESS], center=true);
                        cube([0.1, gnomon_radius * 3, pixel_depth], center=true);
                }
            }
        }
    }
    //Draw the rows
    for (ty=[0:font_nb_pixel_y - 1]) {
        translate([0, (ty - (font_nb_pixel_y - 1) / 2) * PIXEL_PITCH.y,pixel_depth / 2])
            //cube([gnomon_radius*30,1.5*PIXEL_SIZE.y,pixel_depth+EPSILON_THICKNESS], center=true);
            cube([gnomon_radius * 30, 0.1, pixel_depth], center=true);
    }
}


module build_block(gnomon_thickness, char_list, char_angles, pixel_wall_angles, align=V_CENTER) {
    /* Build a block with a set of characters */

    translate([align.x * gnomon_thickness / 2, align.y * gnomon_radius, align.z * gnomon_radius])
    difference() {
        // Build the gnomon shape
        half_of() xcyl(r=gnomon_radius, h=gnomon_thickness, $fn=FN);

        // Carve the light guides for each number
        for (ti = [0:len(char_list) - 1]) {
            extrude_character(char_list[ti], char_angles[ti], pixel_wall_angles);
        }
    }
}


module build_spacer_block(gnomon_thickness, align=V_CENTER) {
    /* Build a spacer block*/
    color("red")
    translate([align.x * gnomon_thickness / 2, align.y * gnomon_radius, align.z * gnomon_radius])
    difference() {
        // The gnomon shape
        half_of() xcyl(r=gnomon_radius, h=gnomon_thickness, $fn=FN);
        // The pixel grid
        // build_create_pixel_grid(GRID_PIXEL_DEPTH, ID_column_OFF=[0,1,2,3,4]);
    }
}


module build_round_top_block() {
    gnomon_thickness = gnomon_radius;
    /* Build a round top block*/
    color("green") {
        intersection() {
            xscale(0.3) half_of() half_of(V_LEFT) sphere(r=gnomon_radius, $fn=FN);
        }
    }
}


module Block_hours_tens(align=V_CENTER) {
    color("yellow") single_character_block(characters="1111111", pixel_wall_angle_y=6.0, align=align);
}


module Block_hours_units(align=V_CENTER) {
    single_character_block(characters="0123456", pixel_wall_angle_y=6.0, align=align);
}


module Block_minutes_tens(align=V_CENTER) {
    color("blue") single_character_block(characters="0240240240240240240", pixel_wall_angle_y=1.0, align=align);
    //char_angle_y = [-50,-45,-40, -35,-30,-25, -20,-15,-10, -5,0,5, 10,15,20, 25,30,35, 40];
}


module Block_minutes_units(align=V_CENTER) {
    color("red") single_character_block(characters="0000000", pixel_wall_angle_y=8.0, align=align);
}


module Block_semicolon(align=V_CENTER) {
    color("blue") single_character_block(characters=":::::::", pixel_wall_angle_y=8.0, align=align);
}


module single_character_block(characters, pixel_wall_angle_y, align=V_CENTER) {
    i_last_character = len(characters) - 1;
    gnomon_thickness = gnomon_radius * 45.0 / 40.0; //45;
    pixel_wall_angle_x = 0;  // [degrees] angle of the walls along the x direction
    char_angle_x = [for (i = [0:i_last_character]) 0];
    char_angle_y = [for (i = [0:i_last_character]) (90 / i_last_character) * i - 45];
    char_angles = [for (i = [0:i_last_character]) [char_angle_x[i], char_angle_y[i]]];
    difference() {
        build_block(gnomon_thickness, characters, char_angles, [pixel_wall_angle_x, pixel_wall_angle_y]);
        // build_create_pixel_grid(GRID_PIXEL_DEPTH, ID_column_OFF=[]);
    }
}
