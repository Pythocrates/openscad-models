use <lock_plate.iscad>;

difference() {
    full_plate([150, 18, 6], offset=16, cavity=[48, 15, 5], thickenings=[2, 2.5]);
    translate([16, -2.5, 1]) cube([48, 10, 5]);
    translate([-16 - 48, -7.5, 1]) cube([48, 10, 5]);
    translate([-9, 0, 5.5]) rotate([0, 0, 90]) linear_extrude(height = 0.5) text("B", size=8, halign="center", valign="center");
}

