// This a more sophisticated hinge accounting for the opening angle by getting longer in the middle section.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

hole_diameter = 5;
hole_distance = 32;
hole_depth = 12;
hole_edge_distance = 38;
wall_thickness = 19;

arm_height = 2 * 7.5;
arm_length = 16;  // good for three pieces -> 40 mm depth
//arm_length = 20;
arm_width = 10;
pivot_bolt_diameter = 2 + 0.2;
pivot_offset = [wall_thickness + arm_width / 2, arm_length - arm_width / 2, 0];

arm_angle = 90;  // This is for the angular arm.
arm_length_2 = (wall_thickness + arm_width / 2) / sin(arm_angle);

middle_piece_height = arm_height;
middle_piece_length = 2 * wall_thickness + arm_width;
middle_piece_width = arm_width;
connector_bolt_diameter = 3 + 0.1;

spring_diameter = 6.5;
spring_thickness = 1.4;  // or 1.5?
spring_leg_length = 18;

adapter_plate_bolt_diameter = hole_diameter - 0.2;
adapter_plate_bolt_length = hole_depth - 2;
adapter_plate_thickness = arm_width;
adapter_plate_width = hole_edge_distance + hole_diameter;
adapter_plate_height = hole_distance + 2 * hole_diameter;

cover_thickness = 2;

top_hinge_thickness = 8;


module screw() {
    zcyl(l=20, d=3.5, align=V_DOWN, $fn=FN);
    zflip() zmove(1) cylinder(h=3, d1=7, d2=3, $fn=FN);
    zcyl(h=1, d=7, align=V_DOWN, $fn=FN);
}


module wall(angle=0) {
    zrot(angle) color("white") difference() {
        cuboid([wall_thickness, 200, 200], align=V_RIGHT + V_BACK);
        translate([wall_thickness, hole_edge_distance, 0]) zspread(n=4, spacing=hole_distance) xcyl(l=hole_depth, d=5, align=V_LEFT);
    }
}


module arm() {
    extrusion_angle = 55;

    zrot(90) difference() {
        // This is the arm.
        xmove(-arm_length / 2) slot(l=arm_length, h=arm_height, d=arm_width, $fn=FN);
        zcyl(d=pivot_bolt_diameter, h=arm_height, $fn=FN);
        xmove(-arm_length) zmove(arm_height / 2) {
            zcyl(d=connector_bolt_diameter, h=arm_height, align=V_DOWN, $fn=FN);
            zcyl(d=spring_diameter, h=arm_height - 1, align=V_DOWN, $fn=FN);
            ymove(spring_thickness / 2 - spring_diameter / 2)
                cuboid([spring_leg_length, spring_thickness, arm_height - 1], align=V_DOWN + V_RIGHT);
            zrot(extrusion_angle) cuboid([arm_width, 4 * arm_width, arm_height / 2], align=V_DOWN);
        }
    }
}


module angular_arm() {
    zrot(90) difference() {
        // This is the arm.
        xmove(-arm_length / 2) slot(l=arm_length, h=arm_height, d=arm_width, $fn=FN);
        zcyl(d=pivot_bolt_diameter, h=arm_height, $fn=FN);
        xmove(-arm_length) zmove(arm_height / 2) {
            zcyl(d=connector_bolt_diameter, h=arm_height, align=V_DOWN, $fn=FN);
            zcyl(d=spring_diameter, h=arm_height - 1, align=V_DOWN, $fn=FN);
            ymove(spring_thickness / 2 - spring_diameter / 2)
                cuboid([spring_leg_length, spring_thickness, arm_height - 1], align=V_DOWN + V_RIGHT);
            zrot(45) cuboid([arm_width, arm_length, arm_height / 2], align=V_DOWN);
        }
    }

    xmove(arm_length_2 / 2) ymove(-arm_length) {
        difference() {
            slot(l=arm_length_2, h=arm_height, d=arm_width, $fn=FN);
            xmove(arm_length_2 / 2) zmove(arm_height / 2) zcyl(d=connector_bolt_diameter, h=arm_height, align=V_DOWN, $fn=FN);

        }
    }
}


module middle_piece() {
    extrusion_angle = 55;

    difference() {
        slot(l=middle_piece_length, h=middle_piece_height, d=middle_piece_width, $fn=FN);

        yrot_copies(n=2) xmove(middle_piece_length / 2) {
            zcyl(d=spring_diameter, h=middle_piece_height / 2 - 1, align=V_DOWN, $fn=FN);
            xmove(-middle_piece_length) zcyl(d=connector_bolt_diameter, h=middle_piece_height / 2, align=V_UP, $fn=FN);

            translate([0, spring_diameter / 2 - spring_thickness / 2, middle_piece_height / 2])
                cuboid([spring_leg_length, spring_thickness, middle_piece_height - 1], align=V_DOWN + V_LEFT);
            zrot(extrusion_angle) cuboid([middle_piece_width, middle_piece_length, middle_piece_height / 2], align=V_UP);
        }
    }
}


module adapter_plate() {
    extrusion_angle = 55;
    color("blue") {
        difference() {
            cuboid([adapter_plate_thickness, adapter_plate_width, adapter_plate_height], fillet=5, edges=EDGES_X_ALL, align=V_RIGHT + V_BACK, $fn=FN);
            cuboid([adapter_plate_thickness, arm_length, arm_height], align=V_RIGHT + V_BACK);
            translate(pivot_offset - [wall_thickness, 0, 0]) zcyl(l=adapter_plate_height, d=pivot_bolt_diameter, $fn=FN);
            translate(pivot_offset - [wall_thickness, 0, 0]) zrot(55) cuboid([4 * arm_width, arm_width, arm_height]);
            yspread(spacing=hole_edge_distance - pivot_offset.y / 2 -  2 * (adapter_plate_width - hole_edge_distance), n=2, sp=[adapter_plate_thickness, pivot_offset.y / 2, 0]) zspread(spacing=(adapter_plate_height + arm_height) / 2)  yrot(90) screw();
        }
        ymove(hole_edge_distance) zspread(spacing=hole_distance)
            cyl(h=adapter_plate_bolt_length, d=adapter_plate_bolt_diameter, chamfer1=0.5, orient=ORIENT_X, align=V_LEFT, $fn=FN);
    }
}


module adapter_plate_cover() {
    TOLERANCE=0.1;
    color("white") difference() {
        cuboid([arm_length + arm_width + cover_thickness + 2, adapter_plate_width + cover_thickness, adapter_plate_height + 2 * cover_thickness], fillet=7, edges=EDGES_X_ALL, align=V_RIGHT + V_BACK, $fn=FN);
        cuboid([adapter_plate_thickness, adapter_plate_width + TOLERANCE, adapter_plate_height + 2 * TOLERANCE], fillet=5, edges=EDGES_X_ALL, align=V_RIGHT + V_BACK, $fn=FN);
        //cuboid([adapter_plate_thickness + 10 - cover_thickness, adapter_plate_width, middle_piece_height + 2], align=V_RIGHT + V_BACK, $fn=FN);
        // Trying to give some more slack for screws connecting middle piece and arm.
        cuboid([arm_length + arm_width + 2, pivot_offset.y + arm_length + arm_width / 2, middle_piece_height + 18.5], align=V_RIGHT + V_BACK, $fn=FN);
    }
}


module three_piece_hinge(wall_angle) {
    dx = pivot_offset.x * cos(wall_angle) - pivot_offset.y * sin(wall_angle) - middle_piece_length / 2;
    arm_angle = asin(dx / arm_length);

    zrot(wall_angle) translate(pivot_offset) zrot(-wall_angle - arm_angle) yrot(180) arm();
    yrot(180) zrot(wall_angle) translate(pivot_offset) zrot(-wall_angle - arm_angle) yrot(180) arm();

    middle_piece_y = pivot_offset.y * cos(wall_angle) + pivot_offset.x * sin(wall_angle) - arm_length * cos(arm_angle);
    ymove(middle_piece_y) middle_piece();
}


module two_piece_hinge(wall_angle) {
    dx = pivot_offset.x * cos(wall_angle) - pivot_offset.y * sin(wall_angle);
    arm_angle_pivot = asin(dx / sqrt(arm_length ^ 2 + arm_length_2 ^ 2)) - atan2(arm_length_2, arm_length);

    zrot(wall_angle) translate(pivot_offset) zrot(-wall_angle - arm_angle_pivot) yrot(180) angular_arm();
    yrot(180) zrot(wall_angle) translate(pivot_offset) zrot(-wall_angle - arm_angle_pivot) yrot(180) angular_arm();
}


module top_hinge_body(is_left, left_to_right_height_diff, wall_angle) {
    z_offset = left_to_right_height_diff / 2 * (left_to_right_height_diff < 0 ? -1 : 1);
    zrot(is_left ? -wall_angle : wall_angle) yrot(is_left ? 180 : 0) difference() {
        union() {
            cuboid([wall_thickness, 50, top_hinge_thickness], align=V_RIGHT + V_BACK);
            zcyl(h=top_hinge_thickness, r=wall_thickness, $fn=FN);
        }
        zcyl(h=top_hinge_thickness, d=5.1, $fn=FN);
        yrot(left_to_right_height_diff < 0 ? 180 : 0) zmove(z_offset) zcyl(h=z_offset + top_hinge_thickness / 2, r=wall_thickness + 0.2, align=V_DOWN, $fn=FN);
        yspread(spacing=20) translate([wall_thickness / 2, 33, 0]) #yrot(is_left ? 180 : 0) zmove(top_hinge_thickness / 2) screw();
    }
}


module assembly(opening_angle) {
    wall_angle = -(180 - opening_angle) / 2;
    wall(wall_angle);
    zrot(wall_angle) xmove(wall_thickness) adapter_plate();
    zrot(wall_angle) xmove(wall_thickness) adapter_plate_cover();

    xflip() wall(wall_angle);
    xflip() zrot(wall_angle) xmove(wall_thickness) adapter_plate();
    xflip() zrot(wall_angle) xmove(wall_thickness) adapter_plate_cover();

    three_piece_hinge(wall_angle=wall_angle);
    //two_piece_hinge(wall_angle=wall_angle);

    zmove(100 + top_hinge_thickness / 2) top_hinge_body(is_left=true, left_to_right_height_diff=0, wall_angle=wall_angle);
    zmove(100 + top_hinge_thickness / 2) top_hinge_body(is_left=false, left_to_right_height_diff=0, wall_angle=wall_angle);
}


opening_angle = abs($t * 360 - 180);
//opening_angle = 0;
wall_angle = -(180 - opening_angle) / 2;

//xmove(-wall_thickness) zrot(-wall_angle) assembly(opening_angle=opening_angle);
//top_hinge_body(is_left=false, left_to_right_height_diff=0, wall_angle=0);
//top_hinge_body(is_left=true, left_to_right_height_diff=0, wall_angle=0);
difference() {top_hinge_body(is_left=true, left_to_right_height_diff=0, wall_angle=0); zmove(-top_hinge_thickness / 2) #zcyl(d=6.9, h=1.2, align=V_UP, $fn=FN);} // With an incision for the ring in the middle.
//adapter_plate_cover();
//two_piece_hinge(wall_angle);
//adapter_plate();
//arm();
//middle_piece();
//angular_arm();
