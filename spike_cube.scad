// This is a cube with differently thick spikes for figuring out the best match.

cube([20, 20, 20], center=true);

cylinder(h=20, $fn=60, r=3.95 / 2);
translate([0, 0, 20]) sphere(r=3.95 / 2, $fn=60);

rotate([0, 90, 0]) {
    cylinder(h=20, $fn=60, r=3.9 / 2);
    translate([0, 0, 20]) sphere(r=3.9 / 2, $fn=60);
    translate([0, 4, 10]) sphere(r=1, $fn=60);
}
rotate([0, 90, 90]) {
    cylinder(h=20, $fn=60, r=3.85 / 2);
    translate([0, 0, 20]) sphere(r=3.85 / 2, $fn=60);
    translate([0, 4, 10]) sphere(r=1, $fn=60);
    translate([4, 0, 10]) sphere(r=1, $fn=60);
}
rotate([90, 90, 0]) {
    cylinder(h=20, $fn=60, r=3.8 / 2);
    translate([0, 0, 20]) sphere(r=3.8 / 2, $fn=60);
    translate([4, 0, 10]) sphere(r=1, $fn=60);
    translate([0, 4, 10]) sphere(r=1, $fn=60);
    translate([4, 4, 10]) sphere(r=1, $fn=60);
}
rotate([0, -90, 0]) {
    cylinder(h=20, $fn=60, r=3.75 / 2);
    translate([0, 0, 20]) sphere(r=3.75 / 2, $fn=60);
    translate([4, 4, 10]) sphere(r=1, $fn=60);
    translate([-4, 4, 10]) sphere(r=1, $fn=60);
    translate([-4, -4, 10]) sphere(r=1, $fn=60);
    translate([4, -4, 10]) sphere(r=1, $fn=60);
}
rotate([-180, 0, 90]) {
    cylinder(h=20, $fn=60, r=3.7 / 2);
    translate([0, 0, 20]) sphere(r=3.7 / 2, $fn=60);
    translate([0, 4, 10]) sphere(r=1, $fn=60);
    translate([-4, 0, 10]) sphere(r=1, $fn=60);
    translate([0, -4, 10]) sphere(r=1, $fn=60);
    translate([4, 0, 10]) sphere(r=1, $fn=60);
}
