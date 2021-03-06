use <lock_plate.iscad>;

difference() {
    full_plate([150, 18, 6], offset=16, cavity=[48, 15, 5], thickenings=[1, 1]);
    translate([16, -2.5, 1]) cube([48, 10, 5]);
    translate([-9, 0, 5.5]) rotate([0, 0, 90]) linear_extrude(height = 0.5) text("Sc", size=8, halign="center", valign="center");
}

