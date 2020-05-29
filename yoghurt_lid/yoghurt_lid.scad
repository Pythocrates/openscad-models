// This a lid for yoghurt coming without a solid lid.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

module lid() {
    rim_diameter = 95;
    cup_diameter = rim_diameter - 2 * 4;
    rim_thickness = 1;

    lid_height = 5;
    lid_thickness = 2;
    radial_thickness = 2;

    difference() {
        cyl(d=rim_diameter + 2 * radial_thickness, h=lid_height, align=V_UP, fillet2=1,  $fn=FN);
        cyl(d=rim_diameter, h=lid_height - lid_thickness, align=V_UP, $fn=FN);
    }
    //zrot_copies(n=4, r=rim_diameter / 2) zmove(1) sphere(r=1, $fn=FN);
    intersection() {
        zmove(1) torus(r=rim_diameter / 2, r2=1, $fn=FN);
        union() {
            zrot(-1.5) pie_slice(ang=3, l=3, r=rim_diameter / 2 + radial_thickness);
            zrot(120 - 2.5) pie_slice(ang=5, l=3, r=rim_diameter / 2 + radial_thickness);
            zrot(240 - 2.5) pie_slice(ang=5, l=3, r=rim_diameter / 2 + radial_thickness);
        }
    }
    zmove(lid_height - lid_thickness) zrot(-10) pie_slice(ang=20, l=lid_thickness, r=rim_diameter / 2 + radial_thickness, $fn=FN);
}


intersection() {
    lid();
    /*union() {
        cuboid([100, 10, 10]);
        cuboid([10, 100, 10]);
    }*/
}
