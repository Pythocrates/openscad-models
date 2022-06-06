// Smartphone mount cap for the e-drum rack.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module m2_screw(radial_tolerance=0, linear_tolerance=0) {
    zcyl(d=3.4 + radial_tolerance * 2, h=1.5 + linear_tolerance, align=V_UP, $fn=FN); // head
    zcyl(d=1.9 + radial_tolerance * 2, h=8 + linear_tolerance, align=V_DOWN, $fn=FN); // thread
}


module m2_nut(radial_tolerance=0, linear_tolerance=0) {
    zcyl(d=3.9 / sqrt(3) * 2 + radial_tolerance * 2, h=1.5 + linear_tolerance, align=V_UP, $fn=6); // head
}


module rod_cap() {
    difference() {
        zcyl(d=42, h=20, align=V_DOWN, $fn=FN);
        zmove(-2 - 2) zcyl(d=38.2, h=20 - 2 - 2, align=V_DOWN, $fn=FN);
        zmove(-2) zflip() zrot_copies(n=3, r=15, sa=-30) m2_screw(radial_tolerance=0.1 / 2, linear_tolerance=1);
    }
}


module wedge(tilt_angle) {
    difference() {
        zcyl(d=42, h=40, align=V_UP, $fn=FN);
        zmove(42 / 2 * tan(tilt_angle)) xrot(tilt_angle) cuboid([42, 42 * 2, 40], align=V_UP);

        // top connection
        zmove(42 / 2 * tan(tilt_angle)) xrot(tilt_angle) zmove(1) zrot_copies(n=3, r=15, sa=-30) m2_screw(radial_tolerance=0.1 / 2, linear_tolerance=1);
        zmove(42 / 2 * tan(tilt_angle)) xrot(tilt_angle) zmove(-3) zflip() zrot_copies(n=3, r=15, sa=-30) m2_nut(radial_tolerance=0.1 / 2, linear_tolerance=30);

        // bottom connection
        zmove(-2) zflip() zrot_copies(n=3, r=15, sa=-30) m2_screw(radial_tolerance=0.1 / 2, linear_tolerance=1);
        zmove(2) zrot_copies(n=3, r=15, sa=-30) m2_nut(radial_tolerance=0.1 / 2, linear_tolerance=30);
    }
}


module phone_shell() {
    difference() {
        cuboid([70.04 + 2 * 2, 150 + 2, 10], fillet=5, edges=EDGES_Z_ALL, align=V_UP + V_BACK, $fn=FN);
        translate([0, 2, 3]) cuboid([70.04 + 0.1, 150, 10], fillet=3, edges=EDGES_Z_ALL, align=V_UP + V_BACK, $fn=FN);
        translate([0, 92, 3]) cuboid([80, 150, 10], align=V_UP + V_BACK);
        translate([0, 95 + 2, 1]) cuboid([50, 40, 10], fillet=5, edges=EDGES_Z_ALL, align=V_UP + V_BACK, $fn=FN);
        translate([0, 10 + 2, 1]) cuboid([50, 40, 10], fillet=5, edges=EDGES_Z_ALL, align=V_UP + V_BACK, $fn=FN);
        translate([0, 65 + 2, 1])  zrot_copies(n=3, r=15, sa=-30) m2_screw(radial_tolerance=0.1 / 2, linear_tolerance=1);
    }
}


module assembly(tilt_angle=0) {
    rod_cap();
    wedge(tilt_angle=tilt_angle);
    zmove(42 / 2 * tan(tilt_angle)) xrot(tilt_angle) ymove(-67) phone_shell();
    zmove(-2) zflip() zrot_copies(n=3, r=15, sa=-30) m2_screw();
}


//assembly(tilt_angle=40);
phone_shell();
