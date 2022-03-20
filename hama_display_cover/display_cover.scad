// This is a covert for the HAMA internet radio display.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

bolt_diameter = 1.4 + 0.5;

module bolt_hole() {
    translate([0, -2, 6]) xcyl(d=bolt_diameter, h=80, $fn=FN);
}


module rear_lid() {
    color("blue") {
        zmove(-8) cuboid([90, 2, 50], align=V_DOWN + V_FRONT, fillet=4, edges=EDGES_Y_ALL, $fn=FN);
        difference() {
            xspread(spacing=40) {
                zmove(-8) cuboid([10 - 0.1, 2, 8 + 6], align=V_UP + V_FRONT);
                intersection() {
                    zmove(6) ymove(-2.5) cuboid([10, 5, 6]);
                    ymove(-2) zmove(6) xcyl(l=10 - 0.1, d=6, $fn=FN);
                }
            }
            bolt_hole();
        }
    }
}


module front_lid() {
    color("red") {
        zmove(-6) ymove(-2) cuboid([90 + 2 * 2, 2, 50 + 2 * 2], align=V_DOWN + V_FRONT, fillet=5, edges=EDGES_Y_ALL, $fn=FN);
        difference() {
            xspread(spacing=20) {
                zmove(-8) ymove(-2) cuboid([10 - 0.1, 2, 8 + 6], align=V_UP + V_FRONT);
                intersection() {
                    zmove(6) ymove(-1.5) cuboid([10, 5, 6]);
                    zmove(6) ymove(-2) xcyl(l=10 - 0.1, d=6, $fn=FN);
                }
            }
            bolt_hole();
        }
    }
}


module mount() {
    ymove(1.17) {
        cuboid([80, 40, 2], align=V_UP + V_BACK, fillet=5, edges=EDGES_Z_ALL, $fn=FN);
    }
    difference() {
        xspread(n=3, spacing=30) {
            ymove(1.17) xrot(-45) cuboid([10, 6.4, 2], align=V_UP + V_FRONT);
            ymove(-2) zmove(6) xcyl(l=10, d=6, $fn=FN);

            ymove(30) top_half(){sphere(r=4, $fn=FN);}//zcyl(d=5, h=4, align=V_UP, $fn=FN);
        }
        bolt_hole();
    }
}


module assembly() {
    angle = abs($t - 0.5) *  540 - 270;
    mount();
    xrot(angle, cp=[0, -2, 6]) rear_lid();
    xrot(angle, cp=[0, -2, 6]) front_lid();
}


assembly();
//mount();
//front_lid();
//rear_lid();
