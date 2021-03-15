// This a lid for yoghurt coming without a solid lid.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module main_body(rim_diameter, radial_thickness, lid_height, lid_thickness) {
    difference() {
        cyl(d=rim_diameter + 2 * radial_thickness, h=lid_height, align=V_UP, fillet2=1,  $fn=FN);
        cyl(d=rim_diameter, h=lid_height - lid_thickness, align=V_UP, $fn=FN);
    }
}


module lid(rim_diameter) {
    cup_diameter = rim_diameter - 2 * 4;
    rim_thickness = 1;

    lid_height = 5;
    lid_thickness = 2;
    radial_thickness = 2;

    difference() {
        main_body(rim_diameter=rim_diameter, radial_thickness=radial_thickness, lid_height=lid_height, lid_thickness=lid_thickness);

        zmove(lid_height - lid_thickness) {
            for (i=[0,3]) {
                zrot(-10 + 90 * i) {
                    pie_slice(ang=20, l=0.2, r=rim_diameter / 2 + radial_thickness, align=V_DOWN, $fn=FN);
                    pie_slice(ang=0.25, l=lid_height - lid_thickness, r=rim_diameter / 2 + radial_thickness, align=V_DOWN, $fn=FN);
                }
            }
        }
    }
    zmove(1) zrot_copies(n=4, r=rim_diameter / 2, sa=-5) sphere(r=1, $fn=FN);
}


//lid(rim_diameter=95);  // big yoghurt cup
lid(rim_diameter=75);  // créme fraîche cup
