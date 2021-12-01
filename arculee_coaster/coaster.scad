// An arculee shaped beer coaster.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>
use <BOSL/metric_screws.scad>

TOP_PLATE = 1;
UPPER_BODY = 2;
LOWER_BODY = 4;
SCREW = 8;
NUT = 16;
WHEEL = 32;
PLATE_DEPRESSOR = 64;
SKIN = 128;

FLAGS = [
    TOP_PLATE,
    UPPER_BODY,
    LOWER_BODY,
    SCREW,
    NUT,
    WHEEL,
    PLATE_DEPRESSOR,
    SKIN,
];


FN = 120;

WHEEL_THICKNESS = 5;
WHEEL_RADIAL_TOLERANCE = 1;
WHEEL_AXIAL_TOLERANCE = 1;

SKIN_WIDTH = 94;  // 753;
SKIN_LENGTH = 100;  // 803;
SKIN_HEIGHT = 15;  // 120;
SKIN_WIDTH_MARGIN = 8.5;  // 67;
SKIN_LENGTH_MARGIN = 9.0;  // 72;
width_margin = 13;
length_margin = 14;

WALL_THICKNESS = 3.75; // 30;
VERTICAL_EDGE_RADIUS = 3.5;  // 25;
TOLERANCE = 0.2;  // 10;
BODY_WIDTH = SKIN_WIDTH - 2 * WALL_THICKNESS - 2 * TOLERANCE;
BODY_LENGTH = SKIN_LENGTH - 2 * WALL_THICKNESS - 2 * TOLERANCE;
BODY_HEIGHT = 28;  // 227;

WHEEL_DIAMETER = 12;

RADIAL_SLACK = 1;
AXIAL_SLACK = 1;

SCREW_HEAD_OUTER_DIAMETER = 30;
SCREW_HEAD_INNER_DIAMETER = 21;
SCREW_HEAD_THICKNESS = 2;

SCREW_THREAD_DIAMETER = 17;
MUG_DIAMETER = 80;

TOP_FILLET_RADIUS = 1;


module rounded_corner(xdir, ydir) {
    x_offset = SKIN_WIDTH / 2 - VERTICAL_EDGE_RADIUS;
    y_offset = SKIN_LENGTH / 2 - VERTICAL_EDGE_RADIUS;

    translate([xdir * x_offset, ydir * y_offset, 0])
        cyl(r=VERTICAL_EDGE_RADIUS, h=SKIN_HEIGHT, fillet2=TOP_FILLET_RADIUS, align=V_UP, $fn=FN);
}

module skin() {
    for (i = FLAGS) if (i == SKIN) {
        difference() {
            union() {
                for (xdir = [-1, 1]) for (ydir =  [-1, 1]) rounded_corner(xdir, ydir);
                cuboid([SKIN_WIDTH, SKIN_LENGTH - 2 * VERTICAL_EDGE_RADIUS, SKIN_HEIGHT], align=V_UP, fillet=TOP_FILLET_RADIUS, edges=EDGE_TOP_LF + EDGE_TOP_RT, $fn=FN);
                cuboid([SKIN_WIDTH - 2 * VERTICAL_EDGE_RADIUS, SKIN_LENGTH, SKIN_HEIGHT], align=V_UP, fillet=TOP_FILLET_RADIUS, edges=EDGE_TOP_FR + EDGE_TOP_BK, $fn=FN);
            }
            zmove(10) cuboid([SKIN_WIDTH - 2 * SKIN_WIDTH_MARGIN, SKIN_LENGTH - 2 * SKIN_LENGTH_MARGIN, SKIN_HEIGHT], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
            cuboid([SKIN_WIDTH - 2 * WALL_THICKNESS, SKIN_LENGTH - 2 * WALL_THICKNESS, SKIN_HEIGHT - WALL_THICKNESS], align=V_UP);
        }
    }
}


module lifting_screw() {
    // Lifting mechanism
    for (i = FLAGS) if (i == SCREW) {
        difference() {
            union() {
                zmove(-4.2) metric_bolt(headtype="countersunk", size=17 - 0.5, l=15, details=true, pitch=4.4, phillips="#2", $fn=FN);
                difference() {
                    zcyl(h=2, d=30, align=V_DOWN, $fn=FN);
                    zcyl(h=2, d=15, align=V_DOWN, $fn=FN);
                }
            }
            zmove(6) ycyl(d=23.25 + 0.2, h=2.33 + 0.2, $fn=FN);
        }
    }
}


module plate_depressor() {
    for (i = FLAGS) if (i == PLATE_DEPRESSOR){
        color("black") zmove(0.5) zrot(90) {
            slot(d=9, h=1, l=72, $fn=FN);
            cuboid([30, 15, 1], align=V_FRONT);
        }
    }
}

module top_plate() {
    for (i = FLAGS) if (i == TOP_PLATE){
        // Mug shape
        zmove(BODY_HEIGHT) {
            difference() {
                color("red") cuboid([SKIN_WIDTH - 2 * SKIN_WIDTH_MARGIN, MUG_DIAMETER + 4, WALL_THICKNESS], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);  // lid
                zcyl(d=SCREW_HEAD_OUTER_DIAMETER - 4, h=WALL_THICKNESS, align=V_UP, $fn=FN);
            }
            zmove(WALL_THICKNESS) color("orange") intersection() {
                //cuboid([SCREW_HEAD_OUTER_DIAMETER + 6, MUG_DIAMETER + 4.6, WALL_THICKNESS + 6], align=V_UP);
                difference() {
                    zcyl(d=MUG_DIAMETER + 4, h=WALL_THICKNESS + 6, align=V_UP, $fn=FN);
                    zcyl(d=MUG_DIAMETER + 1, h=WALL_THICKNESS + 6, align=V_UP, $fn=FN);
                }
                zmove(-30 + WALL_THICKNESS) ycyl(h=MUG_DIAMETER + 8, d=70, $fn=FN);
            }
        }
    }

    zmove(BODY_HEIGHT + WALL_THICKNESS) xflip_copy(offset=30) plate_depressor();
}


module screw_support_and_mug_rails() {
    color("gray") difference() {
        cuboid([SCREW_HEAD_OUTER_DIAMETER + 6, MUG_DIAMETER + 12, 3 * SCREW_HEAD_THICKNESS], align=V_DOWN);
        zcyl(d=SCREW_HEAD_OUTER_DIAMETER + 1, h=SCREW_HEAD_THICKNESS + 0.2, align=V_DOWN, $fn=FN);
        zcyl(d=SCREW_HEAD_INNER_DIAMETER + 0.25, h=3 * SCREW_HEAD_THICKNESS, align=V_DOWN, $fn=FN);
    }
}


module lifting_nut() {
    // Lifting mechanism.
    metric_nut(size=17, hole=true, pitch=4.4, flange=5, details=true, $fn=FN);
}


module upper_body() {
    color("gray") zmove(BODY_HEIGHT * .5) difference() {
        cuboid([BODY_WIDTH, BODY_LENGTH, BODY_HEIGHT * .5], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
        cuboid([BODY_WIDTH - 2 * WALL_THICKNESS , BODY_LENGTH - 2 * WALL_THICKNESS, BODY_HEIGHT * .5 - WALL_THICKNESS], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);

        zmove(BODY_HEIGHT / 2) {
            zcyl(d=SCREW_HEAD_OUTER_DIAMETER + 1, h=SCREW_HEAD_THICKNESS + 0.2, align=V_DOWN, $fn=FN);
            zcyl(d=SCREW_HEAD_INNER_DIAMETER + 0.25, h=3 * SCREW_HEAD_THICKNESS, align=V_DOWN, $fn=FN);
        }
    }

    //zrot(0) zmove(BODY_HEIGHT) screw_support_and_mug_rails();

    zmove(BODY_HEIGHT) lifting_screw();
}


module square_nut() {
    cuboid([2 + 0.2, 5.5 + 0.2, 5.5 + 0.2]);
}



module wheel() {
    difference() {
        color("black") xcyl(d=12, h=WHEEL_THICKNESS, $fn=FN);
        color("black") xcyl(d=3.5, h=WHEEL_THICKNESS, $fn=FN);
    }
}

module wheel_axis() {
    #xmove(WHEEL_THICKNESS / 2) xcyl(d=5.5, h=2, align=V_RIGHT, $fn=FN);
    %xmove(WHEEL_THICKNESS / 2) xcyl(d=3.0, h=12, align=V_LEFT, $fn=FN);
}

module wheelhouse() {
    yrot(-90) slot(p1=[0, 0, 0], p2=[2.5, -5.5, 0], h=WHEEL_THICKNESS + 1, d1=12 + 2 * RADIAL_SLACK, d2=12 + 2 * RADIAL_SLACK, $fn=FN);
}


module wheel_unit() {
    height = BODY_HEIGHT / 2;

    color("gray") difference() {
        cuboid([WHEEL_THICKNESS + 2 * WHEEL_AXIAL_TOLERANCE + 2 * 2, 20, height], align=V_UP);
        zmove(WHEEL_DIAMETER / 2 - 2) {
            xcyl(d=WHEEL_DIAMETER + 2 * WHEEL_RADIAL_TOLERANCE, h=WHEEL_THICKNESS + 2 * WHEEL_AXIAL_TOLERANCE, $fn=FN);
            cuboid([WHEEL_THICKNESS + 2 * WHEEL_AXIAL_TOLERANCE, WHEEL_DIAMETER + 2 * WHEEL_RADIAL_TOLERANCE, height - WHEEL_DIAMETER / 2 + 2], align=V_UP);
            xcyl(d=3.0 + 0.2, h=WHEEL_THICKNESS + 2 * WHEEL_AXIAL_TOLERANCE + 2 * 2, $fn=FN);
        }
    }
    zmove(WHEEL_DIAMETER / 2 - 2) wheel();
}

module lower_body() {
    difference() {
        union() {
            color("gray") cuboid([BODY_WIDTH - width_margin, BODY_LENGTH - length_margin, BODY_HEIGHT * .5], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
            color("gray") cuboid([BODY_WIDTH, BODY_LENGTH, WALL_THICKNESS / 3], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
        }
        //zmove(WALL_THICKNESS / 3) color("gray") cuboid([BODY_WIDTH - 2.0 * SKIN_WIDTH_MARGIN, BODY_LENGTH - 2.0 * SKIN_LENGTH_MARGIN, BODY_HEIGHT * .5 - WALL_THICKNESS / 3], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
        zmove(WALL_THICKNESS / 3) color("gray") cuboid([BODY_WIDTH - 2.0 * SKIN_WIDTH_MARGIN, BODY_LENGTH - 2.0 * SKIN_LENGTH_MARGIN, BODY_HEIGHT * .5 - WALL_THICKNESS / 3], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
        //zmove(4.0) xflip_copy(31) yflip_copy(offset=29) wheelhouse();
        yflip_copy(offset=25) xflip_copy(offset=31 + TOLERANCE / 4) cuboid([WHEEL_THICKNESS + 2 * WHEEL_AXIAL_TOLERANCE + 2 * 2, 20, BODY_HEIGHT / 2], align=V_UP);
    }
    //xflip_copy(26) yflip_copy(offset=29) cuboid([4, 20, 14], align=V_UP);
    yflip_copy(offset=25) xflip_copy(offset=31 + TOLERANCE / 4) wheel_unit();

    lifting_nut();
}


module body() {
    top_plate();
    upper_body();
    lower_body();
}


module assembly() {
    body();
    zmove(17) skin();
}


assembly();
//wheel();
//wheel_unit();
//lifting_screw();
//lifting_nut();
//screw_support_and_mug_rails();
