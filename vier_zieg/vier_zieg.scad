// That is a stack of four goats (VierZi(e)g(en)).
// The goat was taken from https://www.thingiverse.com/thing:2626862.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>
use <goat.scad>

FN = 120;




module planetary_bearing() {
    include <Gear_Bearing/bearing.scad>
}


module annular_assembly(n) {
    zmove(6 + 1 + 4) zmove(15) /*for (i=[0:3])*/ {
        color("yellow") zrot(90 * 0) xmove(-65.2) zrot(-90) xmove(-23) fixable_goat(length=150, thickness=15);
        color("blue") zrot(90 * 1) xmove(-65.2) zrot(-90) xmove(-23) fixable_goat(length=150, thickness=15);
        color("red") zrot(90 * 2) xmove(-65.2) zrot(-90) xmove(-23) fixable_goat(length=150, thickness=15);
        color("green") zrot(90 * 3) xmove(-65.2) zrot(-90) xmove(-23) fixable_goat(length=150, thickness=15);
    }

    zmove(6) zmove(15) top_plate(goat_length=150, goat_thickness=15);

    zmove(2) planetary_bearing();

    pole_adapter();
}


module top_plate(goat_length, goat_thickness) {
    outer_radius = 90;
    thickness = 5;

    difference() {
        zcyl(r=outer_radius, h=thickness, align=V_TOP, $fn=FN);
        for (i=[0:3]) {
            zrot(90 * i) xmove(-65.2) zrot(-90) xmove(-23) {
                zmove(thickness - 2) xmove(-goat_length * 0.10) cuboid([0.1 + goat_length * 0.16, 0.1 + goat_thickness, 2], align=V_UP);
                zmove(thickness - 2) xmove(goat_length * 0.38) cuboid([0.1 + goat_length * 0.21, 0.1 + goat_thickness, 2], align=V_UP);

                place_copies(goat_length * [[-0.08, 0, 0], [0.388, 0, 0]]) {
                    zcyl(d=3.1, h=thickness, align=V_TOP, $fn=FN);
                }
            }


        }
    }

    difference() {
        tube(h=15, or=outer_radius, ir=outer_radius - 2, align=V_DOWN, $fn=FN);
    }
    zrot_copies(n=4, sa=0, r=51.7 / 2 + 3) cuboid([outer_radius - 2 - 51.7 / 2 - 3, 2, 10], align=V_RIGHT + V_DOWN);

    difference() {
        zcyl(r=51.7 / 2 + 3, h=15 + 2, align=V_DOWN, $fn=FN);
        zcyl(r=51.7 / 2 - 2, h=15 + 2, align=V_DOWN, $fn=FN);
        zmove(-2) zcyl(r=51.7 / 2, h=15, align=V_DOWN, $fn=FN);
    }
}

// The part connecting the fence post to the planetary gear under the top plate.
module pole_adapter() {
    inner_pole_diameter = 38.5;
    adapter_depth = 30;
    cone_height = 5;

    zmove(-cone_height) {
        zcyl(d1=inner_pole_diameter, d2=inner_pole_diameter + cone_height, h=cone_height, align=V_UP, $fn=FN);
        zcyl(d=inner_pole_diameter, h=adapter_depth, align=V_DOWN, $fn=FN);
    }
    zcyl(d=1 + 6.7, 15 + 2, align=V_UP, $fn=6);
    zcyl(d=13, 2, align=V_UP, $fn=FN);

}


// Adding some base plates with holes to the goat.
module fixable_goat(length, thickness) {
    plate_thickness = 2;
    plate_overlap = 0.2;
    difference() {
        union() {
            goat(length=length, thickness=thickness);
            zmove(-plate_thickness) xmove(-length * 0.10) cuboid([length * 0.16, thickness, plate_thickness + plate_overlap], align=V_UP);
            zmove(-plate_thickness) xmove(length * 0.38) cuboid([length * 0.21, thickness, plate_thickness + plate_overlap], align=V_UP);
        }
        //xmove(-length * 0.08) {
        place_copies(length * [[-0.08, 0, 0], [0.388, 0, 0]]) {
            zcyl(d=5.8, h=15, align=V_TOP, $fn=FN);
            zcyl(d=3.1, h=plate_thickness, align=V_DOWN, $fn=FN);
        }
    }
}


module goat(length, thickness) {
    original_length = 2 * 58.564125 * 25.4 / 90;
    y_offset = 49.398539 * 25.4 / 90;
    scale_factor = length / original_length;
    xrot(90) zmove(-thickness / 2) scale([scale_factor, scale_factor, 1]) ymove(y_offset) poly_path3269(h=thickness);
}


// The full assembly.
//annular_assembly(n=4);

/*
intersection() {
top_plate(goat_length=150, goat_thickness=15);
zcyl(d=70, h=20);
}
*/
intersection() {
pole_adapter();
zmove(0.1) zcyl(d=70, h=20, align=V_UP);
}
//fixable_goat(length=150, thickness=15);
