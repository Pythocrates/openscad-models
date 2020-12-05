// This is a simple sleeve for the FireTV remote to dampen Alexa.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module sleeve(r_top, r_bottom, r_side, d_vertical, thickness, height=1) {
    difference() {
        shape(r_top, r_bottom, r_side, d_vertical, thickness=thickness, height=height);
        shape(r_top, r_bottom, r_side, d_vertical, height=height);
        ymove(1 - 0.15) cuboid([10, 1, height / 2], fillet=5, edges=EDGES_Y_BOT, align=V_FRONT + V_TOP, $fn=FN);  // Alexa button
        xmove(-11) ymove(1 - 0.65) zmove(height / 2 - (14 + 7.5 / 2)) zrot(5.7) cuboid([7.5, 1, 14 + 7.5 / 2], fillet=7.5 / 2, edges=EDGES_Y_BOT, align=V_FRONT + V_TOP, $fn=FN);  // power button
        xmove(-11) ymove(1 - 0.65) zmove(height / 2 - (14 + 7.5 / 2)) zrot(5.7) ycyl(h=thickness + 1, d=7.5, align=V_TOP, $fn=FN);  // power button hole
        xmove(-11) ymove(1 - 0.65) zmove(height / 2 - (14 )) zrot(5.7) ymove(9) sphere(d=7.5 + 12, $fn=FN);  // spherical power button cutout for the thumb
        ymove(-thickness - d_vertical + 0.5) zmove(height / 2 - 20) xrot(-atan2(2 - 0.5, 110 + 20)) cuboid([20, 5, 20], align=V_FRONT + V_TOP);

    }
    zmove(height / 2 - 15) yscale(1.5) cyl(l=3, d=1, fillet=0.5, align=V_BOTTOM, $fn=FN);
}


module shape(r_top, r_bottom, r_side, d_vertical, thickness=0, height=1) {
    minkowski() {
        intersection() {
            ymove(r_bottom - d_vertical) zcyl(h=height / 2, r=r_bottom - r_side, $fn=FN);
            ymove(-r_top) zcyl(h=height / 2, r=r_top - r_side, $fn=FN * 4);
        }
        zcyl(r=r_side + thickness, h=height / 2, $fn=FN * 4);
    }
}


module rounded_sleeve(r_top, r_bottom, r_side, d_vertical, thickness, height=1) {
    intersection() {
        sleeve(r_top=r_top, r_bottom=r_bottom, r_side=r_side, d_vertical=d_vertical, thickness=thickness, height=height);  // 4a
        translate([0, 15, 38 + 24.5]) staggered_sphere(d=150, $fn=FN);
        //sphere(d=30, $fn=FN);
    }
}

rounded_sleeve(r_top=110, r_bottom=22.8, r_side=3, d_vertical=7.95 + 8.67 - 0.6, thickness=2, height=22);  // 4a
//sleeve(r_top=110, r_bottom=22.8, r_side=3, d_vertical=7.95 + 8.67 - 0.6, thickness=2, height=20);  // 4a


// old shapes
//%zmove(1) sleeve(r_top=62.4, r_bottom=23.3, r_side=2, d_vertical=7.95 + 8.67, thickness=1, height=3);
//sleeve(r_top=110, r_bottom=22.8, r_side=3, d_vertical=7.95 + 8.67 - 0.6, thickness=2, height=3);  // 4
//sleeve(r_top=110, r_bottom=22.3, r_side=3, d_vertical=7.95 + 8.67 - 0.6, thickness=1, height=3);  // 3
//sleeve(r_top=110, r_bottom=23.3, r_side=3, d_vertical=7.95 + 8.67 - 0.6, thickness=1, height=3);  // 2
//sleeve(r_top=110, r_bottom=23.3, r_side=3, d_vertical=7.95 + 8.67 - 0.1, thickness=1, height=3);  // 1
