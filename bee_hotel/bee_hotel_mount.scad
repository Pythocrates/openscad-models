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

module diagonal_bars(plate, outer_radius, length, bar_thickness=10, circular=false) {
    half_diagonal = sqrt(pow(plate.x, 2) + pow(plate.y, 2));
    angle = atan2(plate.y, plate.x);
    intersection() {
        if (circular)
            zcyl(d=plate.y * sqrt(2), h=length, align=V_DOWN, $fn=FN);
        else
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


module spax_3_5x25(length) {
    screw = [7.0 + 0.75, 3.0 + 0.75, 3.5 + 0.25, length];
    zcyl(d1=screw[2], d2=screw[0], l=screw[1], align=V_DOWN, $fn=FN);
    zcyl(d=screw[2], l=screw[3], align=V_DOWN, $fn=FN);
}


module mount(circular=false) {
    outer_pole_radius = 21.75;
    inner_pole_radius = 38.4 / 2;
    outer_radius = outer_pole_radius + 3;
    length = 40;
    seam_radius = 0;

    plate = [circular ? 87 / sqrt(2) : 136, circular ? 87 / sqrt(2) : 87, 8] - [10, 10, 0];
    //plate = [circular ? 50 / sqrt(2) : 50, circular ? 50 / sqrt(2) : 50, 2];  // Just a minimum dummy

    if (circular)
        zcyl(d=plate.y * sqrt(2), h=plate.z, align=V_UP, $fn=FN);
    else
        difference() {
            //cuboid(plate, align=V_UP);
            prismoid(size1=[plate.x, plate.y], size2=[plate.x + 8, plate.y + 8], h=plate.z);
            zflip() xflip_copy(){
                xmove(plate.x / 2 - 8) spax_3_5x25(length=plate.z);
                yspread(n=2, spacing=plate.y - 16) xmove(outer_radius) spax_3_5x25(length=plate.z);
            }
        }

    difference() {
        zcyl(r=outer_radius, h=length, align=V_DOWN, $fn=FN);
        zcyl(r=outer_pole_radius, h=length, align=V_DOWN, $fn=FN);
    }
    zcyl(r=inner_pole_radius, h=1.5 * length, align=V_DOWN, $fn=FN);

    diagonal_bars(plate=plate, outer_radius=outer_radius, length=length, circular=circular);
    //perpendicular_bars(plate=plate, outer_radius=outer_radius, length=length);
    
    if (seam_radius > 0) {
        difference() {
            zcyl(r=outer_radius + seam_radius, h=seam_radius, align=V_DOWN);
            torus(r=outer_radius + seam_radius, r2=seam_radius, align=V_DOWN, $fn=FN);
        }
    }
}


mount(circular=false);
