// This a lid for yoghurt coming without a solid lid.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

module holder() {
    difference() {
        cuboid([19, 17, 50], align=V_UP);
        cuboid([16, 14, 46], align=V_UP);
        xmove(3) cuboid([2, 5, 50], align=V_UP);
        xmove(-3) cuboid([2, 5, 50], align=V_UP);
    }

}

holder();
