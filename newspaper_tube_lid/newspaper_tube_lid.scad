// This is the cover for the newspaper tube.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

THICKNESS = 1;
WIDTH = 109;
HEIGHT = 92;
CUTOUT_HEIGHT = 39;
CUTOUT_WIDTH = (109 - 50) / 2;
BIG_LASH_LENGTH = 21;

EDGE_WIDTH = 1;
EDGE_DEPTH = 8;


module main_shape(edge_offset, thickness) {
    ymove(-edge_offset) cuboid([WIDTH - 2 * edge_offset, HEIGHT - CUTOUT_HEIGHT - edge_offset, thickness], align=V_FRONT + V_UP);
    ymove(-HEIGHT + CUTOUT_HEIGHT) prismoid(size1=[WIDTH - 2 * edge_offset, thickness], size2=[WIDTH - 2 * CUTOUT_WIDTH - 2 * edge_offset, thickness], h=CUTOUT_HEIGHT - edge_offset, align=V_FRONT + V_UP, orient=-ORIENT_Y);
}


module cover() {
    main_shape(edge_offset=0, thickness=THICKNESS);
    difference() {
        ymove(1) zmove(1) main_shape(edge_offset=1, thickness=8);
        ymove(1) zmove(1) main_shape(edge_offset=2, thickness=8);
        ymove(-90) cuboid([4 + 7.5, 1.5, 16], align=V_UP + V_BACK);
    }
    xspread(spacing=74 - 14.5) {
        cuboid([14.5, 2, BIG_LASH_LENGTH], align=V_UP + V_FRONT);
        translate([0, 2, 21]) prismoid(size1=[14.5, 0], size2=[14.5, 3], h=4, shift=[0, -1.5], orient=-ORIENT_Y);
    }
    ymove(-90) difference() {
        union() {
            cuboid([7.5, 1.5, 16], align=V_UP + V_BACK);
            ymove(1.5) zmove(16) cuboid([7.5, 4, 2], align=V_FRONT + V_DOWN);
        }
        zmove(8) ycyl(h=2, d=2, align=V_BACK, $fn=FN);
    }
    ymove(-10) xspread(spacing=WIDTH - EDGE_WIDTH - 1) cyl(d1=2, d2=0, h=EDGE_DEPTH, align=V_UP, $fn=FN);
    ymove(-35) xspread(spacing=WIDTH - EDGE_WIDTH - 1) cyl(d1=2, d2=0, h=EDGE_DEPTH, align=V_UP, $fn=FN);
    ymove(-HEIGHT + CUTOUT_HEIGHT / 2) xspread(spacing=75.2) cyl(d1=2, d2=0, h=EDGE_DEPTH, align=V_UP, $fn=FN);
    ymove(-90) xspread(spacing=20) cyl(d1=2, d2=0, h=EDGE_DEPTH, align=V_UP, $fn=FN);
}

cover();
