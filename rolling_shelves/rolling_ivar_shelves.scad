// These are rolling shelves fitting under a roof slope, based on IVAR.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;

full_back_height = 870;
roll_height = 25;

baseboard_thickness = 10;
baseboard_height = 70;

left_shelf_depth = 500;

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
    move([0, 0, roll_height]) left_shelf_body_130_cm();
}

module outer_board(length, depth, left_miter=0, right_miter=0, center=false) {
    ivar_profile(length=length, depth=depth, left_miter=left_miter, right_miter=right_miter);
}

module inner_board(length, depth, left_miter=0, right_miter=0, center=false) {
    plain_board(length=length, depth=depth, thickness=18, left_miter=left_miter, right_miter=right_miter);
}

module plain_board(length, depth, thickness, left_miter=0, right_miter=0) {
    difference() {
        cuboid([length, depth, thickness], center=false);
        if (left_miter != 0) {
            diagonal = thickness / cos(left_miter);
            if (left_miter < 0) {
                move([-length, 0, thickness] / 2)
                    yrot(left_miter)
                    cuboid([diagonal, depth, diagonal], align=V_DOWN + V_LEFT);
            } else {
                move([-length, 0, -thickness] / 2)
                    yrot(left_miter)
                    cuboid([diagonal, depth, diagonal], align=V_UP + V_LEFT);
            }
        }
        if (right_miter != 0) {
            diagonal = thickness / cos(right_miter);
            if (right_miter < 0) {
                move([length, 0, -thickness] / 2)
                    yrot(right_miter)
                    cuboid([diagonal, depth, diagonal], align=V_UP + V_RIGHT);
            } else {
                move([length, 0, thickness] / 2)
                    yrot(right_miter)
                    cuboid([diagonal, depth, diagonal], align=V_DOWN + V_RIGHT);
            }
        }
    }
}

module ivar_profile_raw(length, depth) {
    for (i = [0:1])
        ymove(i * (depth - 32)) cuboid([2260, 32, 44], center=false);
    ymove(32)
        for (x = [72, 680, 1192, 1734, 2214]) {
            xmove(x) cuboid([42, depth - 2 * 32, 10], center=false);
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
        if (left_miter != 0) {
            diagonal = thickness / cos(left_miter);
            if (left_miter < 0) {
                zmove(thickness)
                    yrot(left_miter)
                        cuboid([diagonal, depth, diagonal], align=V_LEFT + V_BACK + V_DOWN);
            } else {
                yrot(left_miter)
                    cuboid([diagonal, depth, diagonal], align=V_LEFT + V_BACK + V_UP);
            }
        }
        if (right_miter != 0) {
            diagonal = thickness / cos(right_miter);
            if (right_miter < 0) {
                move([length, 0, 0])
                    yrot(right_miter)
                    cuboid([diagonal, depth, diagonal], align=V_RIGHT + V_BACK + V_UP);
            } else {
                move([length, 0, thickness])
                    yrot(right_miter)
                    cuboid([diagonal, depth, diagonal], align=V_RIGHT + V_BACK + V_DOWN);
            }
        }
    }
}


module wall() {
    color("white") cuboid([1600, 10, 870 + 1600], center=false);
    color("red") cuboid([1600, 10, 70], align=V_UP + V_RIGHT + V_FRONT);
    color("white") zmove(870) prismoid(size1=[1600, 0], size2=[1600, 1600], shift=[0, -800], h=1600, align=V_UP + V_RIGHT);
}

//%wall();
zrot(-90) left_shelf();
//ivar_profile(1260, 500, left_miter=0, right_miter=15);
