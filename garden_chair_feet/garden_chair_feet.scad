// Wall mount for satellite speaker.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;

module foot() {
    cuboid([30, 18.5, 4], fillet=1, edges=EDGES_Z_ALL, align=V_DOWN, $fn=FN);

    intersection() {
        cuboid([30, 18.5, 10], fillet=1, align=V_DOWN, $fn=FN);
        zmove(-4) scale([1, 1, 0.43]) xcyl(h=30, d=18.5, $fn=FN);
        zmove(-4) scale([1, 1, 6 / 15]) ycyl(h=30, d=30, $fn=FN);
    }
    xspread(n=3, spacing=10) rounded_prismoid(h=10, r=1, size1=[8, 18.5 - 1.5 * 2], size2=[7, 18.5 - 1.5 * 2 - 1], $fn=FN);



    //zcyl(d=1, h=8.3, align=V_DOWN);
}


foot();
