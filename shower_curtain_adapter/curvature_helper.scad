// This is a simple template to measure the curvature in a certain range.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

intersection() {
  cuboid([150, 150, 5], align=V_ALLNEG);
  difference() {
    zcyl(r=150, h=5, align=V_DOWN, $fn=FN);
    for ( i = [1:1:5])
      zcyl(r=150 - (5 * i), h=i, align=V_DOWN, $fn=FN);
  }
}
