// These are laptop elevation clamps for a Lenovo Thinkpad X1 laptop.

module stand() {
    difference() {
        union() {
            cube([15, 20, 13]);
            difference() {
                translate([0, 10, 0]) rotate([0, 90, 0]) cylinder(r=10, h=15, $fn=60);
                translate([0, 10, 0]) rotate([0, 90, 0]) cylinder(r=9, h=15, $fn=60);
            }
        }

        translate([1, 0, 2]) cube([14, 20, 9.5]);
        translate([2.5, 0, 1]) cube([12.5, 20, 10.5]);

        // ventilation holes
        translate([0, 1.5, 2]) cube([1, 7.5, 9]);
        translate([0, 11, 2]) cube([1, 7.5, 9]);

    }
}

translate([0, 1, 0]) stand();
translate([0, -1, 0]) mirror([0, 1, 0]) stand();
