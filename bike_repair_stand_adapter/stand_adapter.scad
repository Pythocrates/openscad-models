// This is an adapter for a PA box stand to put a lath on it.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module two_point_one_piece_stand_lath_adapter() {
    difference() {
        zcyl(d=40, h=30, align=V_DOWN, $fn=FN);
        zcyl(d=35.2, h=30, align=V_DOWN, $fn=FN);
    }

    difference() {
        cuboid([60, 40, 20], fillet=5, align=V_UP, edges=EDGES_Y_BOT, $fn=FN);
        zmove(5) cuboid([48.5, 40, 20], align=V_UP, $fn=FN);
    }
}


module screw(length=20) {
    zcyl(d=9.0, h=3, align=V_DOWN, $fn=FN);
    zcyl(d=5.1, h=length + 3, align=V_DOWN, $fn=FN);
}


module nut(length=4) {
    zcyl(d=9.2, h=length, align=V_DOWN, $fn=6);
}


module screw_nut_combo() {
    yspread(80) xspread(48.5 + (70 - 48.5) / 2) {
        zmove(-10) zflip() screw();
        zmove(7) zflip() zrot(90) nut(length=27);
    }
}


module bracket() {
    difference() {
        cuboid([70, 100, 24 + 10], align=V_UP, $fn=FN);
        cuboid([48.5, 100, 24], align=V_UP, $fn=FN);
        screw_nut_combo();
    }
}


module shaft_adapter() {
    difference() {
        union() {
            zcyl(d=45, h=60, align=V_DOWN, $fn=FN);
            cuboid([70, 100, 10], align=V_DOWN, $fn=FN);
            zmove(-10) prismoid(size1=[20, 40], size2=[20, 100], h=50, align=V_DOWN);
        }
        zmove(-15) zcyl(d=35.2, h=60, align=V_DOWN, $fn=FN);
        screw_nut_combo();
    }
}


module one_point_two_piece_stand_lath_adapter() {
    color("red") shaft_adapter();
    color("blue") bracket();
}


//two_point_one_piece_stand_lath_adapter();
//one_point_two_piece_stand_lath_adapter();
//shaft_adapter();
bracket();
