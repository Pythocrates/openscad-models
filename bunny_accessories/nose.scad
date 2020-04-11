// A nose for a bunny.

difference() {
    sphere(r=10, $fn=120);
    translate([0, 0, -5]) cube([20, 20, 10], center=true);
}

translate([0, 0, 1]) for (i=[-1:1]) {
    rotate([0, 0, i * 7]) {
        cube([200, 4, 2], center=true);
        translate([-100, 0, 0]) cylinder(r=2, h=2, center=true, $fn=120);
    }
}
