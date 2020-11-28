// Headphone hanger for Steelcase Gesture head rest.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;


module hanger() {
    difference() {
        cuboid([100 + 2 * 15, 13 + 2 * 3, 20], fillet=5, edges=EDGES_Y_ALL, align=V_BACK + V_UP, $fn=FN);
        ymove(3) cuboid([100 + 2 * 15, 13, 20], align=V_BACK + V_UP);
    }
    ymove(3) cuboid([100, 13, 20], fillet=5, edges=EDGES_Y_ALL, align=V_BACK + V_UP, $fn=FN);
    cuboid([30, 90, 20], fillet=5, edges=EDGES_Y_ALL, align=V_FRONT + V_UP, $fn=FN);
    ymove(-3.5) {
        difference() {
            ymove(-40 - 45 / 2) cuboid([60, 42, 50], fillet=5, edges=EDGES_Y_ALL, align=V_UP, $fn=FN);
            zmove(50 + 45 / 2) ymove(-40 - 45 / 2) torus(ir=100, or=100 + 45, orient=ORIENT_Y, align=V_DOWN, $fn=FN);
        }
        intersection() {
            ymove(-40 - 45 / 2) cuboid([60, 50, 50], fillet=5, edges=EDGES_Y_ALL, align=V_UP, $fn=FN);
            yspread(spacing=45) zmove(-100 - 22.5 + 72.5 - 22.5) ymove(-40 - 45 / 2) cyl(h=3, r=120, fillet=1.5, orient=ORIENT_Y, $fn=FN);
        }
    }
}

hanger();
