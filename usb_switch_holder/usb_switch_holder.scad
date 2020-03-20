module cage() {
    difference() {
        cube([69 + 2 * 2, 114 + 2 * 2, 25 + 2 * 2], center=true);
        cube([69, 114, 25], center=true);

        translate([4, 0, 0]) cube([69, 114, 25], center=true);
        translate([-4, 0, 0]) cube([69, 114 - 2 * 4, 25 - 2 * 4], center=true);
        translate([0, 4, 0]) cube([69 - 2 * 4, 114, 25 - 2 * 4], center=true);
        translate([0, -4, 0]) cube([69 - 2 * 4, 114, 25 - 2 * 4], center=true);
        translate([0, 0, 4]) cube([69 - 2 * 4, 114 - 2 * 4, 25], center=true);

    }
    translate([69 / 2 + 1, 0, 25 / 2]) cube([2, 10, 2], center=true);
    translate([69 / 2 + 1, -114 / 4, -25 / 2]) cube([2, 10, 2], center=true);
    translate([69 / 2 + 1, 114 / 4, -25 / 2]) cube([2, 10, 2], center=true);

    translate([0, -27, 25 / 2 + 1]) rotate([0, 0, 40]) cube([60 * sqrt(2), 4, 2], center=true);
    translate([0, 27, 25 / 2 + 1]) rotate([0, 0, -40]) cube([60 * sqrt(2), 4, 2], center=true);
}
