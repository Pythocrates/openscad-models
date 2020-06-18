// This is a simple Fritz!Box mount, maybe with a little bit of cable management.

include <BOSL/shapes.scad>
use <BOSL/constants.scad>

FN = 60;
TOL = 0.2;


module hook_adapter(nof_hooks, gap, fillet, bottom_thickness) {
    cuboid([18, nof_hooks * fillet + (nof_hooks - 1) * gap, 3], align=V_DOWN + V_RIGHT + V_BACK);

    difference() {
        for (i = [0:nof_hooks - 1]) {
            ymove(fillet * (i + 0.5) + gap * i) {
                cuboid([8, fillet - TOL, bottom_thickness], align=V_UP + V_RIGHT);
                zmove(bottom_thickness) cuboid([16, fillet - TOL, 2], align=V_UP + V_RIGHT);
            }
        }
        zmove(bottom_thickness) yrot(-15) cuboid([30,  nof_hooks * fillet + (nof_hooks - 1) * gap, 3], align=V_UP + V_RIGHT + V_BACK);
    }

    ymove(nof_hooks * fillet + (nof_hooks - 1) * gap) {
        cuboid([20, (nof_hooks * fillet + (nof_hooks - 1) * gap) + 50 + 25, 10], align=V_DOWN + V_RIGHT + V_FRONT);
    }

    ymove(-50 - 25 / 2) {
        difference() {
            cuboid([20, 25, 40], align=V_UP + V_RIGHT);
            zmove(2) cuboid([20, 15.5, 38], align=V_UP + V_RIGHT);
        }
    }
}


module parts() {
    hook_adapter(nof_hooks=10, gap=2, fillet=2, bottom_thickness=2.5);
    xmove(-5) xflip() hook_adapter(nof_hooks=10, gap=2, fillet=2, bottom_thickness=2.5);
}


module assembly() {

}


parts();
