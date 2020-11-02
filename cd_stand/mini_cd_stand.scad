// This a vertical multi CD display.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

JEWEL_CASE_SIZE = [142, 10, 125];
BACK_PLATE_SIZE = [100, 2, 20];
BASE_PLATE_MARGIN = [0, 0];

function hadamard(a, b) = [a.x * b.x, a.y * b.y, a.z * b.z];

module jewel_case_dummy(align=V_CENTER, tilt=0, tolerance=[0, 0, 0]) {
    size = JEWEL_CASE_SIZE + tolerance;
    color([1, 1, 1, .2]) xrot(tilt)
        translate(0.5 * hadamard(align, size))
            cuboid(size);
}


module stand() {
    difference() {
        base_shape(diameter=50);
        //#ymove(3) zmove(3) jewel_case_dummy(align=V_FRONT + V_UP, tilt=-15, tolerance=[2, 1.0, 0]);
        //#ymove(3) zmove(3) jewel_case_dummy(align=V_UP, tilt=0, tolerance=[2, 0.5, 0]);
        #ymove(0) zmove(1) yrot(-atan(JEWEL_CASE_SIZE.x / JEWEL_CASE_SIZE.z)) jewel_case_dummy(align=V_UP + V_RIGHT, tilt=0, tolerance=[2, 0.5, 0]);
    }
}

module base_shape(diameter) {
    difference() {
        hull() {
            zmove(20) zcyl(d=diameter, h=1, align=V_DOWN, $fn=FN);
            zmove(20) sphere(d=10, $fn=FN);
            //zmove(10) zcyl(d=diameter - 1, h=1, align=V_DOWN, $fn=FN);
            zcyl(d=diameter, h=1, align=V_DOWN, $fn=FN);
        }
        zcyl(d=diameter, h=1, align=V_DOWN, $fn=FN);
    }
}


stand();
