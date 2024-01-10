// This is a profile cylinder dummy with markers every 5 mm.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;

TOP_DIAMETER = 17;
BOTTOM_DIAMETER = 10;
CENTER_DISTANCE = 33 - (TOP_DIAMETER + BOTTOM_DIAMETER) / 2;
SCREW_CENTER_DISTANCE = 19;
SCREW_DIAMETER = 5.2;

module profile_cylinder(front=50, back=50) {
    difference() {
        union() {
            ycyl(d=TOP_DIAMETER, h=front + back, $fn=FN);
            zmove(-CENTER_DISTANCE) ycyl(d=BOTTOM_DIAMETER, h=front + back, $fn=FN);
            cuboid([BOTTOM_DIAMETER, front + back, CENTER_DISTANCE], align=V_DOWN);
        }
        zmove(-CENTER_DISTANCE) xcyl(d=SCREW_DIAMETER, h=BOTTOM_DIAMETER, $fn=FN);

        xflip_copy()
            yflip_copy()
                yspread(sp=[5.5, -30, -TOP_DIAMETER / 2], spacing=-5, l=front - 30)
                    zrot(45)
                        cuboid([1, 1, CENTER_DISTANCE], align=V_DOWN);

    }
}

profile_cylinder();
