// This is yet another battery dispenser inspired by some other models.
// Goals:
//  - modular/stackable
//  - parametric: different batteries, different heights
//  - as tight as possible, good guidance for batteries

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 60;

width = 51.5; 
depth = 46.5;
height = 64.5;

thickness_bottom = 3;

width_i = 46; 
depth_i = 42;
height_i = height - thickness_bottom;

level_height = 14;


module wedge() {
    rotate([90, 0, 90]) {
        linear_extrude(height=46, center=false, convexity=10) {
            polygon(points=[[-31, 0], [0, 0], [0, 4]]);
        }
    }
}


module one_level_long_wedge_module_with_side(punch_holes=false) {
    wedge_side(level_height);

    for (is_top=[0:1]) {
        mirror([0, is_top, 0]) {
            translate([-width_i / 2, depth_i / 2, level_height * is_top]) {
                mirror([0, 0, is_top]) {
                    wedge();
                    fillet2 = punch_holes ? 0 : 0.5;
                    translate([47, -2, 2.0]) cyl(l=2, d=2.5, fillet2=fillet2, orient=ORIENT_X, $fn=FN);
                    translate([47, -11, 1.25]) cyl(l=2, d=2.5, fillet2=fillet2, orient=ORIENT_X, $fn=FN);
                }
            }
        }
    }
}


module multi_level_long_wedge_module_with_side(levels, with_hull=false) {

    for (level = [1:levels]) {
        translate([0, 0, (level - 0.5) * level_height]) mirror([0, 0, level % 2]) translate([0, 0, -level_height / 2]) one_level_long_wedge_module_with_side();
    }

    if (with_hull) {
        translate([0, 22, level_height * (0.5 + (levels / 2))]) cube([50, 2, (levels - 1) * level_height], center=true);
        translate([0, -22, level_height * (levels / 2)]) cube([50, 2, levels * level_height], center=true);
    }
}

module wedge_side(level_height) {
    translate([-24, 0, level_height / 2]) cube([2, 42, level_height], center=true);
}

module opposite_wedge_side(level_height) {
    difference() {
        wedge_side(level_height);
        translate([-48, 0, 0]) one_level_long_wedge_module_with_side(punch_holes=true);
    }
}

module multi_opposite_wedge_side(level_height, levels) {
    for (level = [1:levels]) {
        translate([48, 0, (level - 0.5) * level_height])
            mirror([0, 0, level % 2]) translate([0, 0, -level_height / 2]) opposite_wedge_side(level_height=level_height);
    }
}

module multi_level_hull(levels, level_height) {
    hull_thickness = 3;

    difference() {
        cuboid([46 +  2 * (2 + hull_thickness), 42 + 2 * (hull_thickness), levels * level_height], fillet=5, edges=EDGE_FR_RT + EDGE_FR_LF + EDGE_BK_LF + EDGE_BK_RT, $fn=FN);
        cuboid([46 +  2 * (2 + 0.05), 42 + 2 * (0 + 0.05), levels * level_height], fillet=0, edges=EDGE_FR_RT + EDGE_FR_LF + EDGE_BK_LF + EDGE_BK_RT, $fn=FN);
    }
}

module integrated_simple_base(levels) {
    hull_thickness = 3;

    translate([0, 5.5, 6]) {
        difference() {
            cuboid(
                [46 +  2 * (2 + hull_thickness), 42 + 2 * (hull_thickness) + 15, 7],
                align=V_DOWN,
                fillet=5,
                edges=EDGE_FR_RT + EDGE_FR_LF + EDGE_BK_LF + EDGE_BK_RT,
                $fn=FN);
            cuboid(
                [46 +  2 * (2 + 0.05), 42 + 0.05 + 15, 5],
                align=V_DOWN,
                fillet=0,
                edges=EDGE_FR_RT + EDGE_FR_LF + EDGE_BK_LF + EDGE_BK_RT,
                $fn=FN);
            translate([0, 22.0, 0]) cuboid(
                [60, 13, 5],
                align=V_DOWN,
                fillet=2,
                edges=EDGE_BOT_FR + EDGE_BOT_BK,
                $fn=FN);
            translate([0, 30, 0]) cuboid(
                [25, 3, 5],
                align=V_DOWN,
                fillet=1 ,
                edges=EDGE_BOT_RT + EDGE_BOT_LF,
                $fn=FN);
        }
    }

    translate([0, -1, 1.5]) difference() {
        cube([50, 44, 1], center=true);
        translate([0, 16.5, 0]) cube([46, 11, 1], center=true);
    }
}

//levels = 3;

module parts(levels, with_hull) {
    multi_level_long_wedge_module_with_side(levels=levels, with_hull=with_hull);
    translate([20, 0, 0]) multi_opposite_wedge_side(levels=levels, level_height=level_height);
    //translate([-60, 0, 0]) multi_level_hull(levels=levels, level_height=level_height);
    translate([0, 60, 0]) integrated_simple_base(levels=levels);
}

module assembly(levels, with_hull) {
    multi_level_long_wedge_module_with_side(levels=levels, with_hull=with_hull);
    multi_opposite_wedge_side(levels=levels, level_height=level_height);
    //translate([-60, 0, 0]) multi_level_hull(levels=levels, level_height=level_height);
    integrated_simple_base(levels=levels);
}


parts(levels=8, with_hull=true);

//assembly(levels=4, with_hull=true);

// battery dummies
%translate([0, 0, 6.5]) rotate([0, 90, 0]) cylinder(r=5, h=44.5, center=true, $fn=180);
%translate([0, 15.5, 6.5]) rotate([0, 90, 0]) cylinder(r=5, h=44.5, center=true, $fn=180);


