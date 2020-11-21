// This is a simple, light-weight laptop stand.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>


FN = 120;


module leg_inner_shape() {
    union() {
        hull() { yspread(spacing=120) { xcyl(h=5, d=25, $fn=FN); } }
        hull() { zspread(spacing=120, sp=[0, 0, 0]) { xcyl(h=5, d=25, $fn=FN); } }
    }
}

module leg() {
    difference() {
        union() {
            hull() { yspread(spacing=120) { xcyl(h=5, d=30, $fn=FN); } }
            hull() { zspread(spacing=120, sp=[0, 0, 0]) { xcyl(h=5, d=30, $fn=FN); } }
        }
        leg_inner_shape();
    }
    zmove(120) tube(h=5, id=6.2, od=30, orient=ORIENT_X, align=V_CENTER, $fn=FN);
    difference() {
        union() {
            intersection() {
                leg_inner_shape();
                zmove((120 ) / 2) sparse_strut(h=120 + 30, l=120 + 30, thick=5, strut=2.5, maxang=50, max_bridge=25);
            }
            zmove(90) cuboid([5, 30, 15]);
        }
        zmove(90 + 30) yrot(90) arc_of(n=5, r=30, sa=-20, ea=20) zcyl(h=5, d=3.2, $fn=FN);
    }
}

module inclination_piece() {
    y_offset = 15;
    n_holes = 19;
    delta_angle = 8;

    difference() {
        hull() {
            cuboid([5, 50, 10]);
            zmove(-y_offset) bottom_half() {
                xcyl(h=5, d=65, $fn=FN);
            }
        }
        zmove(-y_offset) xcyl(h=5, d=6.2, $fn=FN);
        zmove(-y_offset) yrot(90) arc_of(n=n_holes, r=30, sa=-(n_holes - 1) / 2 * delta_angle, ea=(n_holes - 1) / 2 * delta_angle) zcyl(h=5, d=3.2, $fn=FN);
    }
}

module top_plate(inclination=0) {
    thickness = 5;

    zmove(-15) xrot(inclination) zmove(15) {
        zmove(thickness / 2) yrot(90) sparse_strut(h=160, l=200, thick=thickness, strut=4, maxang=50, max_bridge=15, orient=ORIENT_Z);
        xflip_copy(offset=200 / 2 - 5 - 5 / 2) {
            zmove(5 / 2) cuboid([15, 50, 5]);
            xflip_copy(offset=5) {
                inclination_piece();
            }
        }
    }
}

module parts() {
    //leg();
    zmove(-30) top_plate();
}

module assembly() {
    xflip_copy(200 / 2 - 5 - 5 / 2) leg();
    zmove(120 + 30 / 2) top_plate(inclination=5);
}

//parts();
assembly();
