// Fitting coountersunk heads.

include <BOSL/shapes.scad>
use <BOSL/constants.scad>

FN = 120;

// screw = [head_diameter, head_length, screw_hole_diameter]
module screw_fitting(screw) {
    difference() {
        zcyl(d=1.5 * screw[0], l=2 + screw[1], align=V_DOWN, $fn=FN);
        zcyl(d1=screw[2], d2=screw[0], l=screw[1], align=V_DOWN, $fn=FN);
        zcyl(d=screw[2], l=2 + screw[1], align=V_DOWN, $fn=FN);

    }
}


// screw_fitting(screw=[7.0 + 1.0, 3.0 + 1.0, 3.5 + 0.1]);  // For a SPAX 3,5 x 25 - slightly too deep and wide
// screw_fitting(screw=[7.0 + 0.5, 3.0 + 0.5, 3.5 + 0.2]);  // For a SPAX 3,5 x 25 - slightly too tight around the head
screw_fitting(screw=[7.0 + 0.75, 3.0 + 0.75, 3.5 + 0.25]);  // For a SPAX 3,5 x 25
