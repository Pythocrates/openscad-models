// This is a fixed base for a Billy not meant to be moved around but needing a slightly higher stand.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

module base_4mm() {
    difference() {
        cuboid([100, 19, 4.0], align=V_DOWN, fillet=2, edges=EDGES_Z_ALL, $fn=FN);
        xspread(n=3, spacing=45) {
            zcyl(d=6, l=2.0, align=V_DOWN, $fn=FN);
            zcyl(d=2.3, l=4, align=V_DOWN, $fn=FN);
        }
    }
}


module base_2mm() {
    difference() {
        cuboid([100, 19, 2.0], align=V_DOWN, fillet=2, edges=EDGES_Z_ALL, $fn=FN);
        xspread(n=3, spacing=45) {
            zcyl(d=6, l=1.0, align=V_DOWN, $fn=FN);
            zcyl(d=2.3, l=2, align=V_DOWN, $fn=FN);
        }
        xspread(spacing=45) {cuboid([35, 15, 2], align=V_DOWN);}
    }
    xrot(90) zrot(90) yspread(spacing=45) {sparse_strut(h=19, l=35, thick=2, strut=2, maxang=45, align=V_LEFT);}
}


base_2mm();
