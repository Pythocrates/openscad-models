// This is a set of filament spool based organizer elements.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;
HFN = 360;


spool_outer_radius = 100;
spool_inner_radius = 53;
spool_inner_height = 70;


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
            cut_out_sector(r_max=or, a_min=180, a_max=270) tube(h=0.001, or=ir + 7, ir=ir + 1, align=V_DOWN, $fn=FN);

            mirror_copy(v=[1, 1, 0]) {
                translate([8, -ir - 8 + 0.528, -1]) difference() {
                    xmove(-1.0) cuboid([8 + 1, 8 + 1, h], align=V_TOP + V_LEFT + V_BACK);
                    zcyl(r=7, h=h, align=V_TOP, $fn=FN);
                }
            }
        }

        bottom_half() sphere(r=1, $fn=FN);
    }

    difference() {
        cut_out_sector(r_max=or, a_min=180, a_max=270) tube(h=1, or=or, ir=ir + 7, align=V_DOWN, $fn=FN);

        mirror_copy(v=[1, 1, 0]) {
            translate([6, -or + 6 + 0.185, -1]) difference() {
                cuboid([6 + 1, 6 + 1, h], align=V_TOP + V_LEFT + V_FRONT);
                zcyl(r=6, h=h, align=V_TOP, $fn=FN);
            }
        }
        zrot(360 / 48) ymove(-or + 2 + 2) zcyl(h=h, r=2, align=V_DOWN, $fn=FN);
    }
}


module enclosure(h, or, ir, wall_thickness=1, rotation=0) {
   difference() {
       union() {
           difference() {
                cut_out_sector(r_max=or, a_min=180, a_max=270) tube(h=h, or=or, ir=ir, $fn=HFN);
                difference() {
                    tube(h=h, or=or - wall_thickness, ir=ir + wall_thickness, $fn=HFN);
                    zrot(360 / 48) ymove(-or + 2 + 2) zcyl(h=h, r=4, align=V_UP, $fn=HFN);
                }

                mirror_copy(v=[1, 1, 0]) {
                    translate([8, -ir - 8 + 0.528, 0]) difference() {
                        xmove(-1.0) cuboid([8 + 1, 8 + 1, h], align=V_TOP + V_LEFT + V_BACK);
                        zcyl(r=8, h=h, align=V_TOP, $fn=HFN);
                    }

                    translate([6, -or + 6 + 0.185, 0]) difference() {
                        cuboid([6 + 1, 6 + 1, h], align=V_TOP + V_LEFT + V_FRONT);
                        zcyl(r=6, h=h, align=V_TOP, $fn=HFN);
                    }
                }

                zrot(360 / 48) ymove(-or + 2 + 2) zcyl(h=h, r=2, align=V_UP, $fn=HFN);

                zmove(h / 2) zrot(80) ymove(-or + 1 / 2) cuboid([10, 2, 15], fillet=5, edges=EDGES_Y_ALL, $fn=HFN);
            }

            mirror_copy(v=[1, 1, 0]) {
                xmove(ir + 7.47) cuboid([or - ir - 6 - 8 + 0.4, wall_thickness, h], align=V_FRONT + V_RIGHT + V_UP);

                translate([8, -ir - 8 + 0.529, 0]) cut_out_sector(r_max=70, a_min=7, a_max=90) tube(ir=7, or=8, h=h, align=V_UP, $fn=HFN);
                translate([6, -or + 6 + 0.185, 0]) cut_out_sector(r_max=70, a_min=90, a_max=180) tube(ir=5, or=6, h=h, align=V_UP, $fn=HFN);
            }
        }

        zmove(h) zcyl(h=1 + 1, r=ir + wall_thickness + 1, align=V_DOWN, $fn=FN);
    }
}


module full_drawer(h, or, ir, wall_thickness=1, base_thickness=1, rotation=0) {
    color("blue") base_plate(h=base_thickness, or=spool_outer_radius, ir=spool_inner_radius, rotation=-0);
    color("blue") enclosure(h=spool_inner_height - base_thickness - 0.5, or=spool_outer_radius, ir=spool_inner_radius, rotation=-0);
}


module cut_out_sector(r_max, a_min, a_max) {
    difference() {
        children();
        zrot(a_min) cuboid([2 * r_max, 2 * r_max, 2 * r_max], align=V_RIGHT);
        zrot(a_max) cuboid([2 * r_max, 2 * r_max, 2 * r_max], align=V_LEFT);
    }
}


//zmove(0.1) spool(h=spool_inner_height, or=spool_outer_radius, ir=spool_inner_radius);

color("blue") full_drawer(h=spool_inner_height, or=spool_outer_radius, ir=spool_inner_radius, rotation=-0);
