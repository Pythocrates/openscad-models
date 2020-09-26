// Cup-stacking adapter for cylindrical cups.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;


module stacker(outer_diameter, inner_diameter, height, thickness) {
    tube(h=height, id=outer_diameter, od=outer_diameter + thickness, align=V_CENTER, $fn=FN);
    tube(h=thickness, id=inner_diameter, od=outer_diameter + thickness, align=V_CENTER, $fn=FN);
}



stacker(outer_diameter=81.5, inner_diameter=75, height=6, thickness=2);
