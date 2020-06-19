include <BOSL/shapes.scad>
use <BOSL/constants.scad>

FN = 180;


module slider() {
    length = 23.9;
    width = 6.1;
    strength = 1.35;

    difference() {
        cuboid([length, width, strength], center=false);
        ymove(width) xrot(90) right_triangle([5.1, strength, width - 3.3], orient=ORIENT_Y);
        translate([length, 0, 0.55]) xrot(-90) prismoid(size1=[6, strength - 0.55], size2=[9, strength - 0.55], h=width, shift=[-1.5, 0], align=V_TOP + V_LEFT + V_FRONT); //, orient=ORIENT_Y);
        translate([11, width / 2, 0]) zcyl(d=2, h=strength, align=V_TOP, $fn=FN);
        xmove(4) zcyl(h=strength, d=2, align=V_TOP, $fn=FN);
    }
    translate([length - 3.9 / 2 - 0.5, width / 2, 1.7 / 2]) slot(h=1.7, l=3.9 - 2.4, d=2.4, $fn=FN);
    cuboid([3, 2, strength], align=V_TOP + V_RIGHT + V_FRONT);
    zrot(-5, cp=[1, -2, 0]) {
        slot(p1=[1, -2, strength / 2], h=strength, d=2.0, l=10, $fn=FN);
        translate([10, -3, 0]) zcyl(d=2, h=strength, align=V_TOP, $fn=FN);
    }
}


module parts() {
    slider();
}


parts();
