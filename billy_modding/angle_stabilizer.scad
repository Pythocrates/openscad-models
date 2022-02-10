// This is an angle stabilizer.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

FRONT_THICKNESS = 8;
SIDE_THICKNESS = 6;
TOLERANCE = 0.05;
RADIAL_TOLERANCE = 0.05;
HOLE_DISTANCE = 32;
HOLE_RADIUS = 5 / 2;


module hole_grid() {
    #zspread(n=5, spacing=HOLE_DISTANCE) xcyl(r=HOLE_RADIUS + RADIAL_TOLERANCE, l=10, $fn=FN);
}


module screw() {
    zcyl(l=20, d=3.5, align=V_DOWN, $fn=FN);
    zflip() zmove(1) cylinder(h=3, d1=7, d2=3, $fn=FN);
    zcyl(h=1, d=7, align=V_DOWN, $fn=FN);
}


module board() {
    translate(TOLERANCE * [0, -0, 0]) cuboid([100, 100, 19.5 + 0 * TOLERANCE], align=V_DOWN + V_RIGHT + V_BACK);
}


module stabilizer() {
    difference() {
        union() {
            ymove(-FRONT_THICKNESS) {
                // Select from the next two lines either a full stabilizer or only the lower part.
                zmove(-20 / 2) cuboid([SIDE_THICKNESS, 30, 60], align=V_RIGHT + V_BACK, fillet=2.5, edges=EDGES_RIGHT, $fn=FN);
                //zmove(-20 / 2 - 10) cuboid([SIDE_THICKNESS, 30, 40], align=V_RIGHT + V_BACK, fillet=2.5, edges=EDGES_RIGHT, $fn=FN);
                cuboid([50, FRONT_THICKNESS, 19.5 + 2], align=V_RIGHT + V_BACK + V_DOWN, fillet=4, edges=EDGES_FRONT, $fn=FN);
            }
            zmove(-19.5) cuboid([50, 22, 2], align=V_RIGHT + V_BACK + V_DOWN, fillet=1, edges=EDGE_BK_RT, $fn=FN);
        }
        board();
        //translate([0, 35, -20 + HOLE_RADIUS]) hole_grid();
        translate([SIDE_THICKNESS, 10, -10 + 20]) yrot(90) screw();
        translate([SIDE_THICKNESS, 10, -10 - 20]) yrot(90) screw();
        translate([15, -FRONT_THICKNESS, -10]) xrot(90) screw();
        translate([40, -FRONT_THICKNESS, -10]) xrot(90) screw();
    }
}


//xflip() stabilizer();
stabilizer();
