difference() {
    cube([67 + 2 * 2, 112 + 2 * 2, 24 + 2 * 2], center=true);
    cube([67, 112, 24], center=true);

    translate([4, 0, 0]) cube([67, 112, 24], center=true);
    translate([-4, 0, 0]) cube([67, 112 - 2 * 4, 24 - 2 * 4], center=true);
    translate([0, -4, 0]) cube([67 - 2 * 4, 112, 24 - 2 * 4], center=true);
    translate([0, 0, 4]) cube([67 - 2 * 4, 112 - 2 * 4, 24], center=true);

}
translate([67 / 2 + 1, 0, 24 / 2]) cube([2, 10, 2], center=true);
translate([67 / 2 + 1, -112 / 4, -24 / 2]) cube([2, 10, 2], center=true);
translate([67 / 2 + 1, 112 / 4, -24 / 2]) cube([2, 10, 2], center=true);

translate([0, -25, 24 / 2 + 1]) rotate([0, 0, 40]) cube([60 * sqrt(2), 4, 2], center=true);
translate([0, 25, 24 / 2 + 1]) rotate([0, 0, -40]) cube([60 * sqrt(2), 4, 2], center=true);
