// This is a twin hook for hanging a Makita DUX60Z power head on the wall.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

HOOK_DISTANCE = 135;
HOOK_DIAMETER = 30;
HOOK_LENGTH = 25;
STRAP_WIDTH = 30;


module single_hook(diameter, length) {
    straight_depth = 25 - (50 - HOOK_DIAMETER) / 2;

    move([0, -50 / 2 - straight_depth, 50 / 2]) union() {
        cyl(l=length, d=diameter, fillet2=5, align=V_TOP, $fn=FN);
        ymove(50 / 2) intersection() {
            torus(d=50, d2=diameter, orient=ORIENT_X, $fn=FN);
            cuboid([diameter, (diameter + 50) / 2, (diameter + 50) / 2], align=V_FRONT + V_DOWN);
        }
    }
    cyl(l=straight_depth, d=diameter, align=V_FRONT, orient=ORIENT_Y, $fn=FN);

    // wide sub-hook for straps and other...
    zmove(-25) {
        cuboid([HOOK_DIAMETER, STRAP_WIDTH + 3, 3], align=V_FRONT + V_DOWN, fillet=3 / 2, edges=EDGES_Y_ALL/* + EDGES_FRONT*/, $fn=FN);
        ymove(-STRAP_WIDTH - 3) yrot(90) cyl(l=HOOK_DIAMETER + 3, r=3, fillet=3, $fn=FN);
    }
}


module twin_hook_plate(diameter, length, distance) {
    xspread(spacing=distance) single_hook(diameter=diameter, length=length);

    difference() {
        cuboid([distance + diameter * 2, 5, diameter * 2], align=V_BACK, fillet=2.5, edges=EDGES_FRONT + EDGES_Y_ALL, $fn=FN);
        grid2d(spacing=[distance + diameter + 10, diameter + 10], rows=2, cols=2, orient=ORIENT_Y) {
            //xrot(-90) screw_hole(DIN965, M4, 20, 10);
            ycyl(l=10, d=3.5, align=V_BACK, $fn=FN);
        }
    }
}


//single_hook(diameter=HOOK_DIAMETER, length=HOOK_LENGTH);
twin_hook_plate(diameter=HOOK_DIAMETER, length=HOOK_LENGTH, distance=HOOK_DISTANCE);
