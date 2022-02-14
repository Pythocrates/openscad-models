// This is a tiny box for a single in-ear headphone rubber.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module rubber_box_bottom() {
    difference() {
        cuboid([20, 20, 16], align=V_DOWN, fillet=2, edges=EDGES_Z_ALL, $fn=FN);
        cuboid([16, 16, 6], align=V_DOWN, fillet=2 * 16 / 20, edges=EDGES_Z_ALL, $fn=FN);
        zmove(-6) cuboid([16, 16, 8], align=V_DOWN, fillet=2 * 16 / 20, edges=EDGES_BOTTOM + EDGES_Z_ALL, $fn=FN);
    }
    translate(8.2 * [1, 1, 0]) cyl(d=2 - 0.1, h=2, align=V_UP, fillet2=0.1, $fn=FN);
    zmove(-14) cyl(d=3.4, h=13, fillet2=1.0, align=V_UP, $fn=FN);
}


module rubber_box_lid() {
    difference() {
        cuboid([20, 20, 2], align=V_UP, fillet=2, edges=EDGES_Z_ALL, $fn=FN);
        translate(8.2 * [1, 1, 0]) cyl(d=2, h=2, align=V_UP, $fn=FN);
    }
}


module radius_sample() {
    cuboid([40, 10, 2], align=V_RIGHT + V_DOWN);
    xmove(5) cyl(d=3, h=15, fillet2=0.5, align=V_UP, $fn=FN);
    xmove(15) cyl(d=3.2, h=15, fillet2=0.5, align=V_UP, $fn=FN);
    xmove(25) cyl(d=3.4, h=15, fillet2=0.5, align=V_UP, $fn=FN);
    xmove(35) cyl(d=3.6, h=15, fillet2=0.5, align=V_UP, $fn=FN);
}


rubber_box_bottom();
//rubber_box_lid();
//radius_sample();
