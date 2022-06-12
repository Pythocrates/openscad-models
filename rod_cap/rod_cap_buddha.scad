// Buddha for the modular garden rod caps.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

use <modular_rod_cap.scad>

/*
CAP_HEIGHT = 10;
CAP_THICKNESS = 2;
OUTER_CAP_DIAMETER = 47;
*/


module buddha_figurine(r_dist_holes=DEFAULT_INNER_CAP_DIAMETER / 4, n=3, r=1.5) {
    difference() {
        scale(5) zrot(-90) import("/home/mkrzykaw/Downloads/3d_models/buddha/kshitigarbha-buddha/JizoA.stl");
        zrot_copies(n=n, r=r_dist_holes) zcyl(r=r, h=10, align=V_DOWN, $fn=120);
    }
}


//buddha_figurine();

perforated_rod_cap(n=3, r=1.5, di=43.5);
