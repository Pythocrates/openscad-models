// This is a simple implementation of an impossible table.


module plate() {
    thickness = 4;
    difference() {
        cylinder(r=25, h=thickness);
        translate([23, 0, 0]) cylinder(r=1, h=5, $fn=20);
        rotate([0, 0, 120]) translate([23, 0, 0]) cylinder(r=1, h=5, $fn=20);
        rotate([0, 0, -120]) translate([23, 0, 0]) cylinder(r=1, h=5, $fn=20);
    }
    rotate([0, 0, 90]) translate([0, 0, 6]) difference() {
        cube([10, 8, 8], center=true);
        cube([10, 4, 4], center=true);
    }
}

module leg() {
    rotate([0, 0, 90]) translate([0, 0, 5.9]) cube([40, 3.8, 3.8], center=true);
    rotate([0, 0, 90]) translate([-20, 0, 22]) cube([4, 3.8, 36], center=true);
    rotate([0, 0, 90]) translate([-9, 0, 38]) difference() {
        cube([25, 3.8, 4], center=true);
        translate([9, 0, -2]) cylinder(r=1, h=4, $fn=20);
    }

}

leg();
/*
plate();
translate([0, 0, 60]) rotate([180, 0, 0]) {
    plate();
    leg();
}
*/
