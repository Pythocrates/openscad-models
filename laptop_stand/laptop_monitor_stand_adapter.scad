// This is an adapter between a laptop top plate and a PA monitor stand.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

use <laptop_stand.scad>

FN = 120;


module bracket() {
    //zmove(70)  #xcyl(h=200 - 10 - 5, d=30, $fn=FN);
    difference() {
        zmove(80) cuboid([195, 30, 20], fillet=10, edges=EDGES_Y_BOT, $fn=FN);
        zmove(85) cuboid([195, 30, 5], align=V_UP, $fn=FN);
        zmove(70) zcyl(d=40 + 0.5, h=5, align=V_UP);
        #xspread(spacing=25) zmove(85) {
            zcyl(d=4, h=20, align=V_DOWN, $fn=FN);
            zcyl(d=7.8, h=2.5, align=V_DOWN, $fn=FN);
        }
    }
    xflip_copy(200 / 2 - 5 - 5 / 2) {
    difference() {
        union() {
            zmove(70) {
                //hull() { zspread(spacing=50, sp=[0, 0, 0]) { xcyl(h=10, d=30, $fn=FN); } }
                zmove(50) xcyl(h=10, d=30, $fn=FN);
                zmove(50) cuboid([10, 30, 40], align=V_DOWN);
            }
        }
        zmove(120) xcyl(h=5, d=6.2, $fn=FN);
        zmove(120) xspread(spacing=2 * (5 - 0.2)) xcyl(h=5, d=65 + 2, $fn=FN);
        zmove(90 + 30) yrot(90) arc_of(n=5, r=30, sa=-20, ea=20) zcyl(h=5, d=3.2, $fn=FN);

    }
    }
}


module shaft_adapter() {
    difference() {
        zcyl(d=40, h=70, align=V_DOWN, $fn=FN);
        zmove(-15) zcyl(d=35, h=60, align=V_DOWN, $fn=FN);
        xflip_copy(offset=25 / 2) {
            zcyl(d=4.2, h=15, align=V_DOWN, $fn=FN);
            zmove(-10) {
                zcyl(d=8.1, h=3.2, align=V_UP, $fn=6);
                cuboid([7.5, 7.015, 3.2], align=V_UP + V_RIGHT);
            }
        }
    }
}



module assembly2() {
    zmove(75-10) shaft_adapter();
    bracket();
    zmove(120 + 30 / 2) top_plate(inclination=6);
    zmove(120 + 30 / 2) front_stop(inclination=6);
}

//parts();
//assembly2();
//bracket();
intersection() {
shaft_adapter();
//xmove(7) cuboid([20, 10, 16], align=V_DOWN + V_RIGHT);
}
