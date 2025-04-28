// This is a spool for a simple strap to fix car load.

include <BOSL/shapes.scad>
use <BOSL/constants.scad>

FN = 180;
TOL = 0.2;

HOLE_DISTANCE = 620;
MOUNT_DISTANCE = 390;

THICKNESS = 4;
WIDTH = 20;


module design_01() {
  difference() {
    cuboid([28, 2, 4]);
    cuboid([26, 2, 2]);
  }
  xflip_copy() xmove(15) difference() {
      cuboid([2, 2, 10], align=V_LEFT);
      cuboid([1, 2, 8], align=V_LEFT);
    }
}

module design_02() {
  difference() {
    cuboid([28, 2, 4]);
    cuboid([26, 2, 2]);
  }
  xflip_copy() xmove(15) difference() {
      cuboid([4, 2, 10]);
      cuboid([2, 2, 8]);
    }
}

design_02();
