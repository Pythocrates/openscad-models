// This is a set of filament spool based organizer elements.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


spool_outer_radius = 100;
spool_inner_radius = 53;
spool_inner_height = 70;


module drawer(h, or, ir, wall_thickness=1, rotation=0) {
    zrot(a=rotation, cp=[(or - 2 - 2) * sin(360 / 48), -(or - 2 - 2) * cos(360 / 48), 0]) {
        mirror_copy(v=[1, 1, 0]) {

        ymove(0) xmove(ir + 7.48) cuboid([or - ir - 6 - 8 + 0.4, wall_thickness, h], align=V_FRONT + V_RIGHT + V_UP);

        translate([8, -ir - 8 + 0.528, h / 2]) intersection() {
            difference() {
                zcyl(r=8, h=h, $fn=FN);
                zcyl(r=7, h=h, $fn=FN);
            }
            xmove(-1.0) cuboid([8 + 1, 8 + 1, h], align=V_LEFT + V_BACK);
        }

        translate([6, -or + 6 + 0.185, h / 2]) intersection() {
            difference() {
                zcyl(r=6, h=h, $fn=FN);
                zcyl(r=5, h=h, $fn=FN);
            }
            xmove(0.0) cuboid([6 + 1, 6 + 1, h], align=V_LEFT + V_FRONT);
        }

        }

        difference() {
            //zcyl(h=h, r=or);
            //zcyl(h=h, r=ir);
            /*zmove(1) difference() {
                zcyl(h=h, r=or - wall_thickness);
                zcyl(h=h, r=ir + wall_thickness);
            }*/

            tube(h=h, or=or, ir=ir, $fn=FN);
            difference() {
                zmove(1) tube(h=h, or=or - wall_thickness, ir=ir + wall_thickness, $fn=FN);
                zrot(360 / 48) ymove(-or + 2 + 2) zcyl(h=h, r=4, align=V_UP, $fn=FN);
            }

            //xmove(1)
                cuboid([2 * or, 2 * or, 2 * or], align=V_LEFT);
            //ymove(-1)
                zrot(90) cuboid([2 * or, 2 * or, 2 * or], align=V_RIGHT);

            /*
            zrot(1) cuboid([2 * or, 2 * or, 2 * or], align=V_LEFT);
            zrot(89) cuboid([2 * or, 2 * or, 2 * or], align=V_RIGHT);
            */

        mirror_copy(v=[1, 1, 0]) {
            translate([8, -ir - 8 + 0.528, 0]) difference() {
                xmove(-1.0) cuboid([8 + 1, 8 + 1, h], align=V_TOP + V_LEFT + V_BACK);
                zcyl(r=8, h=h, align=V_TOP, $fn=FN);
            }

            translate([6, -or + 6 + 0.185, 0]) difference() {
                cuboid([6 + 1, 6 + 1, h], align=V_TOP + V_LEFT + V_FRONT);
                zcyl(r=6, h=h, align=V_TOP, $fn=FN);
            }
            }

            zrot(360 / 48) ymove(-or + 2 + 2) zcyl(h=h, r=2, align=V_UP, $fn=FN);

            zmove(h / 2) zrot(80) ymove(-or + 1 / 2) cuboid([10, 2, 15], fillet=5, edges=EDGES_Y_ALL, $fn=FN);
        }
    }
}


module spool(h, ir, or) {
    color("black") {
        difference() {
            zcyl(h=3, r=or, align=V_DOWN, $fn=FN);
            zrot(360 / 48) ymove(-or + 2 + 2) zcyl(h=3, r=2, align=V_DOWN, $fn=FN);
        }
        zcyl(h=h, r=ir, align=V_UP, $fn=FN);
    }
}


module base_plate(h, or, ir, wall_thickness=1, rotation=0) {
    minkowski() {
        difference() {
            tube(h=0.001, or=ir + 7, ir=ir + 1, align=V_DOWN, $fn=FN);

            cuboid([2 * or, 2 * or, 2 * or], align=V_LEFT);
            zrot(90) cuboid([2 * or, 2 * or, 2 * or], align=V_RIGHT);

            mirror_copy(v=[1, 1, 0]) {
                //#cuboid([1, or, 0.01], align=V_RIGHT + V_FRONT);
                translate([8, -ir - 8 + 0.528, -1]) difference() {
                    xmove(-1.0) cuboid([8 + 1, 8 + 1, h], align=V_TOP + V_LEFT + V_BACK);
                    zcyl(r=7, h=h, align=V_TOP, $fn=FN);
                }

            }

            #zmove(h / 2) zrot(80) ymove(-or + 1 / 2) cuboid([10, 2, 15], fillet=5, edges=EDGES_Y_ALL, $fn=FN);
        }

        bottom_half() sphere(r=1, $fn=FN);
    }

    difference() {
        tube(h=1, or=or - 1, ir=ir + 7, align=V_DOWN, $fn=FN);

        cuboid([2 * or, 2 * or, 2 * or], align=V_LEFT);
        zrot(90) cuboid([2 * or, 2 * or, 2 * or], align=V_RIGHT);

        mirror_copy(v=[1, 1, 0]) {
            translate([6, -or + 7 + 0.185, -1]) difference() {
                cuboid([6 + 1, 6 + 1, h], align=V_TOP + V_LEFT + V_FRONT);
                zcyl(r=6, h=h, align=V_TOP, $fn=FN);
            }
        }
        zrot(360 / 48) ymove(-or + 2 + 2) zcyl(h=h, r=2, align=V_DOWN, $fn=FN);
    }
}


//drawer();
//zmove(0.1) spool(h=spool_inner_height, or=spool_outer_radius, ir=spool_inner_radius);
//color("blue") drawer(h=spool_inner_height, or=spool_outer_radius, ir=spool_inner_radius, rotation=-0);

color("blue") base_plate(h=spool_inner_height, or=spool_outer_radius, ir=spool_inner_radius, rotation=-0);


//color("green") zmove(-3) zrot(360 / 48) ymove(-spool_outer_radius + 2 + 2) zcyl(h=spool_inner_height + 2 * 3, r=1.85, align=V_UP, $fn=FN);
//color("red") xflip() drawer(h=0.1 * spool_inner_height, or=spool_outer_radius, ir=spool_inner_radius, rotation=-0);