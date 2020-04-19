// The adapter between the hook and the hourglass flipper.


module clamp(tol=0) {
    rotate([90, 0, 0]) {
        translate([7.5, 0, 0]) {
            cylinder(r=2.5 + tol, h=15, $fn=60);
            translate([0, 0, 15]) sphere(r=2.5 + tol, $fn=60);
        }
        translate([-7.5, 0, 0]) {
            cylinder(r=2.5 + tol, h=15, $fn=60);
            translate([0, 0, 15]) sphere(r=2.5 + tol, $fn=60);
        }

        translate([0, 0, -1]) cube([24, 9, 2], center=true);
    }
}


module back_construction() {
    translate([0, 0, -31]) {
        difference() {
            cylinder(r=9, h=31, $fn=60);
            cylinder(r=7, h=31, $fn=60);
            translate([0, 9, 21 + 5 / 2]) clamp(tol=0.05);
        }
        translate([-10, -9 - 40 + 2, -3]) cube([20, 2, 31 + 3]);
        difference() {
            translate([-1, -40 - 9 + 4, 13]) cube([2, 36, 18]);
            translate([0, -27,13]) rotate([0, -90, 0]) cylinder(r=18, h=4, center=true, $fn=60);
        }
    }
}

module half_plate() {
    translate([0, -89, 0]) cube([25, 100, 2]);
}


module main() {
    half_plate();
    mirror([-1, 0, 0]) half_plate();
    back_construction();
}


clamp(tol=-0.05);
translate([-50, 0, 0]) main();
