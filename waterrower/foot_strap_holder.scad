include <BOSL/shapes.scad>
use <BOSL/constants.scad>

FN = 180;


module strap_holder() {
    height = 8;
    width = 16.7;
    top_width = 15.9;
    top_thickness = 2.5;
    wall_thickness = 2.8;
    hole_distance = 62;
    full_length = 140;

    difference() {
        union() {
            difference() {
                zmove(height / 2) slot(l=full_length, h=height, d1=width, d2=top_width, $fn=FN);
                zmove((height - top_thickness) / 2) slot(l=full_length, h=height - top_thickness, d=width - 2 * wall_thickness, $fn=FN);
            }
            xspread(spacing=hole_distance, n=2) zcyl(h=height, d=top_width, align=V_TOP, $fn=FN);

        }
        zmove(height - 4) xspread(spacing=hole_distance, n=2) zcyl(h=4, d=11.5, align=V_TOP, $fn=6);
        xspread(spacing=hole_distance, n=2) zcyl(h=height, d=6, align=V_TOP, $fn=FN);
        //cuboid([27 + 3.7, width, 2.0], align=V_TOP);

        xspread(spacing=54, n=3) cuboid([27 + 3.7 / 2, width, 2.0], align=V_TOP);

    }
    stub_diameter = 3.7;
    xspread(spacing=54, n=3) grid2d(spacing=[27 + stub_diameter, width - stub_diameter], cols=2, rows=2) {
        zcyl(h=height, d1=stub_diameter, d2=stub_diameter - (width - top_width), align=V_TOP, $fn=FN);
    }
    xspread(spacing=54, n=3) zmove(2.5) xspread(spacing=6, n=2) cuboid([2, width - wall_thickness, height - 2.5],align=V_TOP, $fn=FN);

}


intersection() {
    strap_holder();
    /*
    radius = 2000;
    height = 8;
    zmove(-radius + height) sphere(r=radius, $fn=FN);
    */
}
