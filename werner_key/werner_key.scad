// This is a simple key for some watering device for Werner.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

DIAMETER = 4.7;
BITTING_HEIGHT = 5;
BITTING_WIDTH = 7.6;
BITTING_THICKNESS = 1.5;
BITTING_OFFSET = 0.5;


module key_end(length=5 * BITTING_HEIGHT) {
    zcyl(l=length, d=DIAMETER, align=V_UP, $fn=FN);
    zmove(length - BITTING_OFFSET) cuboid([BITTING_WIDTH, BITTING_THICKNESS, BITTING_HEIGHT], align=V_DOWN);
}


module handle_key() {
    zmove(-5) key_end();
    zrot(22.5) sphere(d=BITTING_WIDTH * 1.083 * 1.083, $fn=8);
    //zrot_copies(rots=[0, 90]) cuboid([BITTING_WIDTH, BITTING_THICKNESS, 100], fillet=BITTING_WIDTH / 2, edges=EDGES_Y_TOP, align=V_DOWN);
    zrot(22.5) zcyl(l=100, d=BITTING_WIDTH * 1.083, align=V_DOWN, $fn=8);
    zmove(-100) yrot(22.5) ycyl(l=100, d=BITTING_WIDTH * 1.083, $fn=8);
}


handle_key();
