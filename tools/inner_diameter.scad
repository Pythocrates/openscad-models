// A simple frustum to use for inner diameter measurements.

include <BOSL/shapes.scad>
use <BOSL/constants.scad>

FN = 120;


length = 30;

module meter(length, range, segments, subsegments=1) {
    segments = segments * subsegments;
    difference() {
        zcyl(l=5, d=range[1] + 10, align=V_UP, $fn=FN);
        zmove(4.5) linear_extrude(height=0.5) {
            distribute(dir=V_FRONT, spacing=12) {
                text(text="d [mm]", size=8, halign="center", valign="center");
                text(text=str(range[0], " - ", range[1]), size=8, halign="center", valign="center");
            }
        }
    }
    difference() {
        zcyl(l=length, d1=range[0], d2=range[1], align=V_DOWN, $fn=FN);
        zcyl(l=length, d1=range[0] - 4, d2=range[1] - 4, align=V_DOWN, $fn=FN);

        for (i = [1 : segments]) {
            mark_diameter = (i % subsegments == 0) ? 1 : 0.5;
            zrot(40 / subsegments * (-(subsegments - 1) + 1 * ((i - 1) % subsegments)))
                zmove(-length + i * length / segments)
                    ymove(-(range[0] / 2 + (range[1] - range[0]) / 2 * i / segments))
                        ycyl(l=4, d=mark_diameter, $fn=FN);
        }
    }
}


meter(length=60, range=[37, 39], segments=4, subsegments=5);
