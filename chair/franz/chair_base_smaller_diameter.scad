// A chair base with a slightly reduced diameter.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

import("Base.stl");
zmove(1.6) difference() {
    zcyl(d=8.6, h=5.5, align=V_TOP, $fn=FN);
    zcyl(d=8.5, h=5.5, align=V_TOP, $fn=FN);
}

