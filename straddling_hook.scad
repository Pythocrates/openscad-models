translate([6, 0, -2])
rotate([90, 0, 0]) rotate_extrude(angle=-180, convexity=10, $fn=60)
    translate([4, 0, 0])
        circle(r = 2);

translate([10, 0, -2]) sphere(r=2, $fn=60);

difference() {
    translate([2, 0, -2.75]) cube([4, 10, 10.5], center=true);
    rotate([0, 90, 0]) cylinder(h=10, r=1.5, center=true, $fn=60);
}

translate([0, 0, -2.75]) difference() {
    translate([-5, 0, 0]) cube([10, 7, 10.5], center=true);
    translate([-5, 0, 0])
        rotate([90, 0, -90])
            linear_extrude(height = 10, center = true, convexity = 10, scale=[0.5, 1])
                square([3, 10.5], center=true);

}
