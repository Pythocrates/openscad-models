module long_hole(position, radius, length, depth, fn) {
    translate(position + [0, length / 2, depth / 2]) cylinder(r=radius, h=depth, $fn=fn, center=true);
    translate(position + [0, -length / 2, depth / 2]) cylinder(r=radius, h=depth, $fn=fn, center=true);
    translate(position + [0, 0, depth / 2]) cube([2 * radius, length, depth], center=true);
}

module half_plate(size, cavity_size, offset, cavity, thickenings) {
    module default_long_hole(position) {
        long_hole(position=position, radius=2.5, length=4, depth=size[2], fn=20);
    }

    difference() {
        translate([0, -size[1] / 2, 0]) cube (size);
        translate([offset, -cavity[1] / 2, size[2] - cavity[2]]) cube (cavity);
        default_long_hole([size[0] - 4.25, 0, 0]);
        default_long_hole([0, 0, 0]);
    }
    translate([offset - 1, 0, size[2] + 1]) rotate([0, -15, 0]) cube([1, 5, 2], center=true);

    // thickening
    translate([offset + (cavity[0] - .8 * cavity[0]) / 2, -cavity[1] / 2, 0]) {
        cube([.8 * cavity[0], thickenings[0], size[2]]);
    }
    translate([offset + (cavity[0] - .8 * cavity[0]) / 2, cavity[1] / 2 - thickenings[1], 0]) {
        cube([.8 * cavity[0], thickenings[1], size[2]]);
    }
}

module full_plate(size, offset, cavity, thickenings) {
    half_plate([size[0] / 2, size[1], size[2]], offset=offset, cavity=cavity, thickenings=thickenings);
    mirror([1, 0 ,0]) {
        half_plate([size[0] / 2, size[1], size[2]], offset=offset, cavity=cavity, thickenings=thickenings);
    }
}

full_plate([150, 18, 6], offset=16, cavity=[48, 15, 5], thickenings=[1, 2]);
