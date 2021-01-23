// This is a special sink strainer for sinks with an obstructive object in the middle.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 40;
LFN = 20;


module sink_strainer(sink_radius, height_above, height_below, thickness=1) {
    difference() {
        union() {
            tube(h=height_above, ir=sink_radius - thickness, or=sink_radius, align=V_TOP, $fn=FN);
            tube(h=3, ir=sink_radius - thickness, or2=sink_radius, or1=sink_radius + 1.0, align=V_TOP, $fn=FN);
        }

        N = 5;
        for (i = [0:N - 1]) {
            zrot_copies(n=30) zrot(360 / 30 / N * i) zmove(1 + i * 1.5) xcyl(h=sink_radius * 3, r=0.5, $fn=LFN);
        }
    }
    tube(h=height_below, ir=sink_radius - thickness, or=sink_radius, align=V_DOWN, $fn=FN);
}


sink_strainer(sink_radius=36 / 2, height_above=10, height_below=10, thickness=1);
