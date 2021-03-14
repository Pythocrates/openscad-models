// This is a mount for a bee hotel in a fence post.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;
EPSILON = 0.1; // one-side tolerance for extrusions


module bar(size) {
     xscale(size.x / size.z) difference() {
        xmove(-1) cuboid([size.z + 1, size.y, size.z], align=V_RIGHT + V_DOWN); 
        ycyl(r=size.z, h=size.y, align=V_RIGHT + V_DOWN, $fn=FN);
    }
}

module diagonal_bars(plate, outer_radius, length, bar_thickness=10) {
    half_diagonal = sqrt(pow(plate.x, 2) + pow(plate.y, 2));
    angle = atan2(plate.y, plate.x);
    intersection() {
        cuboid([plate.x, plate.y, length], align=V_DOWN);
        yflip_copy()
            rot(angle)
                xflip_copy()
                    xmove(outer_radius)
                        bar([half_diagonal / 2 - outer_radius, bar_thickness, length]);
    }
}


module perpendicular_bars(plate, outer_radius, length, bar_thickness=10) {
    for (pair=[[0, plate.x], [90, plate.y]]) {
        rot(pair[0])
            xflip_copy()
                xmove(outer_radius) 
                    bar([pair[1] / 2 - outer_radius, bar_thickness, length]);
    }
}


module mount() {
    inner_pole_radius = 38 / 2;
    outer_pole_radius = 45 / 2;
    outer_radius = outer_pole_radius + 3;
    plate = [170, 125, 10] - [10, 10, 0];
    length = 60;
    seam_radius = 0;

    cuboid(plate, align=V_UP);
    difference() {
        zcyl(r=outer_radius, h=length, align=V_DOWN, $fn=FN);
        zcyl(r=outer_pole_radius, h=length, align=V_DOWN, $fn=FN);
    }
    zcyl(r=inner_pole_radius, h=length, align=V_DOWN, $fn=FN);

    diagonal_bars(plate=plate, outer_radius=outer_radius, length=length);
    //perpendicular_bars(plate=plate, outer_radius=outer_radius, length=length);
    
    if (seam_radius > 0) {
        difference() {
            zcyl(r=outer_radius + seam_radius, h=seam_radius, align=V_DOWN);
            torus(r=outer_radius + seam_radius, r2=seam_radius, align=V_DOWN, $fn=FN);
        }
    }
}


mount();
