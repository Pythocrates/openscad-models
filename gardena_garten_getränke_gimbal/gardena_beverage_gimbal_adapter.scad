// Gimbal for bottles with a Gardena adapter.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module adapter_shaft() {
    intersection() {
        xmove(19) union() {
            xmove(54) xflip_copy() xcyl(h=13.75, r1=10.875, r2=0, $fn=FN, align=V_RIGHT);
            xmove(35.0) xcyl(h=13.75, r1=10.875, r2=0, $fn=FN, align=V_RIGHT);
            xcyl(h=40, r=10.875, $fn=FN, align=V_RIGHT);
        }
        xcyl(r=6.91, l=82, align=V_RIGHT, $fn=6);
    }
    xmove(59) xcyl(r=5.2, l=14, $fn=6);
    hull() {
        yrot(90) cyl(r=9.25, l=32, align=V_UP, chamfer2=3, $fn=FN);
        xmove(-5) yrot(90) cyl(r=5, l=32, align=V_UP, chamfer2=3, $fn=FN);
    }
    xrot_copies(n=6) prismoid(size1=[40.658, 2], size2=[40.658, 11.15], h=8.009, orient=ORIENT_Y, align=V_FRONT + V_RIGHT);
    xcyl(r=5, h=20, align=V_LEFT, $fn=FN);
    xmove(-20) xcyl(r=7, h=1.5, align=V_RIGHT, $fn=FN);
    xmove(-10) xcyl(r=7, h=1.5, align=V_LEFT, $fn=FN);
}


module ring() {
    //yrot(90) tube(h=10, ir=5 + 0.1, or=7, $fn=FN);
    difference() {
        union() {
            xcyl(h=10, r=9, $fn=FN);
            ycyl(h=24, r=2, $fn=FN);
        }
        xcyl(h=10, r=5 + 0.5, $fn=FN);
        xmove(-5) xcyl(r=7 + 0.25, h=2 + 0.1, align=V_RIGHT, $fn=FN);
        xmove(5) xcyl(r=7 + 0.25, h=2 + 0.1, align=V_LEFT, $fn=FN);
    }
}


module swing() {
    difference() {
        zmove(5) cuboid([10, 24, 40], align=V_BOTTOM, fillet=4, $fn=FN);
        ycyl(l=24, r=2 + 0.2, $fn=FN);
        zmove(5) cuboid([10, 18 + 0.2, 30], align=V_BOTTOM);
        ymove(2) zmove(-35) cuboid([4 + 0.1, 14, 20], align=V_FRONT + V_UP);
        zmove(-30) cuboid([10, 4 + 0.1, 5], align=V_UP);
    }
}

module full_gimbal() {
    adapter_shaft();
    color("red") xmove(-15) ring();
    color("blue") xmove(-15) swing();
}


intersection() {
full_gimbal();
//#translate([-10, 0, -12]) cuboid([30, 30, 50]);
}
