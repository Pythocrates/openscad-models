// This is a simple Makita battery wall mount.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

module battery_holder_reconstruction() {
    difference() {
        cuboid([75, 25, 100], fillet=5, /*edges=EDGES_FRONT + EDGES_Y_ALL, */align=V_UP + V_FRONT, $fn=FN);
        translate([0, -10, 5])cuboid([64, 15, 95], fillet=5, edges=EDGES_Y_ALL, align=V_UP + V_FRONT, $fn=FN);

    }

}

// battery_holder_reconstruction();


module battery_holder_slight_modification() {
    difference() {
        scale(25.4) import("Makita_Battery_Mount_Final.stl");
        shift = 17.321; translate([33.0197, -3.739, 0]) prismoid(size1=[0, 38], size2=[shift * 2, 38], shift=[shift, 0], h=20, orient=ORIENT_Y);
        //ymove(-5.15) cuboid([130, 5, 80]);
    }
}
battery_holder_slight_modification();
