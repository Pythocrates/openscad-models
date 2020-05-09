// This is yet another battery dispenser inspired by some other models.
// Goals:
//  - modular/stackable
//  - parametric: different batteries, different heights
//  - as tight as possible, good guidance for batteries

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 60;

INNER_DEPTH = 42;
WEDGE_HEIGHT = 4;
HULL_THICKNESS = 2;
RIM_THICKNESS = 3;
RIM_HEIGHT = 7;
DISPENSING_AREA_DEPTH = 15;
DISPENSING_AREA_HEIGHT = 2;


function calc_level_height(battery_radius) = 4 / 3 * battery_radius;

module _axes() {
    color("red") xcyl(r=1, h=20);
    color("green") ycyl(r=1, h=20);
    color("blue") zcyl(r=1, h=20);
}

module wedge(width, length, height) {
    zrot(180, cp=[width / 2, 0, 0]) right_triangle([width, length, height], orient=ORIENT_X, align=V_BACK + V_UP + V_RIGHT);
}

module one_level_long_wedge_module_with_side(battery_dims, punch_holes=false) {
    inner_width = battery_dims[1] + 1.5;
    battery_radius_gap = battery_dims[0] + 0.5;
    level_height = calc_level_height(battery_radius=battery_dims[0]);

    xmove(-inner_width / 2) wedge_side(level_height=level_height);

    for (is_top=[0:1]) {
        mirror([0, is_top, 0]) {
            translate([-inner_width / 2, INNER_DEPTH / 2, level_height * is_top]) {
                mirror([0, 0, is_top]) {
                    wedge(width=inner_width, length=INNER_DEPTH - battery_radius_gap, height=WEDGE_HEIGHT);
                    fillet2 = punch_holes ? 0 : 0.5;
                    place_copies([[inner_width + HULL_THICKNESS / 2, -2, WEDGE_HEIGHT / 2], [inner_width + HULL_THICKNESS / 2, -11, WEDGE_HEIGHT * 5 / 16]])
                        cyl(l=HULL_THICKNESS, d=2.5, fillet2=fillet2, orient=ORIENT_X, $fn=FN);
                }
            }
        }
    }
}

module multi_level_long_wedge_module_with_side(battery_dims, levels, with_hull=false) {
    outer_depth = battery_dims[1] + 1.5 + 2 * HULL_THICKNESS;
    level_height = calc_level_height(battery_radius=battery_dims[0]);

    for (level = [1:levels]) {
        zmove((level - 0.5) * level_height) mirror([0, 0, level % 2]) zmove(-level_height / 2)
            one_level_long_wedge_module_with_side(battery_dims=battery_dims);
    }

    if (with_hull) {
        translate([0, (INNER_DEPTH + HULL_THICKNESS) / 2, level_height * (0.5 + (levels / 2))])
            cube([outer_depth, 2, (levels - 1) * level_height], center=true);
        translate([0, -(INNER_DEPTH + HULL_THICKNESS) / 2, level_height * (levels / 2)])
            cube([outer_depth, 2, levels * level_height], center=true);
    }
}

module wedge_side(level_height, align=V_UP + V_LEFT) {
    size = [2, INNER_DEPTH, level_height];
    orient_and_align(size=size, align=align) cube(size, center=true);
}

module opposite_wedge_side(battery_dims) {
    inner_width = battery_dims[1] + 1.5;
    level_height = calc_level_height(battery_radius=battery_dims[0]);

    difference() {
        xmove(-inner_width / 2) wedge_side(level_height=level_height);
        xmove(-inner_width - HULL_THICKNESS) one_level_long_wedge_module_with_side(battery_dims=battery_dims, punch_holes=true);
    }
}

module multi_opposite_wedge_side(battery_dims, levels) {
    inner_width = battery_dims[1] + 1.5;
    level_height = calc_level_height(battery_radius=battery_dims[0]);

    for (level = [1:levels]) {
        translate([inner_width + HULL_THICKNESS, 0, (level - 0.5) * level_height])
            mirror([0, 0, level % 2]) zmove(-level_height / 2) opposite_wedge_side(battery_dims=battery_dims);
    }
}

module integrated_simple_base(battery_dims, levels) {
    inner_width = battery_dims[1] + 1.5;
    inner_tolerance = 0.05;

    base_width = inner_width +  2 * (HULL_THICKNESS + RIM_THICKNESS);

    translate([0, 5.5, 6]) {
        difference() {
            cuboid(
                [base_width, INNER_DEPTH + 2 * (RIM_THICKNESS) + DISPENSING_AREA_DEPTH, RIM_HEIGHT],
                fillet=5, edges=EDGE_FR_RT + EDGE_FR_LF + EDGE_BK_LF + EDGE_BK_RT,
                align=V_DOWN, $fn=FN);
            cuboid(
                [inner_width +  2 * (HULL_THICKNESS + inner_tolerance), INNER_DEPTH + inner_tolerance + DISPENSING_AREA_DEPTH, RIM_HEIGHT - DISPENSING_AREA_HEIGHT],
                fillet=0, edges=EDGE_FR_RT + EDGE_FR_LF + EDGE_BK_LF + EDGE_BK_RT,
                align=V_DOWN, $fn=FN);
            ymove(22.0) cuboid(
                [base_width, 13, 5],
                fillet=2, edges=EDGE_BOT_FR + EDGE_BOT_BK,
                align=V_DOWN, $fn=FN);
            ymove(30) cuboid(
                [25, RIM_THICKNESS, RIM_HEIGHT - DISPENSING_AREA_HEIGHT],
                fillet=1 , edges=EDGE_BOT_RT + EDGE_BOT_LF,
                align=V_DOWN, $fn=FN);
        }
    }

    translate([0, -1, 1.5]) difference() {
        cube([inner_width + 2 * HULL_THICKNESS, INNER_DEPTH + HULL_THICKNESS, 1], center=true);
        translate([0, 16.5, 0]) cube([inner_width, 11, 1], center=true);
    }
}

LEVELS = 2;

module parts(battery_dims, levels, with_hull) {
    multi_level_long_wedge_module_with_side(battery_dims=battery_dims, levels=levels, with_hull=with_hull);
    translate([20, 0, 0]) multi_opposite_wedge_side(battery_dims=battery_dims, levels=levels);
    translate([0, 60, 0]) integrated_simple_base(battery_dims=battery_dims, levels=levels);
}

module assembly(battery_dims, levels, with_hull) {
    zmove(1) {
        multi_level_long_wedge_module_with_side(battery_dims=battery_dims, levels=levels, with_hull=with_hull);
        multi_opposite_wedge_side(battery_dims=battery_dims, levels=levels);
    }
    integrated_simple_base(battery_dims=battery_dims, levels=levels);
}


aaa_dims = [10.5, 44.5];
aa_dims = [14.5, 50.5];

parts(battery_dims=aaa_dims, levels=LEVELS, with_hull=true);
//assembly(battery_dims=aaa_dims, levels=LEVELS, with_hull=true);

// battery dummies
%translate([0, 0, 6.5]) xcyl(d=10.5, h=44.5, center=true, $fn=180);
%translate([0, 15.5, 6.5]) xcyl(d=10.5, h=44.5, center=true, $fn=180);
