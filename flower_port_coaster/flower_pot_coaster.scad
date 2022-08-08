// This is a coaster for a flower pot.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

BOTTOM_INNER_DIAMETER = 165;
TOP_INNER_DIAMETER = 170;
BOTTOM_THICKNESS = 3;
EDGE_THICKNESS = 3;
EDGE_HEIGHT = 10;


module coaster() {
    difference() {
        cyl(d1=BOTTOM_INNER_DIAMETER + 2 * EDGE_THICKNESS, d2=TOP_INNER_DIAMETER + 2 * EDGE_THICKNESS, h=BOTTOM_THICKNESS + EDGE_HEIGHT, $fn=FN);
        zmove(BOTTOM_THICKNESS) cyl(d1=BOTTOM_INNER_DIAMETER, d2=TOP_INNER_DIAMETER, h=EDGE_HEIGHT, $fn=FN);
    }

}

coaster();
