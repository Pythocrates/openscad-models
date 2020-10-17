// This is a twin hook for hanging a Makita DUX60Z power head on the wall.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

HOOK_DISTANCE = 145;
HOOK_DIAMETER = 35;


module single_hook(diameter, length) {
    cyl(l=length, d=diameter, fillet2=5, align=V_TOP, $fn=FN);
    ymove(50 / 2) intersection() {
        torus(d=50, d2=diameter, orient=ORIENT_X, $fn=FN);
        cuboid([diameter, (diameter + 50) / 2, (diameter + 50) / 2], align=V_FRONT + V_DOWN);
    }
    move([0, 50 / 2, -50 / 2]) #cyl(l=20 - (50 - 35) / 2, d=diameter, align=V_REAR, orient=ORIENT_Y, $fn=FN);
}


module twin_hook_plate(diameter, length, distance) {
    xspread(spacing=distance) single_hook(diameter=diameter, length=length);
    ymove(37.5) cuboid([distance + 20, 10, 20], align=V_BACK);
}


//single_hook(diameter=HOOK_DIAMETER, length=25);
twin_hook_plate(diameter=HOOK_DIAMETER, length=25, distance=HOOK_DISTANCE);
