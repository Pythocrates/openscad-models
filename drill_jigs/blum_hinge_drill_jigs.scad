// These are drill jigs for the 70.255 hinge.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;

module body() {
    cuboid([19, 200, 1225], align=V_BACK + V_RIGHT);
    xmove(19) {
        zspread(n=2, spacing=1225 + 19)
            cuboid([200, 200, 19], align=V_BACK + V_LEFT);
    }
}

module door(z_offset) {
    zmove(19 - (1245 - 1225) / 2 + z_offset)
        cuboid([19, 200, 1245], align=V_FRONT + V_RIGHT);
}

module body_holes(label, label_position) {
    ymove(-2) xcyl(d=1, h=200, $fn=FN);
    xmove(-28) zspread(n=2, spacing=32)
    {
        ycyl(d=2, h=2, align=V_FRONT, $fn=FN);
        move(label_position)
            xrot(90)
                linear_extrude(2)
                    text(label, size=8, halign="center", valign="center");
    }
}

module door_holes(label, label_position) {
        ymove(-2) xcyl(d=1, h=200, $fn=FN);
        H = 8.5; D = 0;
        FA = 14;
        TB = D + FA - 11;
        xmove(35 / 2 + TB) place_copies(
            [
                [9.5, 0, -45 / 2],
                [9.5, 0, 45 / 2],
                [0, 0, 0]
            ]
        ) {
            ycyl(d=2, h=2, align=V_FRONT, $fn=FN);
            move(label_position)
                xrot(90)
                    linear_extrude(3)
                        text(label, size=8, halign="center", valign="center");
        }
}

module body_piece() {
    FULL_HEIGHT = 88;
    color("gray") difference() {
        move([1, -2, 0]) cuboid([35, 7, FULL_HEIGHT], align=V_LEFT + V_BACK);
        cuboid([35 - 1, 7 - 2, FULL_HEIGHT], align=V_LEFT + V_BACK);
        move(0.5 * [-1, 1, 0]) zcyl(r=1, h=FULL_HEIGHT, $fn=FN);
        zmove(FULL_HEIGHT / 2 - 50) body_holes(label="K↑", label_position=[7, 0, 5]);
        zmove(-FULL_HEIGHT / 2 + 70) body_holes(label="K↓", label_position=[7, 0, -5]);
    }
}

module door_piece(z_offset) {
    FULL_HEIGHT = 108;
    color("gray") difference() {
        move([-1, -2, 0]) cuboid([35, 7, FULL_HEIGHT], align=V_RIGHT+ V_BACK);
        cuboid([35 - 1, 7 - 2, FULL_HEIGHT], align=V_RIGHT + V_BACK);
        move(0.5 * [1, 1, 0]) zcyl(r=1, h=FULL_HEIGHT, $fn=FN);
        zmove(FULL_HEIGHT / 2 - 69 - z_offset) door_holes(label="T↑", label_position=[-7, 0, -1]);
        zmove(-FULL_HEIGHT / 2 + 71 - z_offset) door_holes(label="T↓", label_position=[-7, 0, 1]);
    }

}

module combined_piece(z_offset) {
    body_piece();
    xmove(2) zmove(9 + z_offset) door_piece(z_offset=z_offset);
}

Z_OFFSET = -2; // Specifies in millimeters the difference between the top of the door and the top of the body.

//body();
//ymove(-2) door(z_offset=Z_OFFSET);

//zmove(1225 / 2 - 44) zrot(-90) combined_piece(z_offset=Z_OFFSET);
//zmove(-1225 / 2 + 44) zrot(-90) combined_piece(z_offset=Z_OFFSET);
combined_piece(z_offset=Z_OFFSET);
