// This is a simplified case for the CU-XC005 Pioneer remote.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module massive_vial_sleeve(D, h, thickness, d_tight) {
    // This is the angle of the pressing part.
    angle = asin((D - d_tight) / 2 / (h / 2));
    zrot_copies(n=4) zmove(-5) xmove(D / 2 + 1) yrot(angle) cuboid([thickness, 2, h / 2], align=V_LEFT + V_DOWN);
    difference() {
        zcyl(h=h + thickness, d=D + 2 * thickness, align=V_DOWN, $fn=FN);
        zcyl(h=h, d=D, align=V_DOWN, $fn=FN);
        zrot_copies(n=4) zmove(-5) xmove(D / 2 - 0.5) cuboid([thickness + 1, 2 + 0.5, h / 2 + 0.25], align=V_RIGHT + V_DOWN);
    }
}


module full_assembly(grid, distance, sleeve) {
    spacing = distance + sleeve[0] + 2 * sleeve[2];
    grid2d(spacing=spacing, cols=grid.x, rows=grid.y) massive_vial_sleeve(D=sleeve.x, h=sleeve.y, thickness=sleeve.z, d_tight=sleeve[3]);

    difference() {
        //cuboid([grid.x, grid.y, 0] * spacing + [4, 4, 4], align=V_DOWN);
        // To fit into the box grid.
        cuboid([70, grid.y * spacing, 0] + [0, 4, 4], align=V_DOWN);
        grid2d(spacing=spacing, cols=grid.x, rows=grid.y) zcyl(h=4, d=17, align=V_DOWN, $fn=FN);
    }
    xflip_copy() xmove(35) thickening_beam(length=10);
}


module beam(length) {
    cross_section  = [20.5, 16.8];
    cuboid([length, cross_section.x, cross_section.y], align=V_DOWN + V_RIGHT, fillet=3, edges=EDGES_X_ALL, $fn=FN);
}


module thickening_beam(length) {
    cross_section  = [20.5, 16.8];
    //cuboid([length, cross_section.x, cross_section.y], align=V_DOWN + V_RIGHT, fillet=3, edges=EDGES_X_ALL, $fn=FN);
    rounded_prismoid(cross_section, cross_section - [2, 2], h=length, r=3, shift=[0, 1], orient=ORIENT_X, align=V_DOWN + V_RIGHT, $fn=FN);
}


full_assembly(grid=[2, 5], distance=10, sleeve=[17, 30, 1, 15]);
//beam(length=10);
//thickening_beam(length=10);
