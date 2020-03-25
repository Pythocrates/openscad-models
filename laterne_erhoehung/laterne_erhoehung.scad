// This is an adapter for the outdoor lantern.

module _norm_tongue(tolerance=0) {
    corners = [[0, 2 - tolerance], [0, -2 - tolerance], [4 - tolerance, -3 - tolerance], [4 - tolerance, 3 - tolerance]];
    linear_extrude(height=5)
        polygon( corners, paths=[[0, 1, 2, 3]]);
}

module tongue(x, y, theta, tolerance=0) {
    translate([x, y, 0])
        rotate([0, 0, theta])
            _norm_tongue(tolerance=tolerance);
}

outer_size = 195 + 2 * 15;
corner_size = 20;
corner_height = 8;
nub_radius = 5 / 2;
edge_length = outer_size - 2 * corner_size;
edge_width = 10;
edge_height = 5;

//base size
%translate([0, 0, -1 / 2]) square([outer_size, outer_size], center=true);

module edge() {
    translate([0, 0, corner_height / 2]) cube([20, edge_width, corner_height], center=true);
    difference() {
        translate([0, 0, edge_height / 2]) cube([edge_length, edge_width, edge_height], center=true);
        tongue(edge_length / 2, 0, 180);
        tongue(-edge_length / 2, 0, 0);
    }
}

module corner() {
    cube([corner_size, corner_size, corner_height]);
    translate([nub_radius, nub_radius, 0]) cylinder(r=nub_radius, h=18, $fn=30);
    tongue(0, corner_size / 2 + nub_radius, 180);
    tongue(corner_size / 2 + nub_radius, 0, -90);
}

for (angle = [0:90:270]) {
    rotate([0, 0, angle]) {
        translate([edge_length / 2, edge_length / 2, 0]) corner();
        translate([0, edge_length / 2 + corner_size / 2 + nub_radius, 0]) edge();
    }
}
