// This is a holder for the S TAN generator.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;


module holder(gap=1, thickness=2) {
    difference() {
        union() {
            move([0, 81 + gap, 0]) {
                cuboid([65 + 2 * gap + 2 * thickness, thickness, 12 + 1 * gap], align=V_BACK + V_UP);
                prismoid(size1=[65 + 2 * (gap + thickness), 5], size2=[65 + 2 * (gap + thickness), 0], h=1.8, shift=[0, 2.5], align=V_FRONT + V_UP);
            }

            move([-(65 / 2 + gap), 0, 0]) cuboid([thickness, 81 + 1 * gap + 1 * thickness, 12 + 1 * gap], align=V_LEFT + V_BACK + V_UP);
            move([65 / 2 + gap, 0, 0]) cuboid([thickness, 81 + 1 * gap + 1 * thickness, 12 + 1 * gap], align=V_RIGHT + V_BACK + V_UP);

            move([0, (81 + gap + thickness) / 2])
                grid2d(spacing=[65 + 2 * (gap + thickness + 2), 81 - 5], cols=2, rows=2)
                    zcyl(h=12 + gap, r=4, align=V_UP, $fn=FN);
            move([0, (81 + gap + thickness) / 2])
                grid2d(spacing=[65 + 2 * (gap + thickness + 1), 81 - 5], cols=2, rows=2)
                    cuboid([2, 8, 12 + gap], align=V_UP, $fn=FN);

        }
        move([0, (81 + gap + thickness ) / 2])
            grid2d(spacing=[65 + 2 * (gap + thickness + 2), 81 - 5], cols=2, rows=2) {
                zcyl(h=12 + gap, r=1.5, align=V_UP, $fn=FN);
                zcyl(h=4, r1=4, r2=0, align=V_UP, $fn=FN);

            }
    }
    xflip_copy()
        move([-(65 / 2 + gap), 0, 0])
            prismoid(size1=[5, 81 + gap + thickness], size2=[0, 81 + gap + thickness], h=1.8, shift=[-2.5, 0], align=V_RIGHT + V_BACK + V_UP);
}

holder();
