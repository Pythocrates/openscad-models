// An arculee shaped beer coaster.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

module rounded_corner(xdir, ydir) {
    SKIN_WIDTH = 94;  // 753;
    SKIN_LENGTH = 100;  // 803;
    VERTICAL_EDGE_RADIUS = 3.5;  // 25;
    OFFSET_X = SKIN_WIDTH / 2 - VERTICAL_EDGE_RADIUS;
    OFFSET_Y = SKIN_LENGTH / 2 - VERTICAL_EDGE_RADIUS;
    SKIN_HEIGHT = 15;  // 120;
    TOP_FILLET_RADIUS = 1;

    translate([xdir * OFFSET_X, ydir * OFFSET_Y, 0])
        cyl(r=VERTICAL_EDGE_RADIUS, h=SKIN_HEIGHT, fillet2=TOP_FILLET_RADIUS, align=V_UP, $fn=FN);
}

module skin() {
    SKIN_WIDTH = 94;  // 753;
    SKIN_LENGTH = 100;  // 803;
    SKIN_HEIGHT = 15;  // 120;
    SKIN_WIDTH_MARGIN = 8.5;  // 67;
    SKIN_LENGTH_MARGIN = 9.0;  // 72;
    TOP_FILLET_RADIUS = 1;
    VERTICAL_EDGE_RADIUS = 3.5;  // 25;
    WALL_THICKNESS = 3.75;  // 30;

    difference() {
        union() {
            for (xdir = [-1, 1]) for (ydir =  [-1, 1]) rounded_corner(xdir, ydir);
            cuboid([SKIN_WIDTH, SKIN_LENGTH - 2 * VERTICAL_EDGE_RADIUS, SKIN_HEIGHT], align=V_UP, fillet=TOP_FILLET_RADIUS, edges=EDGE_TOP_LF + EDGE_TOP_RT, $fn=FN);
            cuboid([SKIN_WIDTH - 2 * VERTICAL_EDGE_RADIUS, SKIN_LENGTH, SKIN_HEIGHT], align=V_UP, fillet=TOP_FILLET_RADIUS, edges=EDGE_TOP_FR + EDGE_TOP_BK, $fn=FN);
        }
        zmove(10) cuboid([SKIN_WIDTH - 2 * SKIN_WIDTH_MARGIN, SKIN_LENGTH - 2 * SKIN_LENGTH_MARGIN, SKIN_HEIGHT], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
        cuboid([SKIN_WIDTH - 2 * WALL_THICKNESS, SKIN_LENGTH - 2 * WALL_THICKNESS, SKIN_HEIGHT - WALL_THICKNESS], align=V_UP);
    }
}


module body() {
    SKIN_WIDTH = 94;  // 753;
    SKIN_LENGTH = 100;  // 803;
    SKIN_HEIGHT = 15;  // 120;
    SKIN_WIDTH_MARGIN = 8.5;  // 67;
    SKIN_LENGTH_MARGIN = 9.0;  // 72;

    WALL_THICKNESS = 3.75; // 30;
    VERTICAL_EDGE_RADIUS = 3.5;  // 25;
    TOLERANCE = 0.2;  // 10;
    BODY_WIDTH = SKIN_WIDTH - 2 * WALL_THICKNESS - 2 * TOLERANCE;
    BODY_LENGTH = SKIN_LENGTH - 2 * WALL_THICKNESS - 2 * TOLERANCE;
    BODY_HEIGHT = 28;  // 227;

    color("red") zmove(BODY_HEIGHT) cuboid([SKIN_WIDTH - 2 * SKIN_WIDTH_MARGIN - 2 * TOLERANCE, SKIN_LENGTH - 2 * SKIN_LENGTH_MARGIN - 2 * TOLERANCE, WALL_THICKNESS], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);  // lid
    color("red") zmove(BODY_HEIGHT) cuboid([BODY_WIDTH, BODY_LENGTH, WALL_THICKNESS], align=V_DOWN, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);  // lid
    color("gray") zmove(BODY_HEIGHT * .5) difference() {
         cuboid([BODY_WIDTH, BODY_LENGTH, BODY_HEIGHT * .5], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
    }
    color("gray") cuboid([BODY_WIDTH - 1.5 * SKIN_WIDTH_MARGIN, BODY_LENGTH - 1.5 * SKIN_LENGTH_MARGIN, BODY_HEIGHT * .5], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
    color("gray") cuboid([BODY_WIDTH, BODY_LENGTH, WALL_THICKNESS / 3], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
}


body();
zmove(227 - (120 - 30)) skin();
