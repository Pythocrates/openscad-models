// This is an adapter for extending a pole with a second one.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

LATH_THICKNESS = 24;
RAIL_INNER_RADIUS = 140;


module shaft_adapter() {
  intersection() {
    difference() {
      union() {
        zcyl(d=45, h=160, $fn=FN);
        zmove(-80) zcyl(d=70, h=3, align=V_UP,$fn=FN);
      }
      cyl(d=35.2, h=160, fillet=1, align=V_UP, $fn=FN);
      cyl(d=35.2, h=160, fillet=1, align=V_DOWN, $fn=FN);
}
}
}


shaft_adapter();
