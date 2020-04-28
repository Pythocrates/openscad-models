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

/*
module stack_module() {
    difference() {
        cuboid(
            [width, depth, height],
            fillet=5,
            edges=EDGE_FR_RT + EDGE_FR_LF + EDGE_BK_LF + EDGE_BK_RT + EDGE_BOT_FR,
            align=V_UP,
            $fn=24
        );
        up(thickness_bottom) cuboid([width_i, depth_i, height_i], align=V_UP);
        up(height - 40) {
            cuboid([25, depth, height_i], align=V_UP);
    }
    }
    }
*/


/*
rotate([90, 0, 0]) linear_extrude(height = 31, center = false, convexity = 10, scale=[1, 0.1])
    translate([0, 0, 0])  polygon(points=[[0, 3],[0, -5],[10, 1]]);
*/


module wedge() {
    rotate([90, 0, 90]) {
        linear_extrude(height=46, center = false, convexity = 10, scale=[1, 1]) {
            translate([0, 0, 0]) {
                polygon(points=[[-31, 0], [0, 0], [0, 4]]);
            }
        }
    }
}

module one_level_twin_wedge_module() {
    translate([24, 0, 7]) cube([2, 42, 14], center=true);
    translate([-24, 0, 7]) cube([2, 42, 14], center=true);

    for (is_top=[0:1])
        for (is_right=[0:1])
                mirror([is_right, 0, 0])
                    mirror([0, is_top, 0])
                        translate([-width_i / 2, depth_i / 2, level_height * is_top])
                            mirror([0, 0, is_top])
                                wedge();
}

module one_level_long_wedge_module_with_side(punch_holes=false) {
    //translate([24, 0, level_height / 2]) cube([2, 42, level_height], center=true);
    //translate([-24, 0, level_height / 2]) cube([2, 42, level_height], center=true);
    wedge_side(level_height);

    for (is_top=[0:1])
        for (is_right=[0:0])
            //mirror([is_right, 0, 0])
            mirror([0, is_top, 0])
                translate([-width_i / 2, depth_i / 2, level_height * is_top])
                    mirror([0, 0, is_top]) {
                        wedge();
                        //translate([47, -2, 2]) rotate([0, 90, 0]) cylinder(h=2, r=1.0, $fn=60, center=true);
                        //translate([47, -11, 1.25]) rotate([0, 90, 0]) cylinder(h=2, r=1.0, $fn=60, center=true);
                        if (punch_holes) {
                            translate([47, -2, 2.0]) cyl(l=2, d=2.5, orient=ORIENT_X, $fn=60);
                            translate([47, -11, 1.25]) cyl(l=2, d=2.5, orient=ORIENT_X, $fn=60);
                        } else {
                            translate([47, -2, 2.0]) cyl(l=2, d=2.5, fillet2=.5, orient=ORIENT_X, $fn=60);
                            translate([47, -11, 1.25]) cyl(l=2, d=2.5, fillet2=.5, orient=ORIENT_X, $fn=60);
                        }
                    }

    //translate([24, 19, 2]) rotate([0, 90, 0]) cylinder(h=2, r=0.5, $fn=60, center=true);
    //translate([24, 10, 1.25]) rotate([0, 90, 0]) cylinder(h=2, r=0.5, $fn=60, center=true);
}


module multi_level_long_wedge_module_with_side(levels) {
    for (level = [1:levels]) {
        translate([0, 0, level * level_height]) mirror([0, 0, level % 2]) translate([0, 0, -level_height / 2]) one_level_long_wedge_module_with_side();
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
        translate([70, 0, level * level_height])
            mirror([0, 0, level % 2]) translate([0, 0, -level_height / 2]) opposite_wedge_side(level_height=level_height);
    }
}

module multi_level_hull(levels, level_height) {
    hull_thickness = 3;

    difference() {
        cuboid([46 +  2 * (2 + hull_thickness), 42 + 2 * (hull_thickness), levels * level_height], fillet=5, edges=EDGE_FR_RT + EDGE_FR_LF + EDGE_BK_LF + EDGE_BK_RT, $fn=FN);
        cuboid([46 +  2 * (2 - 0.05), 42 + 2 * (0 - 0.05), levels * level_height], fillet=0, edges=EDGE_FR_RT + EDGE_FR_LF + EDGE_BK_LF + EDGE_BK_RT, $fn=FN);
    }
}

module one_level_hull_module() {
    level_height = 12;

    difference() {
        cuboid(
            [width, depth, level_height],
            fillet=5,
            edges=EDGE_FR_RT + EDGE_FR_LF + EDGE_BK_LF + EDGE_BK_RT,
            align=V_UP,
            $fn=24
        );
        cuboid([width_i, depth_i, height_i], align=V_UP);
        //cuboid([25, depth, height_i], align=V_UP);
    }
 
}


module wedge_stack() {
    for (i=[1:2])
        for (j=[0:1])
            for (k=[0:1])
                for (m=[0:1])
                    mirror([k, 0, 0])
                        mirror([0, j, 0])
                            translate([-width_i / 2, depth_i / 2, 24 * (i + j / 2)])
                                mirror([0, 0, m])
                                    wedge();
}

//stack_module();
//wedge_stack();

//stack_hull;
//one_level_hull_module();

//one_level_long_wedge_module_with_side();
//one_level_twin_wedge_module();
//translate([70, 0, 0]) opposite_wedge_side(level_height);

levels = 3;
multi_level_long_wedge_module_with_side(levels=levels);
multi_opposite_wedge_side(levels=levels, level_height=level_height);
//translate([-60, 0, 0]) multi_level_hull(levels=levels, level_height=level_height);
translate([-60, 0, 0]) multi_level_hull(levels=1, level_height=6);

// battery dummies
%translate([0, 0, 6.5]) rotate([0, 90, 0]) cylinder(r=5, h=44.5, center=true, $fn=180);
%translate([0, 15.5, 6.5]) rotate([0, 90, 0]) cylinder(r=5, h=44.5, center=true, $fn=180);


