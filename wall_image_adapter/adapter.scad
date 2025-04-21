// This is an adapter for existing holes and a certain image.

include <BOSL/shapes.scad>
use <BOSL/constants.scad>

FN = 180;
TOL = 0.2;

HOLE_DISTANCE = 620;
MOUNT_DISTANCE = 390;

THICKNESS = 4;
WIDTH = 20;


module left_adapter_hook() {
  MAIN_LENGTH = 0.5 * (HOLE_DISTANCE - MOUNT_DISTANCE);
  difference() {
    union() {
      xmove(-10) cuboid([MAIN_LENGTH + 2 * 10, THICKNESS, WIDTH], fillet=10, edges=EDGES_Y_ALL, align=V_BACK + V_RIGHT, $fn=FN);
      ycyl(d=40, h=5, align=V_BACK, $fn=FN);
      xmove(MAIN_LENGTH) ycyl(d=20, h=5, align=V_BACK, $fn=FN);
    }
    xrot(-90) cylinder(h=5, d1=10, d2=5, $fn=FN);
    xmove(MAIN_LENGTH - 10) cuboid([20, 1, 10], align=V_BACK + V_LEFT + V_UP);
  }
  move([MAIN_LENGTH, 0, -10]) difference() {
    cuboid([WIDTH, THICKNESS, 80], fillet=10, edges=EDGES_Y_ALL, align=V_BACK + V_UP, $fn=FN);
    zmove(80) xrot(10) zmove(-80) cuboid([WIDTH, THICKNESS, 80], fillet=10, edges=EDGES_Y_ALL, align=V_BACK + V_UP, $fn=FN);
  }
}

module right_adapter_hook() {
  xflip() left_adapter_hook();
}

//left_adapter_hook();
right_adapter_hook();
