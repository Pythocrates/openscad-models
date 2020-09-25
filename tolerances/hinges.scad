// Testing hinge designs.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 60;


module hinged_plate(size, tolerance) {
    difference() {
        cuboid(size, align=V_RIGHT);
    }
}

module hinge_cylinder(r, h, tolerance=0) {
    ycyl(r=r + tolerance, h=h + 2 * tolerance, $fn=FN);
}

module hinge(r, h, length, thickness, width, tolerance=0) {
    hinge_cylinder(r=r, h=h, tolerance=tolerance);
    xmove(length) hinge_cylinder(r=r, h=h, tolerance=tolerance);
    cuboid([length, width + tolerance, thickness], align=V_RIGHT);
}

module assembly(size, tolerance) {
    cutout = [6, 4, size.z];
    hinge_length = 10;

    zrot_copies(n=2, r=hinge_length / 2 - size.z / 2)
    difference() {
        hinged_plate(size, tolerance=0.1);
        xmove(size.z / 2) yrot(180) hinge(r=size.z / 2, h=cutout.y + 2, tolerance=tolerance, thickness=size.z, width=cutout.y, length=hinge_length);
        xmove(size.z / 2) yrot(90) hinge(r=size.z / 2, h=cutout.y + 2, tolerance=tolerance, thickness=size.z, width=cutout.y, length=hinge_length);
        xmove(size.z / 2) yrot(-90) hinge(r=size.z / 2, h=cutout.y + 2, tolerance=tolerance, thickness=size.z, width=cutout.y, length=hinge_length);
    }
    xmove(-hinge_length / 2) hinge(r=size.z / 2, h=cutout.y + 2, tolerance=-tolerance, thickness=size.z, width=cutout.y, length=hinge_length);
}


assembly(size=[20, 20, 3], tolerance=0.1);
