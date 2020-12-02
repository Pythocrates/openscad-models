// This is a simple sleeve for the FireTV remote to dampen Alexa.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module sleeve(r_top, r_bottom, r_side, d_vertical, thickness, height=1) {
    difference() {
        shape(r_top, r_bottom, r_side, d_vertical, thickness=thickness, height=height);
        shape(r_top, r_bottom, r_side, d_vertical, height=height);
    }
}


module shape(r_top, r_bottom, r_side, d_vertical, thickness=0, height=1) {
    minkowski() {
        intersection() {
            ymove(r_bottom - d_vertical) zcyl(h=height, r=r_bottom - r_side, $fn=FN);
            ymove(-r_top) zcyl(h=height, r=r_top - r_side, $fn=FN);
        }
        zcyl(r=r_side + thickness, h=height, $fn=FN);
    }
}


sleeve(r_top=52.4, r_bottom=23.3, r_side=2, d_vertical=8.95 + 8.67, thickness=1, height=3);
