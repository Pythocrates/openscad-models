// This is a simple round cutter for dumplings.

include <BOSL/shapes.scad>
use <BOSL/constants.scad>

FN = 180;
TOL = 0.2;

MAIN_DIAMETER = 105;
TOP_INNER_DIAMETER = MAIN_DIAMETER - 10;
BOTTOM_INNER_DIAMETER = MAIN_DIAMETER;
TOP_OUTER_DIAMETER = MAIN_DIAMETER + 2;
BOTTOM_OUTER_DIAMETER = MAIN_DIAMETER + 2;



module ring() {
  tube(h=10, od1=BOTTOM_OUTER_DIAMETER, od2=TOP_OUTER_DIAMETER, id1=BOTTOM_INNER_DIAMETER, id2=TOP_INNER_DIAMETER, align=V_DOWN, $fn=FN);
  zmove(-10) tube(h=5, od=BOTTOM_OUTER_DIAMETER, id=BOTTOM_INNER_DIAMETER, align=V_DOWN, $fn=FN);
  difference() {
    zcyl(h=5, d=BOTTOM_OUTER_DIAMETER, align=V_DOWN, $fn=FN);
    zring(n=4, r=40) cuboid([5, 20, 5], align=V_DOWN);
  }
}

module handle(align=V_UP) {
    color("red") {
      difference() {
        zmove(18.5) {
          difference() {
            cuboid([32, 20 - TOL, 8], align=V_DOWN);
            zmove(-4 * (1 + align.z)) cuboid([20, 20, 8 / 2 + TOL], align=align);
          }
          zring(n=2) xmove(32 / 2) yrot(30) cuboid([38, 20 - TOL, 8], align=V_DOWN + V_RIGHT);
        }
        cuboid([100, 20 - TOL, 20], align=V_DOWN);
      }
      zring(n=2, r=40) cuboid([5 - TOL, 20 - TOL, 5 + 2], align=V_DOWN);
    }
}


module assembly() {
  //ring();
  //handle();
  zrot(90) handle(align=V_DOWN);
}

assembly();
