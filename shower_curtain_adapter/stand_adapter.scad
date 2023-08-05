// This is an adapter for a shower curtain.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

LATH_THICKNESS = 24;
RAIL_INNER_RADIUS = 140;

module lath() {
  color("PaleGoldenrod") cuboid([650, LATH_THICKNESS, 48], align=V_UP + V_RIGHT);
}

module rail() {
  thickness = 13;
  height = 20;

  offset = RAIL_INNER_RADIUS + LATH_THICKNESS / 2;
  move([offset, offset, 0]) color("silver") intersection() {
    cuboid([RAIL_INNER_RADIUS + thickness, RAIL_INNER_RADIUS + thickness, height], align=V_ALLNEG);
    difference() {
      zcyl(r=RAIL_INNER_RADIUS + thickness, h=height, align=V_DOWN, $fn=FN);
      zcyl(r=RAIL_INNER_RADIUS, h=height, align=V_DOWN, $fn=FN);
    }
  }
}

module screw(length=35) {
    zcyl(d=9.0, h=3, align=V_DOWN, $fn=FN);
    zcyl(d=5.1, h=length + 3, align=V_DOWN, $fn=FN);
}


module nut(length=4) {
    zcyl(d=9.2, h=length, align=V_DOWN, $fn=6);
}


module screw_nut_combo() {
    x_screw_distance = 40;
    y_screw_distance = 100;
    //yspread(y_screw_distance) xspread(x_screw_distance) {
    place_copies([[-20, -32, 0], [20, -32, 0], [-24, 85, 0], [24, 50, 0]]) {
        zmove(-30) zflip() screw();
        zmove(7) zflip() zrot(90) nut(length=27 + 28);
    }
}


module bracket() {
    difference() {
        union() {
          for (i = [0:-90:-90]) {
            zrot(i) ymove(30) cuboid([70, 150, 48 + 10], align=V_UP, $fn=FN);
          }
        }
        for (i = [0:-90:-90]) {
          zrot(i) cuboid([24 + 0.5, 110, 48 - 0.1], align=V_UP + V_BACK, $fn=FN);
        }
        screw_nut_combo();
        xflip() zrot(90) screw_nut_combo();
    }
}


module shaft_adapter() {
  intersection() {
    move([30, 30, 0]) cuboid([150, 150, 200]);
    difference() {
      union() {
        cuboid([210, 210, 10], align=V_DOWN);
        zcyl(d=45, h=80, align=V_DOWN, $fn=FN);
        zmove(-10) prismoid(size1=[20, 40], size2=[20, 210], h=70, align=V_DOWN);
        zrot(90) zmove(-10) prismoid(size1=[20, 40], size2=[20, 210], h=70, align=V_DOWN);
      }
      move([RAIL_INNER_RADIUS + LATH_THICKNESS / 2, RAIL_INNER_RADIUS + LATH_THICKNESS / 2, 0]) zcyl(r=155, h=50, $fn=FN);
      zmove(-15) zcyl(d=35.2, h=70, align=V_DOWN, $fn=FN);
      screw_nut_combo();
      xflip() zrot(90) screw_nut_combo();
}
}
}


module one_point_two_piece_stand_lath_adapter() {
    color("red") shaft_adapter();
    color("blue") bracket();
}


//one_point_two_piece_stand_lath_adapter();
//lath(); zrot(90) lath();
//rail();
shaft_adapter();

//bracket();
