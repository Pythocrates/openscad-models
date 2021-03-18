// This is a small holder to hold the TAN generator in the desk drawer.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 60;


module tan_gen_holder() {
    difference() {
        cuboid([14, 10, 10], align=V_TOP);
        cuboid([11.9, 10, 9], align=V_TOP);
    }
    difference() {
        cuboid([14, 10, 10], align=V_TOP);
        // r too big: 20
        zmove(-12 + 9) ycyl(r=12, h=10, $fn=FN * 6);
    }
    xmove(13) difference() {
        cuboid([14, 10, 10 + 16.2], align=V_TOP);
        cuboid([12, 10, 9 + 16.2], align=V_TOP);
        
    }
}


tan_gen_holder();
