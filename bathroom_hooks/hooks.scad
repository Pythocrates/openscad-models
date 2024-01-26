// Hooks for the bathroom.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;


module hook1() {
    inner_diameter = 14.7;
    outer_diameter = 20;
    straight_length = 10;

    tube(id=inner_diameter, od=outer_diameter, h=5, orient=ORIENT_X, align=false, $fn=FN);
    ymove(inner_diameter / 2) cuboid([5, (outer_diameter - inner_diameter) / 2, outer_diameter / 2 + straight_length], align=V_DOWN + V_BACK);
    zmove(-20) {
        difference() {
            tube(id=inner_diameter, od=outer_diameter, h=5, orient=ORIENT_X, align=false, $fn=FN);
            cuboid([5, outer_diameter, outer_diameter / 2], align=V_UP);
        }
        ymove(-(outer_diameter + inner_diameter) / 4) xcyl(h=5, d=(outer_diameter - inner_diameter) / 2, $fn=FN);
    }
}

hook1();
