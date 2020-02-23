// A personalized beer coaster.

module nut(xdir, ydir) {
    let (dist = 35)
    translate(dist * [xdir, ydir, 1 / dist]) {
        scale([0.2, 0.2, 0.2]) mirror([0, 1, 0]) import("/home/mkrzykaw/Downloads/3d_models/Zirbelnuss/files/finial_cds_q0.9.stl");
    }
}

module hop(xdir, ydir) {
    translate([18 * xdir, 34.6 * ydir, -6.75]) {
        scale([0.3, 0.3, 1]) mirror([0, 1, 0]) translate([-12, 12, 0]) import("/home/mkrzykaw/Downloads/3d_models/Hop_Flower/files/hop_flower.stl");
    }
}

module styled_text(string, x, y) {
    translate([x, y, 0]) {
        linear_extrude(4, center=true) {
            text(string, font="Liberation Sans:style=Bold Italic", size=15);
        }
    }
}

module rounded_corner(xdir, ydir) {
    translate(36.5 * [xdir, ydir, 0]) cylinder(r=10, h=2, center=true);
}

module e_bar(x, y) {
    translate([x, y, -0.5]) rotate([0, 0, -7]) cube([1, 10, 1], center=true);
}

difference() {
    union() {
        for (xdir = [-1, 1]) for (ydir =  [-1, 1]) rounded_corner(xdir, ydir);
        cube([73, 93, 2], center=true);
        cube([93, 73, 2], center=true);
    }
    union() {
        styled_text("Wernis", -40, 4);
        styled_text("Weizen", -30, -18);
        for (xdir = [-1:1]) for (ydir = [-1, 1]) hop(xdir, ydir);
    }
}

e_bar(-15, 11);
e_bar(-4.8, -10);
e_bar(22.4, -10);

for (xdir = [-1, 1]) for (ydir = [-1, 1]) nut(xdir, ydir);
