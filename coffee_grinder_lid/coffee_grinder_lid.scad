// This a lid for a coffee grinder.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 360;


module lid(hollow=false) {
    top_diameter = 107;
    top_height = 3;

    rim_outer_diameter = 101;
    rim_height = 4;
    rim_thickness = 2;

    union() {
        tube(h=rim_height, od=rim_outer_diameter, id=rim_outer_diameter - 2 * rim_thickness, $fn=FN);
        zrot_copies(cp=[0,0,0], n=3, r=rim_outer_diameter / 2) zcyl(h=rim_height, d=1, align=V_UP);
        if (hollow) {
            zmove(rim_height) tube(h=top_height, od=top_diameter, id=rim_outer_diameter - 2 * 8, $fn=FN);
        } else {
            zmove(rim_height) zcyl(h=top_height, d=top_diameter, align=V_UP, $fn=FN);
        }
    }
}


lid(hollow=false);
