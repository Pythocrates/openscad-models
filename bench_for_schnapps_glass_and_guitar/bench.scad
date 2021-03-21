// This is a miniature park bench (from Thingiverse) adapted to carry a schnapps glass and a mini-guitar.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module glass() {
    cylinder(d1=38, d2=39, h=80, $fn=FN);
}


module panel(long=false, scale=1) {
    scale(scale)
    color("green") zrot(90)
    if (long)
        translate([-78.5, -25, 0]) import("playmobil-bench-seat-for-playground/playground_seat_panel_bigger.stl");
    else
        translate([17.5, 27, 7]) import("playmobil-bench-seat-for-playground/playground_seat_panel.stl");

    // Hole tightness adaption. Tested only with scale = 2.
    xspread(spacing=scale * (long ? 82 : 62)) {
        translate(scale * [0, 0, 0])
            color("red") difference() {
                cuboid([scale * 4 + 1, scale * 3 + 1, scale * 3], align=V_UP);
                cuboid([scale * 4 + 0.15 , scale * 3 + 0.15, scale * 3], align=V_UP);
        }
    }

}

module leg() {
    xmove(-2) zrot(90) xrot(90) import("playmobil-bench-seat-for-playground/playground_seat_legs3.stl");
}


module glass_holder() {
    difference() {
        zcyl(d=39 + 4, h=2, align=V_DOWN, $fn=FN);
        zmove(-1) glass_holder_holder(epsilon=0.1);
    }
    //cuboid([10, 6, 6 + 2], align=V_DOWN);
    zrot_copies(n=3)
    ymove(39 / 2) {
        cuboid([5, 1.5, 35], align=V_UP + V_BACK);
        zmove(35) xcyl(h=5, r=2, $fn=FN);
    }
}


module glass_holder_holder(epsilon=0) {
    zcyl(d=15 + epsilon, h=1, align=V_UP, $fn=FN);
    cuboid([10 + epsilon, 6 + epsilon, 6 + 2], align=V_DOWN);
}


module guitar_neck_holder() {
    zmove(-(6 + 2)) cuboid([13, 2, 11 + 20 + 6 + 2], align=V_UP + V_BACK, fillet=1, edges=EDGES_X_TOP, $fn=FN);
    cuboid([13, 6, 6], align=V_DOWN + V_FRONT);
    zmove(20 + 10) {
        xspread(spacing=9 + 2) xrot(-30, cp=[0, 1, 0]) ymove(2) cuboid([2, 25 + 2, 2], align=V_FRONT, fillet=1, edges=EDGES_X_ALL, $fn=FN);
    }
}


module bench(scale=1, long=false) {
    scale(scale) {
        xspread(spacing=long ? 82 : 62) leg();
    }

    ymove(-17.5 * scale) zmove(13 * scale) panel(long=long, scale=scale);
    zmove(27.5 * scale) xrot(90) panel(long=long, scale=scale);
}


// Testing the tightness of the hole between the two boards.
// Tested with 0.2mm QUALITY, legs with ColorFabb PLA/PHA, panels with FormFutura EasyFil
// +0.15 fits nicely and is easily removable
// +0.1 is quite tight and still removable
// +0.05 should fit, but really tight
module tightness_test() {
    difference() {
        xmove(-42) cuboid([100, 15, 6], align=V_UP);
        for (i=[0:5])
            xmove(-82 + i * 15) cuboid([8 + i * 0.05, 6 + i * 0.05, 6], align=V_UP);
    }
}


//bench(scale=2, long=false);
translate([-45, -35, 32]) {
    //glass();
    //zmove(2) glass_holder();
    //zmove(1) glass_holder_holder();
}
guitar_neck_holder();

//panel(scale=2);

//tightness_test();
