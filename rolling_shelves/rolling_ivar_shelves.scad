// These are rolling shelves fitting under a roof slope, based on IVAR.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;

full_back_height = 870;
roll_height = 35;

baseboard_thickness = 10;
baseboard_height = 70;

left_shelf_depth = 500;

module roll_assembly() {
    cuboid([45, 21, 1.5], align=V_DOWN);
    ymove(10.5) cuboid([45, 1.5, 8], align=V_DOWN + V_FRONT);
    ymove(-10.5) cuboid([45, 1.5, 8], align=V_DOWN + V_BACK);
    move([0, -10.5, -8]) prismoid(size1=[0, 1.5], size2=[45, 1.5], h=26, align=V_DOWN + V_BACK);
    move([0, 10.5, -8]) prismoid(size1=[0, 1.5], size2=[45, 1.5], h=26, align=V_DOWN + V_FRONT);
    zmove(-20) ycyl(d=3, h=23, $fn=FN);
    zmove(-20) ycyl(d=30, h=14, $fn=FN);

}

module left_shelf_body_90_cm() {
    outer_board_thickness = 44;
    inner_board_thickness = 18;
    shelf_depth = left_shelf_depth;
    inner_board_length = 808;
    shelf_width = inner_board_length + 2 * outer_board_thickness;
    shelf_back_height = full_back_height - roll_height;
    shelf_front_height = full_back_height + shelf_width - outer_board_thickness - roll_height;
    ground_clearance = 3;
    edge_distance = 0.5;
    back_plate_thickness = 3;
    outer_rung_thickness = 10;
    cover_board_depth = shelf_depth + back_plate_thickness; // - 2 * 32;
    cover_board_offset = -back_plate_thickness * 3 / 2; // (shelf_depth - cover_board_depth) / 2;
    cover_board_thickness = 3;

    // bottom board
    echo("bottom board length = ", shelf_width);
    outer_board(length=shelf_width, depth=shelf_depth, left_miter=0.1);

    // short vertical board
    back_vertical_board_length = shelf_back_height;
    echo("back vertical board length = ", back_vertical_board_length);
    color("green") move([outer_board_thickness, 0, outer_board_thickness])
        yrot(-90) {
            outer_board(length=back_vertical_board_length, depth=shelf_depth, right_miter=-45, left_miter=0.1);
            move([0, cover_board_offset, outer_board_thickness])
                cover_board(length=back_vertical_board_length - outer_board_thickness, depth=cover_board_depth, left_miter=0, right_miter=-45);
        }

    // long vertical board
    front_vertical_board_length = shelf_front_height;
    echo("front vertical board length = ", front_vertical_board_length);
    color("green") move([shelf_width, 0, outer_board_thickness])
        yrot(-90) {
            outer_board(length=front_vertical_board_length, depth=shelf_depth, right_miter=-45, left_miter=0.0);
            move([ground_clearance - roll_height - outer_board_thickness, cover_board_offset, -cover_board_thickness])
                cover_board(length=front_vertical_board_length + roll_height - ground_clearance + outer_board_thickness + cover_board_thickness * (1 + sqrt(2)), depth=cover_board_depth, left_miter=0, right_miter=-45);
        }

    // top board
    top_board_length = (shelf_width - 2 * outer_board_thickness) * sqrt(2) + outer_board_thickness;
    echo("top board length = ", top_board_length);
    zmove(back_vertical_board_length - (sqrt(2) - 1) * outer_board_thickness)
        xmove(outer_board_thickness)
            yrot(-45) {
                outer_board(length=top_board_length, depth=shelf_depth, left_miter=45, right_miter=45);
                move([-(sqrt(2) - 1) * (outer_board_thickness) - cover_board_thickness * sqrt(2), cover_board_offset, outer_board_thickness])
                    cover_board(length=shelf_width * sqrt(2) + (1 + sqrt(2)) * cover_board_thickness, depth=cover_board_depth, left_miter=45, right_miter=45);
            }

    // inner horizontal boards
    xmove(outer_board_thickness)
        for (z = [250, 500, shelf_back_height + (1 - sqrt(2)) * outer_board_thickness - inner_board_thickness])
            zmove(z)
                inner_board(length=inner_board_length, depth=shelf_depth);

    color("blue")
    move([shelf_width, 0, 860])
        yrot(0) move([inner_board_length / 2, -shelf_depth / 2, inner_board_thickness / 2])
            inner_board(length=inner_board_length, depth=shelf_depth);

    back_plate_size = [shelf_width - 2 * edge_distance, back_plate_thickness, shelf_front_height + outer_board_thickness + roll_height - ground_clearance - edge_distance * (1 + sqrt(2))];
    echo("back_plate_size = ", back_plate_size);
    move([edge_distance, 0, ground_clearance - roll_height])
        difference() {
                cuboid(back_plate_size, align=V_UP + V_FRONT + V_RIGHT);
                yrot(45, cp=back_plate_size) cuboid(back_plate_size, align=V_UP + V_FRONT + V_RIGHT);
        }

    xspread(l=808 + 2 * 44 - 100, n=3, sp=[100 / 2, 0, 0]) yspread(l=500 - 32, n=2, sp=[0, 32 / 2, 0]) roll_assembly();
}



module left_shelf_body_130_cm() {
    outer_board_thickness = 44;
    inner_board_thickness = 18;
    shelf_depth = left_shelf_depth;
    back_board_length = 400;
    front_board_length = 808;
    back_part_width = 1.5 * outer_board_thickness + back_board_length;
    front_part_width = 1.5 * outer_board_thickness + front_board_length;
    shelf_width = back_part_width + front_part_width;
    shelf_back_height = full_back_height - roll_height;
    shelf_front_height = full_back_height + shelf_width - outer_board_thickness - roll_height;

    // bottom board
    echo("bottom board length = ", shelf_width);
    outer_board(length=shelf_width, depth=shelf_depth);

    // short vertical board
    back_vertical_board_length = shelf_back_height - sqrt(2) * outer_board_thickness;
    echo("back vertical board length = ", back_vertical_board_length);
    move([outer_board_thickness, 0, outer_board_thickness])
        yrot(-90)
            outer_board(length=back_vertical_board_length, depth=shelf_depth, right_miter=-45);

    // long vertical board
    front_vertical_board_length = shelf_front_height - outer_board_thickness * sqrt(2);
    echo("front vertical board length = ", front_vertical_board_length);
    move([shelf_width, 0, outer_board_thickness])
        yrot(-90)
            outer_board(length=front_vertical_board_length, depth=shelf_depth, right_miter=-45, left_miter=0.1);

    // inner vertical support board
    inner_vertical_board_length = back_vertical_board_length - outer_board_thickness / 2 + back_part_width;
    echo("inner vertical board length = ", inner_vertical_board_length);
    move([back_part_width + outer_board_thickness / 2, 0, outer_board_thickness])
        yrot(-90)
            outer_board(length=inner_vertical_board_length, depth=shelf_depth, right_miter=-45);

    // top board
    top_board_length = shelf_width * sqrt(2) + outer_board_thickness;
    echo("top board length = ", top_board_length);
    zmove(back_vertical_board_length)
        yrot(-45)
            outer_board(length=top_board_length, depth=shelf_depth, left_miter=45, right_miter=45);

    // inner horizontal boards
    xmove(outer_board_thickness)
        for (z = [250, 500, shelf_back_height + (1 - sqrt(2)) * outer_board_thickness - inner_board_thickness])
            zmove(z)
                inner_board(length=back_board_length, depth=shelf_depth);
    xmove(back_part_width + outer_board_thickness / 2)
        for (z = [250, 500, shelf_back_height - sqrt(2) * outer_board_thickness + outer_board_thickness - inner_board_thickness / 2, shelf_back_height - sqrt(2) * outer_board_thickness + outer_board_thickness - inner_board_thickness / 2 + 300])
            zmove(z)
                inner_board(length=front_board_length, depth=shelf_depth);

    color("blue")
    move([shelf_width, 0, 860])
        yrot(0) move([back_board_length / 2, -shelf_depth / 2, inner_board_thickness / 2])
            inner_board(length=back_board_length, depth=shelf_depth);
}

module left_shelf() {

    //move([0, 0, roll_height]) left_shelf_body_130_cm();
    move([0, 0, roll_height]) left_shelf_body_90_cm();
}

module outer_board(length, depth, left_miter=0, right_miter=0, center=false) {
    ivar_profile(length=length, depth=depth, left_miter=left_miter, right_miter=right_miter);
}

module inner_board(length, depth, left_miter=0, right_miter=0, center=false) {
    plain_board(length=length, depth=depth, thickness=18, left_miter=left_miter, right_miter=right_miter);
}

module cover_board(length, depth, left_miter=0, right_miter=0, center=false) {
    plain_board(length=length, depth=depth, thickness=3, left_miter=left_miter, right_miter=right_miter);
}

module miters(length, depth, thickness, left_miter=0, right_miter=0) {
    for (tuple = [[-1, left_miter], [1, right_miter]]) {
        side = tuple[0];
        miter_angle = tuple[1];
        diagonal = thickness / cos(miter_angle);
        direction_sign = (miter_angle > 0) ? side : -side;
        zmove(thickness / 2)
            yrot(miter_angle, cp=[length * (1 + side), 0, direction_sign * thickness] / 2)
                zmove(direction_sign * (thickness - diagonal) / 2)
                    xmove(length * (1 + side) / 2)
                        cuboid([diagonal, depth, diagonal], align=V_RIGHT * side + V_BACK);
    }
}

module plain_board(length, depth, thickness, left_miter=0, right_miter=0) {
    difference() {
        cuboid([length, depth, thickness], center=false);
        miters(length, depth, thickness, left_miter, right_miter);
    }
}

module ivar_profile_raw(length, depth) {
    for (i = [0:1])
        ymove(i * (depth - 32)) cuboid([2260, 32, 44], center=false);
        zmove((44 - 10) / 2)
            for (x = [72, 680, 1192, 1734, 2214]) {
                xmove(x) cuboid([42, depth, 10], center=false);
    }
}


module ivar_profile(length, depth, left_miter=0, right_miter=0) {
    thickness = 44;
    full_length = 2260; // TODO: Make dependent on actual length.
    difference() {
        intersection() {
            cuboid([length, depth, 44], center=false);
            if (left_miter == 0) {
                xflip(cp=[full_length / 2, 0, 0]) ivar_profile_raw(length=length, depth=depth);
            } else {
                ivar_profile_raw(length=length, depth=depth);
            }
        }
        miters(length, depth, thickness, left_miter, right_miter);
    }
}


module wall() {
    color("white") cuboid([1600, 10, 870 + 1600], center=false);
    color("red") cuboid([1600, 10, 70], align=V_UP + V_RIGHT + V_FRONT);
    color("white") zmove(870) prismoid(size1=[1600, 0], size2=[1600, 1600], shift=[0, -800], h=1600, align=V_UP + V_RIGHT);
}

//wall();
zrot(-90)left_shelf();

/*
zrot(-90) left_shelf();
xmove(500) zrot(-90) left_shelf();
xmove(1000) zrot(-90) left_shelf();
*/

//ivar_profile(1260, 500, left_miter=10, right_miter=15);
//plain_board(1260, 500, 40, left_miter=30, right_miter=40);
