// This is a combined RaspberryPi and camera mount for the Prusa i3 MK3.
// It is a combination of some designs on the internet and extensions.

include <BOSL/transforms.scad>;
include <BOSL/shapes.scad>;
use <BOSL/transforms.scad>;

//import("/home/mkrzykaw/Downloads/3d_models/prusa_i3_mk3/original-prusa-i3-mk3.stl");

// Global settings
FN = 60;


module printer() {
    %import("/home/mkrzykaw/Downloads/3d_models/prusa_i3_mk3/Original_Prusa_i3_MK3_for_Fusion_360and_STL/files/Prusa_i3_MK3_Fusion.stl");
}

module case_bottom() {
    translate([-76.2, -228.6, 0]) {
        import("/home/mkrzykaw/Downloads/3d_models/raspberry_pi/Raspberry_Pi_2_3_OctoPi_Casemount_for_Prusa_i3_MK3/files/OctoPi_Case_for_Prusa_i3_MK3_Frontleft_Bottom.stl");
    }
}

module case_top() {
    translate([-76.4379, -247.603, 0]) {
        import("/home/mkrzykaw/Downloads/3d_models/raspberry_pi/Raspberry_Pi_2_3_OctoPi_Casemount_for_Prusa_i3_MK3/files/OctoPi_Case_for_Prusa_i3_MK3_Frontleft_top.stl");
    }
}

module case_arm() {
/*
    translate([-73.125, -10, -14.5]) {
        import("/home/mkrzykaw/Downloads/3d_models/raspberry_pi/Raspberry_Pi_2_3_OctoPi_Casemount_for_Prusa_i3_MK3/files/OctoPi_Case_for_Prusa_i3_MK3_Frontleft_Mount.stl");
    }
*/
    color([0.9, 0.3, 0.3]) {
        translate([-35.1311, 0, -3.209]) {
            difference() {
                cuboid([70.3, 20.0, 29.6], align=V_RIGHT + V_UP);
                translate([3.5149, 0, 3.2418]) cuboid([63.2701, 20.0, 23.1165], align=V_RIGHT + V_UP);
                translate(3.7 * [1.065, 0, 1]) ycyl(h=20, r=0.7, $fn=FN);
                translate([70.3, 0, 0] - 3.7 * [1.065, 0, -1]) ycyl(h=20, r=0.7, $fn=FN);
                translate([70.3, 0, 29.6] - 3.7 * [1.065, 0, 1]) ycyl(h=20, r=0.7, $fn=FN);
                translate([0, 0, 29.6] + 3.7 * [1.065, 0, -1]) ycyl(h=20, r=0.7, $fn=FN);

            }
        }
    }
    color([0.3, 0.9, 0.9]) {
        translate([-55.1311, 0, -14.209 - 0.0358]) {
            difference() {
                cuboid([35.9875, 20.0, 17.7255], align=V_LEFT + V_UP);
                translate([3.5149 - 6.32, 0, 3.3418 + 0.01]) {
                    cuboid([30.315 - 0.320, 20.0, 11.0020], align=V_LEFT + V_UP);
                    translate(0.7 * [-1, 0, 0.91]) ycyl(r=1.06, h=20, $fn=FN);
                }
                translate([-5.375, 0, 3.3428]) cuboid([25.993, 20, 15], align=V_LEFT + V_UP);
                translate([-29.355, 0, 16.5]) yrot(-15) cuboid([5, 20, 5]);
            }
            yrot(-19) translate([0, 0, 0]) cuboid([34, 20, 3.9], align=V_RIGHT + V_UP, chamfer=2, edges=EDGE_TOP_RT);
        }
    }
}

module ball_head_camera_mount() {
    sphere(r=5, $fn=FN);
    zcyl(r=2, h=20, align=V_DOWN, $fn=FN);
    translate([0, 0, -20]) cuboid([20, 20, 2]);
}

module ball_head_socket_bolt() {
    bayonet_bolt();
    difference() {
        union() {
            translate([-5, 0, 0]) cuboid([3, 7.1, 10], fillet=3.55, edges=EDGE_BOT_FR + EDGE_BOT_BK, align=V_DOWN, $fn=FN);
            translate([5, 0, 0]) cuboid([3, 7.1, 10], fillet=3.55, edges=EDGE_BOT_FR + EDGE_BOT_BK, align=V_DOWN, $fn=FN);
        }
        translate([0, 0, -6.4]) {
            sphere(r=5, $fn=FN);
        }
    }
}

module bayonet_bolt() {
    cylinder(r=15, h=5, $fn=FN);
    cylinder(r=10, h=5 + 2 * 6, $fn=FN);
    rot_copies(n=20, v=V_DOWN, delta=[9.9, 0, 0])
        cylinder(h=5 + 2 * 6, r=1.0, $fn=FN);

    cylinder(r=8, h=5 + 2 * 6 + 3 + 2 + 3, $fn=FN);
    translate([8 + 0.8, 0, 5 + 2 * 6 + 3 + 2 / 2]) xcyl(r=1.0, h=1.8, $fn=FN);
}

module bayonet_nut() {
    difference() {
        cylinder(r=15, h=3 + 2 + 3, $fn=FN);
        cylinder(r=8 + 0.05, h=3 + 2 + 3, $fn=FN);
        cuboid([15, 2.1, 2 + 3], align=V_UP + V_RIGHT);
        translate([0, 0, 3]) cuboid([15, 2, 2.1], align=V_UP + V_RIGHT);
        zrot(7.5) translate([0, 0, 3]) cuboid([15, 2, 2.1], align=V_UP + V_RIGHT);
        zrot(15) translate([0, 0, 3]) cuboid([15, 2, 2.1], align=V_UP + V_RIGHT);
        zrot(22.5) translate([0, 0, 3]) cuboid([15, 2, 2.1], align=V_UP + V_RIGHT);
        zrot(30) translate([0, 0, 3]) cuboid([15, 2, 2.1], align=V_UP + V_RIGHT);
    }
}

module link(length) {
    difference() {
        translate([-length / 2, 0, 0]) zrot(90) sparse_strut(h=20, l=length, thick=6, strut=2, maxang=45);
        ycyl(r=15, h=6);
        translate([-length, 0, 0]) ycyl(r=15, h=6);
    }

    place_copies([[0, 0, 0], [-length, 0, 0]]) {
        difference() {
            ycyl(r=15, h=6, $fn=FN);
            ycyl(r=11.1, h=10, $fn=FN);
        }
        rot_copies(n=20, v=V_FRONT, delta=[0, 0, 11.1], sa=360 / 20 / 2)
            ycyl(h=6, r=1.0, $fn=FN);
    }
}

module camera_arm_segment_7() {
    ball_head_camera_mount();
}

module camera_arm_segment_6() {
    ball_head_socket_bolt();
}

module camera_arm_segment_5() {
    link(length=50);
}

module camera_arm_segment_4() {
    link(length=50);
}

module camera_arm_segment_3() {
    link(length=100);
}

module camera_arm_segment_2_cap() {
    difference() {
        cylinder(r=16, h=20, $fn=FN);
        cylinder(r=11.1, h=10, $fn=FN);
        translate([14, 0, 15]) cuboid([4, 6, 10]);
        translate([-14, 0, 15]) cuboid([4, 6, 10]);
    }
    rot_copies(n=20, v=V_DOWN, delta=[11.1, 0, 0], sa=360 / 20 / 2)
        cylinder(h=10, r=1.0, $fn=FN);
}

module camera_arm_segment_2_clip() {
    difference() {
        translate([0, 0, -5]) cuboid([30, 6, 40], fillet=15, edges=EDGE_TOP_LF + EDGE_TOP_RT, $fn=FN);
        ycyl(r=11.1, h=10, $fn=FN);
        translate([0, 0, -20]) cuboid([30 - 2 * 3, 6, 10]);
    }
    rot_copies(n=20, v=V_FRONT, delta=[0, 0, 11.1], sa=360 / 20 / 2)
        //yrot(90) 
        ycyl(h=6, r=1.0, $fn=FN);
}

module camera_arm_segment_2() {
    camera_arm_segment_2_cap();
    translate([0, 0, 35]) camera_arm_segment_2_clip();
}

module camera_arm_segment_1() {
    cylinder(r=16, h=10, $fn=FN);
    cylinder(r=10, h=20, $fn=FN);
    rot_copies(n=20, v=V_DOWN, delta=[9.9, 0, 0])
        //yrot(90) 
        cylinder(h=20, r=1.0, $fn=FN);
}



// from segment_7 on
module camera_arm_chain_7() {
    camera_arm_segment_7();
}

// from segment_6 on
module camera_arm_chain_6() {
    camera_arm_segment_6();
    translate([0, 0, -6.5]) rotate([20, 20, 0]) camera_arm_chain_7();
}

// from segment_5 on
module camera_arm_chain_5() {
    camera_arm_segment_5();
    if (SHOW_BOLTS) {
        translate([0, 0, 0]) {
            translate([0, 8, 0]) xrot(90) bayonet_bolt();
            translate([0, -9.0, 0]) xrot(90) bayonet_nut();
        }
    }

    translate([-50, -8, 0]) xrot(-90) camera_arm_chain_6();
}

// from segment_4 on
module camera_arm_chain_4() {
    camera_arm_segment_4();
    if (SHOW_BOLTS) {
        translate([0, 6, 0]) {
            translate([0, 8, 0]) xrot(90) bayonet_bolt();
            translate([0, -9.0, 0]) xrot(90) bayonet_nut();
        }
    }

    translate([-50, 6, 0]) yrot(-360 / 20 * 2) camera_arm_chain_5();
}

// from segment_3 on
module camera_arm_chain_3() {
    camera_arm_segment_3();
    if (SHOW_BOLTS) {
        translate([0, 8, 0]) xrot(90) bayonet_bolt();
        translate([0, -9.0, 0]) xrot(90) bayonet_nut();
    }

    translate([-100, -6, 0]) yrot(360 / 20 * 2) camera_arm_chain_4();
}

// from segment_2 on
module camera_arm_chain_2() {
    camera_arm_segment_2();
    translate([0, 6, 35]) yrot(360 / 20 * 3) camera_arm_chain_3();
}

// from segment_1 on
module camera_arm_chain_1() {
    camera_arm_segment_1();
    translate([0, 0, 10]) camera_arm_chain_2();
}

module camera_arm_assembly() {
    camera_arm_chain_1();
}

module assembly(with_printer=false) {
    if (with_printer) {
        translate([-160.2, 120, -26.0]) printer();
    }

    color([0.4, 0.4, 0.4]) translate([13.5, 0, 0]) zrot(90) {
        case_bottom();
        translate([0, 0, 23.0]) {
            rotate([0, 180, 0]) {
                case_top();
            }
        }
    }
    case_arm();

    translate([0, 0, 26]) {
        camera_arm_assembly();
    }
}

module parts() {
    translate([-70, 0, 0]) {
        case_bottom();
    }
    case_top();
    translate([160, 0, 10]) {
        rotate([-90, 0, 0]) {
            case_arm();
        }
    }

    translate([0, 70, 0]) camera_arm_segment_1();
    translate([35, 70, 0]) bayonet_bolt();
    translate([35, 100, 0]) bayonet_nut();
    translate([75, 100, 0]) ball_head_socket_bolt();
    translate([0, 100, 0]) ball_head_camera_mount();
    translate([-40, 70, 20]) mirror([0, 0, 1]) camera_arm_segment_2_cap();
    translate([-80, 70, 3]) rotate([90, 0, 0]) camera_arm_segment_2_clip();
    translate([-80, -70, 3]) rotate([90, 0, 0]) camera_arm_segment_3();
    translate([10, -70, 3]) rotate([90, 0, 0]) camera_arm_segment_4();
    translate([100, -70, 3]) rotate([90, 0, 0]) camera_arm_segment_5();
}

SHOW_BOLTS = true;

parts();
//assembly(with_printer=false);
