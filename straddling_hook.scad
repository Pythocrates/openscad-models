translate([10, 0, -6])
union() {
rotate([90, 0, 0]) rotate_extrude(angle=-150, convexity=10, $fn=60)
    translate([8, 0, 0])
        circle(r = 2);

    translate([8, 0, 0]) sphere(r=3, $fn=60);
}
difference() {
    translate([2.5, 0, -10]) cube([5, 25, 30], center=true);
    rotate([0, 90, 0]) cylinder(h=12, r=1.5, center=true, $fn=60);
    translate([3.5, 0, 0]) rotate([0, 90, 0]) cylinder(h=3, r=2.75, center=true, $fn=60);

    translate([0, 0, -20]) rotate([0, 90, 0]) cylinder(h=12, r=1.5, center=true, $fn=60);
    translate([3.5, 0, -20]) rotate([0, 90, 0]) cylinder(h=3, r=2.75, center=true, $fn=60);
}

translate([0, 0, -10]) difference() {
    translate([-7.5, 0, 0]) cube([15, 7, 30], center=true);
    translate([-5, 0, 0])
        rotate([90, 0, -90])
            linear_extrude(height = 10, center = true, convexity = 10, scale=[0.2, 1])
                square([3, 30], center=true);

    translate([-12.5, 0, 0]) cube([5, 0.6, 30], center=true);
}
