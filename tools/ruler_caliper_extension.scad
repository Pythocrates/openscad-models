// An extension to a 50 cm ruler to make a big caliper.

include <BOSL/shapes.scad>
use <BOSL/constants.scad>

FN = 60;


length = 30;

module ruler() {
    ruler_length = 40;
    cuboid([5, ruler_length, 1], align=V_RIGHT + V_BACK + V_UP);
    yrot(-4.3, cp=[0.75, 0, 0.75]) cuboid([21, ruler_length, 1.5], align=V_RIGHT + V_BACK + V_UP, fillet=0.75, edges=EDGE_TOP_LF + EDGE_BOT_LF + EDGE_TOP_RT, $fn=FN);
    xmove(5 - 0.75) yrot(-5.4, cp=[0.75, 0, 0.75]) cuboid([16.8, ruler_length, 1.5], align=V_RIGHT + V_BACK + V_UP, fillet=0.75, edges=EDGE_TOP_LF + EDGE_BOT_LF + EDGE_TOP_RT + EDGE_BOT_RT, $fn=FN);
    xmove(20) cuboid([1, ruler_length, 3], align=V_RIGHT + V_BACK + V_UP, fillet=0.5, edges=EDGE_TOP_RT + EDGE_TOP_LF, $fn=FN);
    translate([21, 0, 0.5]) cuboid([15.5, ruler_length, 1], align=V_RIGHT + V_BACK + V_UP);
    translate([21 + 13, 0, 0.5 + 1]) cuboid([1, ruler_length, 3], align=V_RIGHT + V_BACK + V_UP);
    translate([21 + 13 + 1 + 3, 0, 0]) cuboid([2, ruler_length, 3.5], align=V_RIGHT + V_BACK + V_UP);
    translate([21 + 15.5, 0, 0]) cuboid([1.5, ruler_length, 1.5], align=V_RIGHT + V_BACK + V_UP);
    //cuboid([21, ruler_length, 3], align=V_RIGHT + V_BACK + V_UP, fillet=0.75, edges=EDGE_TOP_LF + EDGE_BOT_LF + EDGE_TOP_RT, $fn=FN);
}

module top_only_with_offset(offset=5) {
    translate([0, -offset, 0]) {
        difference() {
            cuboid([40, length + offset, 4.5 + 2 * 2], align=V_RIGHT + V_UP + V_BACK);
            cuboid([2.5 + 16.5, offset, 4.5 + 2 * 2], align=V_RIGHT + V_UP + V_BACK); // display
            #translate([2.5 + 16.5, 0, 9 - 2 - 1.5]) cuboid([13, length + offset, ], align=V_RIGHT + V_DOWN + V_BACK); // wide notch
            translate([2.5 + 16.5, 0, 9 - 2 - 1.5]) cuboid([13, length + offset, 4.5 + 2 * 2], align=V_RIGHT + V_UP + V_BACK); // wide notch
        }
    }
}


//top_only_with_offset();
ruler();
