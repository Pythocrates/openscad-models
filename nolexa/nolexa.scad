// This is a simple sleeve for the FireTV remote to dampen Alexa.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

module sleeve1() {
    intersection() {
        #cuboid([50, 25, 5]);
        difference() {
            scale(1.1) remote_dummy();
            remote_dummy();
        }
    }
}

module sleeve2() {
    r1 = 23.3; cy1 = r1 - 8.67;
    r2 = 52.4; cy2 = -r2 + 8.95;
    r3 = 2;
    thickness = 1;

    difference() {
        minkowski() {
            intersection() {
                ymove(cy1) color("red") zcyl(h=1, r=r1 - r3, $fn=FN);
                ymove(cy2) color("red") zcyl(h=1, r=r2 - r3, $fn=FN);
            }
            zcyl(r=thickness + r3, h=1, $fn=FN);
        }

        minkowski() {
            intersection() {
                ymove(cy1) color("red") zcyl(h=1, r=r1 - r3, $fn=FN);
                ymove(cy2) color("red") zcyl(h=1, r=r2 - r3, $fn=FN);
            }
            zcyl(r=r3, h=1, $fn=FN);
        }
    }
}


sleeve2();
