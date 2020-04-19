// This is a simple adapter between the pavilion frame and the metal hook.

TOL = 0.5;

module frame_clamp() {
    difference() {
        translate([0, 0, -1.5]) cube([10, 20 + 6, 20 + 6 + 3], center=true);
        translate([0, 0, -1.5])cube([10, 20 + TOL, 20 + 3 + TOL], center=true);
        translate([0, -10, 0]) cube([40, 20 + TOL, 16 - TOL], center=true);
    }
}

module u_shape(gap=10, radius=3) {
    translate([0, 0, 0]){
        difference() {
            cube([56, 20, 3], center=true);
            cube([gap, 20, 3], center=true);
        }
    }
    translate([25, -20 / 2, -4.5]) cube([3, 20, 3]);
    translate([-25 - 3, -20 / 2, -4.5]) cube([3, 20, 3]);
    translate([0, 0, -1.5]) rotate([-90, 0, 0]) rotate_extrude(angle=180, $fn=60) {
        translate([gap / 2 + radius, 0]) circle(r=radius, $fn=60);
    }
}

module assembly(width=40) {
    %cube([100, 20, 20], center=true);
    translate([-width / 2, 0, 0]) frame_clamp();
    translate([width / 2, 0, 0]) frame_clamp();
    translate([0, 0, -10 - 1.5]) u_shape();
}

module parts() {
    translate([-20, 0, 5]) rotate([0, 90, 0]) frame_clamp();
    translate([20, 0, 5]) rotate([0, 90, 0]) frame_clamp();
    translate([0, -30, 1.5]) rotate([180, 0, 0]) u_shape();
}


//assembly();
parts();
