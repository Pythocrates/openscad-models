// These are drill jigs for the 70.255 hinge.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;

module body() {
    cuboid([19, 200, 1225], align=V_BACK + V_RIGHT);
    xmove(19) {
        zmove(1225 / 2) cuboid([200, 200, 19], align=V_BACK + V_LEFT + V_UP);
        zmove(-1225 / 2) cuboid([200, 200, 19], align=V_BACK + V_LEFT + V_DOWN);
    }
}

module door() {
    zmove(19 - (1245 - 1225) / 2 - 4) cuboid([19, 200, 1245], align=V_FRONT + V_RIGHT);
}

module body_holes(label, label_position) {
        ymove(-2) xcyl(d=1, h=200, $fn=FN);
        place_copies(
            [
                [-37, 1, -16],
                [-37, 1, 16]
            ]
        ) {
            ycyl(d=2, h=4, align=V_FRONT, $fn=FN);
            move(label_position + [0, 1, 0])
                xrot(90)
                    linear_extrude(4)
                        text(label, size=6, halign="center", valign="center");
        }
}

module body_piece() {
    FULL_HEIGHT = 88;
    color("gray") difference() {
        move([1, -2, 0]) cuboid([42, 7, FULL_HEIGHT], align=V_LEFT + V_BACK);
        cuboid([42 - 1, 7 - 2, FULL_HEIGHT], align=V_LEFT + V_BACK);
        move(0.5 * [-1, 1, 0]) zcyl(r=1, h=FULL_HEIGHT, $fn=FN);
        zmove(FULL_HEIGHT / 2 - 50) body_holes(label="KO", label_position=[7, 0, 5]);
        zmove(-FULL_HEIGHT / 2 + 70) body_holes(label="KU", label_position=[7, 0, -5]);
    }
}

module door_holes(label, label_position) {
        ymove(-2) xcyl(d=1, h=200, $fn=FN);
        H = 8.5; D = 0;
        FA = 14;
        TB = D + FA - 11;
        place_copies(
            [
                [(35 / 2 + 9.5 + TB), 1, -45 / 2],
                [(35 / 2 + 9.5 + TB), 1, 45 / 2],
                [(35 / 2 + TB), 1, 0]
            ]
        ) {
            ycyl(d=2, h=4, align=V_FRONT, $fn=FN);
            move(label_position + [0, 1, 0])
                xrot(90)
                    linear_extrude(4)
                        text(label, size=6, halign="center", valign="center");
        }
}

module door_piece() {
    FULL_HEIGHT = 108;
    color("gray") difference() {
        move([-1, -2, 0]) cuboid([35, 7, FULL_HEIGHT], align=V_RIGHT+ V_BACK);
        cuboid([35 - 1, 7 - 2, FULL_HEIGHT], align=V_RIGHT + V_BACK);
        move(0.5 * [1, 1, 0]) zcyl(r=1, h=FULL_HEIGHT, $fn=FN);
        zmove(FULL_HEIGHT / 2 - 65) door_holes(label="TO", label_position=[-7, 0, -1]);
        zmove(-FULL_HEIGHT / 2 + 75) door_holes(label="TU", label_position=[-7, 0, 1]);
    }

}

module combined_piece() {

}


//body();
zrot(-90) zmove(1225 / 2 + 6 - 50) body_piece();
zrot(-90) zmove(-1225 / 2 - 26 + 70) body_piece();
//ymove(-2) door();
ymove(-2) zrot(-90) zmove(1225 / 2 - 39) door_piece();
ymove(-2) zrot(-90) zmove(-1225 / 2 + 49) door_piece();
