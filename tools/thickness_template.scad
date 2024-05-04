// A simple tool with differently thick blades from 2 to 4 mm in 0.5 mm steps.

include <BOSL/shapes.scad>
use <BOSL/constants.scad>

FN = 120;


length = 30;


module blade(thickness) {
    #move([15., 1, 0]) zrot(-34) cuboid([.65, 1, 1], align=V_UP + V_LEFT);
    difference() {
        cuboid([30, 10, thickness], align=V_RIGHT + V_UP);
        xmove(15) {
            linear_extrude(height = thickness) text(str(thickness), size=6, halign="center", valign="center");
        }

    }
}


module tool() {
    zcyl(h=4, r=10, align=V_UP, $fn=FN);
    for (thickness = [2 : 0.5: 4]) {
        zrot((thickness - 2) / 2.5 * 360) blade(thickness);
    }
}


tool();
