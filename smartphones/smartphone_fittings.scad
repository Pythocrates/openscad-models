// Headphone hanger for Steelcase Gesture head rest.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 180;

//ORIENT_LANDSCAPE = ORIENT_X;  // 90, 0, 90
//ORIENT_PORTRAIT = ORIENT_Z;  // 0, 0, 0

S2 = [0, 10.5, 148];
S5 = [0, 8.4, 148];
S7 = [0, 8.2, 148];
S10 = [0, 8.2, 150];

// TODO: too long, but thickness is quite OK?
module s7_landscape_o_shape(height) { 
    difference() {
        cuboid([148 + 4, 8.5 + 4, height]);
        cuboid([148, 8.5, height]);
    }
}


module landscape_o_shape(phone, height) {
    difference() {
        cuboid([phone.z + 4, phone.y + 4, height]);
        cuboid([phone.z, phone.y, height]);
    }
}


module landscape_u_shape(phone, size) {
    difference() {
        cuboid([size.x, phone.y + size.y, size.z], fillet=10, edges=EDGES_Y_TOP, align=V_UP + V_FRONT, $fn=FN);
        translate([0, -2, 2 + 5]) cuboid([size.x, phone.y, size.z], align=V_UP + V_FRONT);
        translate([0, -4, 2 + 5 + 5]) cuboid([size.x, phone.y, size.z], align=V_UP + V_FRONT);
    }
}


//landscape_o_shape(phone=S10, height=10);
difference() {
    union() {
        xrot(-20) landscape_u_shape(phone=S10, size=[50, 4, 30]);
        ymove((S7.y + 4 / 2) / cos(-20)) xrot(-20) landscape_u_shape(phone=S7, size=[50, 4, 30]);
        ymove((S5.y + 4 / 2 + S7.y + 4 / 2) / cos(-20)) xrot(-20) landscape_u_shape(phone=S5, size=[50, 4, 30]);
        ymove((S2.y + 4 / 2 + S5.y + 4 / 2 + S7.y + 4 / 2) / cos(-20)) xrot(-20) landscape_u_shape(phone=S2, size=[50, 4, 30]);
        ymove((S2.y + 4 / 2 + S2.y + 4 / 2 + S5.y + 4 / 2 + S7.y + 4 / 2) / cos(-20)) xrot(-20) landscape_u_shape(phone=S2, size=[30, 4, 20]);
    }
    cuboid([50, 110, 10]);
}
