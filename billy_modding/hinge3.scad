// This a more sophisticated hinge accounting for the opening angle by getting longer in the middle section.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

X = 25;
Y = 25;

hole_distance = 32;
hole_edge_distance = 38;
wall_thickness = 19;

arm_height = 2 * 7.5;
arm_length = 30;
arm_width = 10;
pivot_offset = [wall_thickness + arm_width / 2, arm_length - arm_width / 2, 0];

middle_piece_length = 39 + 2 * 5;


module wall() {
    color("white") difference() {
        cuboid([wall_thickness, 200, 200], align=V_RIGHT + V_BACK);
        translate([wall_thickness, hole_edge_distance, 0]) zspread(n=4, spacing=hole_distance) xcyl(l=12, d=5, align=V_LEFT);
    }
}


module rotated_wall(angle=0) {
    zrot(angle) wall();
}


module arm() {
    spring_diameter = 6.5;
    spring_thickness = 1.5;

    zrot(90) xmove(-arm_length / 2) difference() {
        // This is the arm.
        zmove(arm_height / 2 * 0) slot(l=arm_length, h=arm_height, d=arm_width, $fn=FN);
        #translate([arm_length / 2, 0, 0]) zcyl(d=2 + 0.2, h=arm_height, $fn=FN);
        translate([-arm_length / 2, 0, 0]) zcyl(d=3 + 0.1, h=arm_height, $fn=FN);

        zmove(0.5) translate([-arm_length / 2, 0, 0]) zcyl(d=6.5, h=arm_height - 1, $fn=FN);
        zmove(0.5) xmove(-arm_length / 2) translate((spring_diameter / 2 - spring_thickness / 2) * [0, -1, 0]) cuboid([18, spring_thickness, arm_height - 1], align=V_RIGHT);
        xmove(-arm_length / 2) zrot(45) cuboid([10, arm_length, arm_height / 2], align=V_UP);
    }
}


module middle_piece() {
    height = 2 * 7.5;
    length = 39 + 2 * 5;
    spring_diameter = 6.5;
    spring_thickness = 1.4;

    difference() {
        slot(l=length, h=height, r=5, $fn=FN);

        yrot_copies(n=2) {
            translate([length / 2, 0, 0]) zcyl(d=6.5, h=height / 2 - 1, align=V_DOWN, $fn=FN);
            translate([-length / 2, 0, 0]) zcyl(d=3 + 0.1, h=height, align=V_UP, $fn=FN);

            zmove(height / 2) xmove(length / 2) translate((spring_diameter / 2 - spring_thickness / 2) * [0, 1, 0]) cuboid([18, spring_thickness, height - 1], align=V_DOWN + V_LEFT);
            xmove(length / 2) zrot(45) cuboid([10, length, height / 2], align=V_UP);
        }
    }
}


module adapter_plate() {
    hole_diameter = 5;

    color("blue") {
        difference() {
            cuboid([10, hole_distance + 2 * hole_diameter, hole_edge_distance + hole_diameter], align=V_RIGHT + V_BACK);
            cuboid([10, 30 + 5, 15], align=V_RIGHT + V_BACK);
            ymove(30 - 5) xmove(10 / 2) zcyl(l=60, d=2 + 0.2, $fn=FN);
        }
        zflip_copy() zmove(7.5) ymove(30 - 5) difference() {
            cuboid([10, 10, 10], align=V_RIGHT + V_UP);
            xmove(10 / 2) zcyl(l=60, d=2 + 0.2, $fn=FN);
        }
        ymove(hole_edge_distance) zspread(spacing=hole_distance) cyl(h=10, d=hole_diameter - 0.2, chamfer1=0.5, orient=ORIENT_X, align=V_LEFT, $fn=FN);
    }
}

module assembly(opening_angle) {
    wall_angle = -(180 - opening_angle) / 2;
    rotated_wall(wall_angle);
    zrot(wall_angle) xmove(wall_thickness) adapter_plate();

    xflip() rotated_wall(wall_angle);
    xflip() zrot(wall_angle) xmove(wall_thickness) adapter_plate();


    dx = pivot_offset.x * cos(wall_angle) - pivot_offset.y * sin(wall_angle) - middle_piece_length / 2;
    echo(dx);
    arm_angle = asin(dx / arm_length);
    echo (arm_angle)


    // yrot_copies(n=2) translate([-wall_thickness - 5, 2 * 5, -7.5]) rotate(90) arm();
    zrot(wall_angle) translate(pivot_offset) zrot(-wall_angle - arm_angle) yrot(180) arm();
    yrot(180) zrot(wall_angle) translate(pivot_offset) zrot(-wall_angle - arm_angle) yrot(180) arm();


    //ymove(-5) middle_piece();
    middle_piece_y = pivot_offset.y * cos(wall_angle) + pivot_offset.x * sin(wall_angle) - arm_length * cos(arm_angle);
    ymove(middle_piece_y) middle_piece();
}


opening_angle = abs($t * 360 - 180);
//opening_angle = 170;


wall_angle = -(180 - opening_angle) / 2;
//zrot(-wall_angle)
    assembly(opening_angle=opening_angle);
//adapter_plate();
//arm();
