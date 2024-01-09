// This is a holder for a USB switch.
include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;

size = [112, 67, 24];

module holder(gap=0.25, thickness=2) {
    difference() {
        cuboid([size.x + 2 * (gap + thickness), size.y + 2 * (gap + thickness), size.z + gap + thickness], align=V_DOWN);
        cuboid([size.x + 2 * gap, size.y + 2 * gap, size.z + gap], align=V_DOWN);
        cuboid([size.x + 2 * gap - 10, size.y + 2 * (gap + thickness), size.z + 2 * gap], align=V_DOWN);
        cuboid([size.x + 2 * (gap + thickness) - 20, size.y + 2 * (gap + thickness) - 20, size.z + 2 * (gap + thickness)], align=V_DOWN);
        ymove(-1) zmove(-(size.z / 2 + gap)) xcyl(h=size.x + 2 * (gap + thickness), d=9, $fn=FN);
        ymove(-1) zmove(-2) cuboid([size.x + 2 * (gap + thickness / 2), 9, (size.z + gap) / 2 - 2], align=V_DOWN);
    }

    yflip_copy(size.y / 2 + gap + thickness - 4) {
        xflip_copy(size.x / 2 + gap + thickness + 4) difference() {
            union() {
                cuboid([4, 8, 10], align=V_DOWN + V_LEFT);
                zcyl(h=10, r=4, align=V_DOWN, $fn=FN);
            }
            zcyl(h=10, r=1.6, align=V_DOWN, $fn=FN);
            zcyl(h=4, r1=0, r2=4, align=V_DOWN, $fn=FN);
            zmove(-10) zcyl(h=4, r1=4, r2=0, align=V_UP, $fn=FN);
        }
    }

}

intersection() {
    holder();
    //xmove(size.x / 2 + 0.25 + 2) cuboid([7, 100, 100], align=V_LEFT);
}
