// This is an angle stabilizer.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

module glider() {
    difference() {
        zmove(0.5) cuboid([58, 19, 2.5], align=V_DOWN, fillet=2, edges=EDGES_Z_ALL, $fn=FN);
        cuboid([55, 16, 1.5], align=V_UP, fillet=1, edges=EDGES_Z_ALL, $fn=FN);
        xspread(spacing=40) {
            zcyl(d=6, l=1.0, align=V_DOWN, $fn=FN);
            zcyl(d=2.3, l=2, align=V_DOWN, $fn=FN);
        }
    }
}


glider();
