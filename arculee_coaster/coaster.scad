// An arculee shaped beer coaster.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>
use <BOSL/metric_screws.scad>

include <omdl/math/bitwise.scad>

include <./constants.scad>


module lifting_screw() {
    // Lifting mechanism
    if (bitwise_is_equal(VISIBILITY_MASK, SCREW)) {
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
    if (bitwise_is_equal(VISIBILITY_MASK, PLATE_DEPRESSOR)) {
        color("black") zmove(0.5) zrot(90) {
            slot(d=11, h=1, l=72, $fn=FN);
            prismoid([45, 1], [30, 1], 15, orient=-ORIENT_Y);
        }
    }
}


module top_plate() {
    if (bitwise_is_equal(VISIBILITY_MASK, TOP_PLATE)) {
        // Mug shape
        difference() {
            color("red") cuboid([SKIN_WIDTH - 2 * SKIN_WIDTH_MARGIN, MUG_DIAMETER + 4, WALL_THICKNESS], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);  // lid
            zcyl(d=SCREW_HEAD_OUTER_DIAMETER - 4, h=WALL_THICKNESS, align=V_UP, $fn=FN);
        }
        zmove(WALL_THICKNESS) color("orange") intersection() {
            //cuboid([SCREW_HEAD_OUTER_DIAMETER + 6, MUG_DIAMETER + 4.6, WALL_THICKNESS + 6], align=V_UP);
            difference() {
                zcyl(d=MUG_DIAMETER + 4, h=WALL_THICKNESS + 6, align=V_UP, $fn=FN);
                zcyl(d=MUG_DIAMETER + 0.5, h=WALL_THICKNESS + 6, align=V_UP, $fn=FN);
            }
            zmove(-30 + WALL_THICKNESS) ycyl(h=MUG_DIAMETER + 8, d=70, $fn=FN);
        }
    }

    zmove(WALL_THICKNESS) xflip_copy(offset=30) plate_depressor();
}


module XXXscrew_support_and_mug_rails() {
    color("gray") difference() {
        cuboid([SCREW_HEAD_OUTER_DIAMETER + 6, MUG_DIAMETER + 12, 3 * SCREW_HEAD_THICKNESS], align=V_DOWN);
        zcyl(d=SCREW_HEAD_OUTER_DIAMETER + 1, h=SCREW_HEAD_THICKNESS + 0.2, align=V_DOWN, $fn=FN);
        zcyl(d=SCREW_HEAD_INNER_DIAMETER + 0.25, h=3 * SCREW_HEAD_THICKNESS, align=V_DOWN, $fn=FN);
    }
}


module lifting_nut() {
    if (bitwise_is_equal(VISIBILITY_MASK, NUT)) {
        // Lifting mechanism.
        metric_nut(size=17, hole=true, pitch=4.4, flange=5, details=true, $fn=FN);
    }
}


module square_nut_shape_horizontal() {
    cuboid([5.5 + 0.2, 5.5 + 0.2, 2 + 0.0], align=V_DOWN);
}


module square_nut_shape() {
    cuboid([2 + 0.0, 5.5 + 0.2, 5.5 + 0.2], align=V_LEFT);
}


module rounded_corner(xdir, ydir) {
    x_offset = SKIN_WIDTH / 2 - VERTICAL_EDGE_RADIUS;
    y_offset = SKIN_LENGTH / 2 - VERTICAL_EDGE_RADIUS;

    translate([xdir * x_offset, ydir * y_offset, 0])
        cyl(r=VERTICAL_EDGE_RADIUS, h=SKIN_HEIGHT, fillet2=TOP_FILLET_RADIUS, align=V_UP, $fn=FN);
}


module skin() {
    if (bitwise_is_equal(VISIBILITY_MASK, SKIN)) {
        difference() {
            union() {
                for (xdir = [-1, 1]) for (ydir =  [-1, 1]) rounded_corner(xdir, ydir);
                cuboid([SKIN_WIDTH, SKIN_LENGTH - 2 * VERTICAL_EDGE_RADIUS, SKIN_HEIGHT], align=V_UP, fillet=TOP_FILLET_RADIUS, edges=EDGE_TOP_LF + EDGE_TOP_RT, $fn=FN);
                cuboid([SKIN_WIDTH - 2 * VERTICAL_EDGE_RADIUS, SKIN_LENGTH, SKIN_HEIGHT], align=V_UP, fillet=TOP_FILLET_RADIUS, edges=EDGE_TOP_FR + EDGE_TOP_BK, $fn=FN);
            }
            //#zmove(10) cuboid([SKIN_WIDTH - 2 * SKIN_WIDTH_MARGIN, SKIN_LENGTH - 2 * SKIN_LENGTH_MARGIN, SKIN_HEIGHT], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
            zmove(10) cuboid([SKIN_WIDTH - 2 * SKIN_WIDTH_MARGIN + TOLERANCE, MUG_DIAMETER + 4 + TOLERANCE, SKIN_HEIGHT], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
            cuboid([SKIN_WIDTH - 2 * WALL_THICKNESS, SKIN_LENGTH - 2 * WALL_THICKNESS, SKIN_HEIGHT - WALL_THICKNESS], align=V_UP);
        }
    }
}


module upper_body_main_part() {
    if (bitwise_is_equal(VISIBILITY_MASK, UPPER_BODY)) {
        color("gray") difference() {
            cuboid([BODY_WIDTH, BODY_LENGTH, BODY_HEIGHT * .5], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
            cuboid([BODY_WIDTH - 2 * WALL_THICKNESS , BODY_LENGTH - 2 * WALL_THICKNESS, BODY_HEIGHT * .5 - WALL_THICKNESS], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);

            zmove(BODY_HEIGHT / 2) {
                zcyl(d=SCREW_HEAD_OUTER_DIAMETER + 1, h=SCREW_HEAD_THICKNESS + TOLERANCE, align=V_DOWN, $fn=FN);
                zcyl(d=SCREW_HEAD_INNER_DIAMETER + 0.25, h=3 * SCREW_HEAD_THICKNESS, align=V_DOWN, $fn=FN);
            }
        }
        /* difference() { */
        /*     zmove(BODY_HEIGHT * 0.5 - 6) grid2d(spacing=[62.3, 70], cols=2, rows=2) cuboid([8, 10, 4]); */
        /*     zmove(BODY_HEIGHT * 0.5 - 4) grid2d(spacing=[60, 70], cols=2, rows=2) square_nut_shape_horizontal(); */
        /* } */
    }
}


module upper_body() {
    difference() {
        union() {
            upper_body_main_part();
            zmove(BODY_HEIGHT * 0.5) top_plate();
            zmove(BODY_HEIGHT * 0.5) lifting_screw();
        }
        zmove(BODY_HEIGHT * 0.5 + 4.75) grid2d(spacing=[60, 70], cols=2, rows=2) top_screw();
    }
}


module square_nut() {
    difference() {
        square_nut_shape();
        xcyl(d=3, h=2 + 0.0, align=V_LEFT, $fn=FN);
    }
}


module wheel() {
    if (bitwise_is_equal(VISIBILITY_MASK, WHEEL)) {
        difference() {
            color("black") xcyl(d=12, h=WHEEL_THICKNESS, $fn=FN);
            color("black") xcyl(d=3.5, h=WHEEL_THICKNESS, $fn=FN);
        }
    }
}


module top_screw() {
    //#xmove(WHEEL_THICKNESS / 2) xcyl(d=5.5, h=2, align=V_RIGHT, $fn=FN);
    //%xmove(WHEEL_THICKNESS / 2) xcyl(d=3.0, h=12, align=V_LEFT, $fn=FN);
    zcyl(d=5.5, h=2, align=V_UP, $fn=FN);
    zcyl(d=3.0, h=14, align=V_DOWN, $fn=FN);
}


module wheelhouse() {
    yrot(-90) slot(p1=[0, 0, 0], p2=[2.5, -5.5, 0], h=WHEEL_THICKNESS + 1, d1=12 + 2 * RADIAL_SLACK, d2=12 + 2 * RADIAL_SLACK, $fn=FN);
}


module wheel_unit() {
    height = BODY_HEIGHT / 2;
    height = 7;

    if (bitwise_is_equal(VISIBILITY_MASK, WHEEL_UNIT)) {
        color("gray") {
            difference() {
                union() {
                difference() {
                    cuboid([WHEEL_THICKNESS + 2 * WHEEL_AXIAL_TOLERANCE + 2 * 2, 20, height], align=V_UP);
                    zmove(WHEEL_DIAMETER / 2 - 2) {
                        xcyl(d=WHEEL_DIAMETER + 2 * WHEEL_RADIAL_TOLERANCE, h=WHEEL_THICKNESS + 2 * WHEEL_AXIAL_TOLERANCE, $fn=FN);
                        cuboid([WHEEL_THICKNESS + 2 * WHEEL_AXIAL_TOLERANCE, WHEEL_DIAMETER + 2 * WHEEL_RADIAL_TOLERANCE, height - WHEEL_DIAMETER / 2 + 2], align=V_UP);
                    }
                }
                difference() {
                    xmove(-(WHEEL_THICKNESS / 2 + WHEEL_AXIAL_TOLERANCE + (2 + 0.2 + 2 * 2) / 2)) cuboid([2 + 0.2 + 2 * 2, 20, height], align=V_UP);
                    move([-(WHEEL_THICKNESS / 2 + WHEEL_AXIAL_TOLERANCE + 2), 0, WHEEL_DIAMETER / 2 - 2]) color("red") {
                        square_nut_shape();
                        zmove(5) square_nut_shape();
                    }
                }
                %move([-(WHEEL_THICKNESS / 2 + WHEEL_AXIAL_TOLERANCE + 2), 0, WHEEL_DIAMETER / 2 - 2]) color("red") {
                    #square_nut();
                }
                }
                zmove(WHEEL_DIAMETER / 2 - 2) {
                    xcyl(d=3.0 + 0.2, h=WHEEL_THICKNESS + 2 * WHEEL_AXIAL_TOLERANCE + 2 * 2 + 10, $fn=FN);
                }
            }
        }
    }

    zmove(WHEEL_DIAMETER / 2 - 2) wheel();
}


module lower_body() {
    if (bitwise_is_equal(VISIBILITY_MASK, LOWER_BODY)) {
        difference() {
            union() {
                color("gray") cuboid([BODY_WIDTH - width_margin, BODY_LENGTH - length_margin, BODY_HEIGHT * .5], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
                color("gray") cuboid([BODY_WIDTH, BODY_LENGTH, WALL_THICKNESS / 3], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
            }
            zcyl(d=17, h=WALL_THICKNESS, align=V_UP, $fn=FN);
            zmove(WALL_THICKNESS / 3) color("gray") cuboid([BODY_WIDTH - 2.0 * SKIN_WIDTH_MARGIN, BODY_LENGTH - 2.0 * SKIN_LENGTH_MARGIN, BODY_HEIGHT * .5 - WALL_THICKNESS / 3], align=V_UP, fillet=VERTICAL_EDGE_RADIUS, edges=EDGES_Z_ALL, $fn=FN);
            yflip_copy(offset=25) xflip_copy(offset=31 + TOLERANCE / 4 + 0.5) zmove(WHEEL_DIAMETER / 2 - 2) {
                xcyl(d=WHEEL_DIAMETER + 2 * WHEEL_RADIAL_TOLERANCE, h=WHEEL_THICKNESS + 2 * WHEEL_AXIAL_TOLERANCE, $fn=FN);
                xcyl(d=3.0 + 0.2, h=WHEEL_THICKNESS + 2 * WHEEL_AXIAL_TOLERANCE + 2 * 2, $fn=FN);
            }
        }
    }
    yflip_copy(offset=25) xflip_copy(offset=31 + TOLERANCE / 4 + 0.5) wheel_unit();

    lifting_nut();
}


module body() {
    zmove(BODY_HEIGHT * .5) upper_body();
    lower_body();
}


module assembly() {
    body();
    zmove(17) skin();
}


intersection() {
    assembly();
    //#move([30, 30, 0])cuboid([30, 35, 30], align=V_UP);
}
