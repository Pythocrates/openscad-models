// This is a camera housing for the Keenso HBV-1714-2 USB camera module.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;
HFN = 360;
EPSILON = 0.1; // on-side tolerance for extrusions

BOARD_WIDTH = 30;
BOARD_HEIGHT = 25;
MODULE_THICKNESS = 5;
THICKNESS = 2;
BACK_CLEARANCE = 2; // for the circuit
NOTCH_X_DISTANCE = 24;
NOTCH_RADIUS = 1.5;

module back() {
    difference() {
        cuboid([BOARD_WIDTH + 2 * THICKNESS, BOARD_HEIGHT + 2 * THICKNESS, MODULE_THICKNESS + THICKNESS], align=V_UP);
        zmove(THICKNESS) cuboid([BOARD_WIDTH + 2 * EPSILON, BOARD_HEIGHT + 2 * EPSILON, BACK_CLEARANCE], align=V_UP, chamfer=5, edges=EDGES_Z_ALL);
        zmove(THICKNESS + BACK_CLEARANCE) cuboid([BOARD_WIDTH + 2 * EPSILON, BOARD_HEIGHT + 2 * EPSILON, MODULE_THICKNESS - BACK_CLEARANCE], align=V_UP);
        // Make the corners fit nicely.
        zmove(THICKNESS + BACK_CLEARANCE) grid2d(spacing=[BOARD_WIDTH - 0.5, BOARD_HEIGHT - 0.5], cols=2, rows=2) zcyl(r=1, h=MODULE_THICKNESS - BACK_CLEARANCE, align=V_UP, $fn=FN);
        // Connector and cable; additional 5 in z direction to easily insert the module while plugged in
        move([9 - BOARD_WIDTH / 2, -BOARD_HEIGHT / 2 - THICKNESS, 0]) cuboid([8, 5 + THICKNESS, THICKNESS + BACK_CLEARANCE + 5], align=V_UP + V_RIGHT + V_BACK);
    }
    zmove(THICKNESS) grid2d(spacing=[NOTCH_X_DISTANCE, BOARD_HEIGHT], cols=2, rows=2) zcyl(r=1, h=MODULE_THICKNESS, align=V_UP, $fn=FN);
}


module front() {
    difference() {
        cuboid([BOARD_WIDTH + 2 * THICKNESS, BOARD_HEIGHT + 2 * THICKNESS, THICKNESS], align=V_UP);
        zcyl(d=15, h=THICKNESS, align=V_UP, $fn=FN);
        cuboid([13 + 2 * EPSILON, 13 + 2 * EPSILON, THICKNESS], align=V_UP);
        cuboid([22 + 2 * EPSILON, 4 + 2 * EPSILON, THICKNESS], align=V_UP);
    }
    yspread(l=BOARD_HEIGHT - 1) cuboid([NOTCH_X_DISTANCE - 2 * NOTCH_RADIUS, 1, 2], align=V_DOWN);
    xspread(l=BOARD_WIDTH - 1) cuboid([1, BOARD_HEIGHT, 2], align=V_DOWN);
}


module laptop_clamp(width) {
    difference() {
        cuboid([width, 15, 5 + 2 * 2], align=V_FRONT);
        ymove(-THICKNESS) cuboid([width, 13, 5], align=V_FRONT);
    }
}


module camera_clamp(width) {
    difference() {
        cuboid([width, 9, MODULE_THICKNESS + 2 * THICKNESS + 2 * THICKNESS], align=V_BACK);
        ymove(THICKNESS) cuboid([width, 7, MODULE_THICKNESS + 2 * THICKNESS], align=V_BACK);
        xmove(-2) zmove(-13 / 2 + 2) cuboid([12, 5, 2], align=V_BACK + V_UP + V_RIGHT);
    }
}



module full_mount(width, height) {
    laptop_clamp(width);
    cuboid([width, height, 5], align=V_BACK);
    ymove(height) camera_clamp(width);


}
//back();
//zmove(48) front();
//laptop_clamp();
full_mount(width=20, height=120);
