// This is a special sink strainer for the shower.
// Setting spherical to true makes the bottom round.
// Setting it to false makes it flat and much more easier to print.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;


module outer_shape(sink_radius, height, bottom_radius, thickness, spherical=true) {
    intersection() {
        if (spherical) {
            z_center = sqrt(pow(bottom_radius, 2) - pow(sink_radius, 2)) - height;
            zmove(z_center) sphere(r=bottom_radius, $fn=FN);
            cyl(r=sink_radius, h=bottom_radius * 2, align=V_BOTTOM, $fn=FN);
        } else {
            zmove(-height) zcyl(r=sink_radius, h=height, align=V_TOP, $fn=FN);
        }
    }
}


module base_tube(sink_radius, height, bottom_radius, thickness) {
    difference() {
        cyl(r=sink_radius, h=height, align=V_BOTTOM, $fn=FN);
        cyl(r=sink_radius - thickness, h=height, align=V_BOTTOM, $fn=FN);
    }
}


module full_cap(sink_radius, height, bottom_radius, thickness, spherical) {
    if (spherical) {
        z_center = sqrt(pow(bottom_radius, 2) - pow(sink_radius, 2)) - height;
        difference() {
            zmove(z_center) sphere(r=bottom_radius, $fn=FN);
            zmove(-height) cyl(r=bottom_radius, h=bottom_radius * 2, align=V_UP, $fn=FN);
            zmove(z_center) sphere(r=bottom_radius - thickness, $fn=FN);
        }
    } else {
        zmove(-height) cyl(r=sink_radius, h=thickness, align=V_TOP, $fn=FN);
    }
}


module grid_cap(sink_radius, height, bottom_radius, thickness, spherical, center_offset=0) {
    difference() {
        full_cap(sink_radius, height, bottom_radius, thickness, spherical=spherical);
        yflip_copy() yspread(n=7, spacing=3 + 1.5, sp=[0, center_offset, 0]) cuboid([2 * bottom_radius, 3, bottom_radius], align=V_BOTTOM);
    }
}


module outer_handle(sink_radius, height, bottom_radius, thickness, spherical) {
    intersection() {
        cuboid([2 * sink_radius - 0.4, 6.5, height * 2], align=V_BOTTOM);
        outer_shape(sink_radius, height, bottom_radius, thickness, spherical=spherical);
    }
}


module shower_sink_strainer(sink_radius, height, bottom_radius, thickness=1, spherical) {
    difference() {
        union() {
            outer_handle(sink_radius, height, bottom_radius, thickness, spherical=spherical);
            base_tube(sink_radius, height, bottom_radius, thickness);
            zrot(90) grid_cap(sink_radius, height, bottom_radius, thickness, spherical=spherical);
            grid_cap(sink_radius, height, bottom_radius, thickness, spherical=spherical, center_offset=6);
        }
        zmove(-53) ycyl(h=4.5, r=bottom_radius, $fn=FN);
    }
}


shower_sink_strainer(sink_radius=61 / 2, height=16, bottom_radius=51, thickness=1, spherical=false);
