module long_hole(position) {
    translate(position + [0, 2, 4]) cylinder(r=2.5, h=8, $fn=20, center=true);
    translate(position + [0, -2, 4]) cylinder(r=2.5, h=8, $fn=20, center=true);
    translate(position + [0, 0, 4]) cube([5, 4, 8], center=true);
}

module half_plate(size) {
    difference() {
        translate([0, -size[1] / 2, 0]) cube (size);
        translate([16, -7.5, 1]) cube ([48, 15, 5]);
        long_hole([68.25 + 2.5, 0, 0]);
        long_hole([0, 0, 0]);

    }
    translate([15, 0, 7]) rotate([0, -15, 0]) cube([1, 5, 2], center=true);
    // thickening
    translate([16 + (48 - 40) / 2, -7.5, 0]) cube([40, 1, size[2]]);
    translate([16 + (48 - 40) / 2, 5.5, 0]) cube([40, 2, size[2]]);
}

module full_plate(size) {
    half_plate([size[0] / 2, size[1], size[2]]);
    mirror([1, 0 ,0]) {
        half_plate([size[0] / 2, size[1], size[2]]);
    }
}

full_plate([150, 18, 6]);
