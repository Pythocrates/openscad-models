// Gardena telescope selfie adapter for Samsung Galaxy S10

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
        yrot(90) zmove(32) cyl(r=9.25, l=40 + 8.25 + 4, align=V_DOWN, chamfer2=3, $fn=FN);
        //xmove(-5) yrot(90) cyl(r=5, l=32, align=V_UP, chamfer2=3, $fn=FN);
    }
    xrot_copies(n=6) prismoid(size1=[40.658, 2], size2=[40.658, 11.15], h=8.009, orient=ORIENT_Y, align=V_FRONT + V_RIGHT);
    //xmove(-20) xcyl(r=7, h=1.5, align=V_RIGHT, $fn=FN);
    //xmove(-10) xcyl(r=7, h=1.5, align=V_LEFT, $fn=FN);
}


module s10_landscape_shape(height) {
    phone_height = 150;
    phone_thickness = 8.5;

    zmove(height * 1.5) difference() {
        cuboid([phone_height + 4, phone_thickness + 4, height * 2]);
        cuboid([phone_height, phone_thickness, height * 2]);
        cuboid([phone_height - 30, phone_thickness + 4, height * 2]);
    }
    difference() {
        cuboid([phone_height + 4, phone_thickness + 4, height]);
        cuboid([phone_height, phone_thickness, height]);
    }
    difference() {
    hull($fn=FN) {
        zmove(-height / 2) cuboid([phone_height + 4, phone_thickness + 4, 1], align=V_DOWN);
        zmove(-18) ycyl(h=phone_thickness + 4, r=9.25);
    }
        zmove(-15) xspread(spacing=70) cuboid([3, phone_thickness + 4, 10], fillet=1.5, edges=EDGES_Y_ALL, $fn=FN);
    }
}





module full_gimbal() {
    adapter_shaft();
    translate([-14, 0, 18]) zrot(90) s10_landscape_shape(height=10);
}


full_gimbal();
