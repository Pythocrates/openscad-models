// Hook adapter for the door hooks.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;


module adapter() {
    cuboid([30, 15, 50], fillet=3, edges=EDGES_Y_BOT, align=V_FRONT + V_DOWN, $fn=FN);
    ymove(15) cuboid([30, 3, 10], fillet=2, edges=EDGES_Y_BOT, align=V_BACK + V_DOWN, $fn=FN);
    ymove(-15) cuboid([30, 15 + 15 + 3, 5], align=V_BACK + V_UP);

}

adapter();
