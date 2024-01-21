// These are rolling shelves fitting under a roof slope.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;

//MATERIAL = "default";
MATERIAL = "IVAR";

full_back_height = 870;
roll_height = 70;

baseboard_thickness = 10;
baseboard_height = 70;

left_shelf_depth = MATERIAL == "default" ? 400 : 500;

module left_shelf_body() {
    outer_board_thickness = (MATERIAL == "default") ? 18 : 44;
    inner_board_thickness = (MATERIAL == "default") ? 12 : 18;
    shelf_depth = left_shelf_depth;
    shelf_width = 1000;
    shelf_back_height = full_back_height - roll_height;
    shelf_front_height = full_back_height + shelf_width - outer_board_thickness - roll_height;
    inner_width = shelf_width - 2 * outer_board_thickness;

    // bottom board
    move([shelf_width, -shelf_depth, outer_board_thickness] / 2)
        outer_board(length=shelf_width, depth=shelf_depth);
    // short vertical board
    move([outer_board_thickness, -shelf_depth, shelf_back_height + (2 - sqrt(2)) * outer_board_thickness] / 2)
        yrot(-90)
            outer_board(length=shelf_back_height - sqrt(2) * outer_board_thickness, depth=shelf_depth, right_miter=-45);
    // long vertical board
    move([2 * shelf_width - outer_board_thickness, -shelf_depth, shelf_front_height + outer_board_thickness * (2 - sqrt(2))] / 2)
        yrot(-90)
            outer_board(length=shelf_front_height - outer_board_thickness * sqrt(2), depth=shelf_depth, right_miter=-45);
    // inner vertical support board
    move([shelf_width, -shelf_depth, (shelf_back_height + shelf_front_height - 2 * sqrt(2) * outer_board_thickness) / 2 + outer_board_thickness * 2] / 2)
        yrot(-90)
            outer_board(length=(shelf_back_height + shelf_front_height - 2 * sqrt(2) * outer_board_thickness) / 2, depth=shelf_depth, right_miter=-45);

    // top board
    top_board_length = shelf_width * sqrt(2) + outer_board_thickness;
    echo("top board: ", top_board_length);
    move([shelf_width, -shelf_depth, (shelf_back_height + shelf_front_height - (sqrt(2) - 1) * outer_board_thickness)] / 2)
        yrot(-45)
            outer_board(length=top_board_length, depth=shelf_depth, left_miter=45, right_miter=45);

    // inner horizontal boards
    board_length = (shelf_width - 3 * outer_board_thickness) / 2;
    move([shelf_width / 4 + outer_board_thickness / 4, -shelf_depth / 2, 0])
    {
        place_copies(
            [
                [0, 0, 250],
                [0, 0, 500],
                [0, 0, shelf_back_height - sqrt(2) * outer_board_thickness + outer_board_thickness - inner_board_thickness / 2],
                [board_length + outer_board_thickness, 0, 250],
                [board_length + outer_board_thickness, 0, 500],
                [board_length + outer_board_thickness, 0, shelf_back_height - sqrt(2) * outer_board_thickness + outer_board_thickness - inner_board_thickness / 2],
                [board_length + outer_board_thickness, 0, shelf_back_height - sqrt(2) * outer_board_thickness + outer_board_thickness - inner_board_thickness / 2 + 300]
            ]
        ) {
            color("red") inner_board(length=board_length, depth=shelf_depth);

        }
    }

}


module left_shelf() {
    move([0, 0, roll_height]) left_shelf_body();
}

module outer_board(length, depth, left_miter=0, right_miter=0, center=false) {
    if (MATERIAL == "default") {
        plain_board(length=length, depth=depth, thickness=18, left_miter=left_miter, right_miter=right_miter);
    } else if (MATERIAL == "IVAR") {
        ivar_profile(length=length, depth=depth, left_miter=left_miter, right_miter=right_miter);
    }
}

module inner_board(length, depth, left_miter=0, right_miter=0, center=false) {
    if (MATERIAL == "default") {
        plain_board(length=length, depth=depth, thickness=12, left_miter=left_miter, right_miter=right_miter);
    } else if (MATERIAL == "IVAR") {
        plain_board(length=length, depth=depth, thickness=18, left_miter=left_miter, right_miter=right_miter);
    }
}

module plain_board(length, depth, thickness, left_miter=0, right_miter=0) {
    difference() {
        cuboid([length, depth, thickness]);
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
    /*xmove(-2260 / 2) union()*/ {
        /*xmove((2260 - length) / 2)*/ {
            yspread(n=2, l=depth - 32)
                cuboid([2260, 32, 44], align=V_CENTER);
            for (x = [72, 680, 1192, 1734, 2214]) {
                xmove(x - 2260 / 2) cuboid([42, depth - 2 * 32, 10], align=V_RIGHT);
            }
        }
    }
}


module ivar_profile(length, depth, left_miter=0, right_miter=0) {
    thickness = 44;
    difference() {
        intersection() {
            cuboid([length, depth, 44]);
            xmove((2260 - length) / 2) if (left_miter == 0) {
                xflip() ivar_profile_raw(length=length, depth=depth);
            } else {
                ivar_profile_raw(length=length, depth=depth);

            }
        }
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


module wall() {
    color("white") cuboid([1600, 10, 870 + 1600], center=false);
    color("red") cuboid([1600, 10, 70], align=V_UP + V_RIGHT + V_FRONT);
    color("white") zmove(870) prismoid(size1=[1600, 0], size2=[1600, 1600], shift=[0, -800], h=1600, align=V_UP + V_RIGHT);
}

//%wall();
xmove(left_shelf_depth) zrot(-90) left_shelf();
//outer_board(length=100, depth=500, left_miter=45, right_miter=-45);
