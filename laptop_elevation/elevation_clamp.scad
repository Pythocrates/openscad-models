// These are laptop elevation clamps for a Lenovo Thinkpad X1 laptop.

module stand() {
    cube([15, 40, 1.0]);
    translate([0, 39, -14]) cube([15, 1, 15]);
    translate([0, 38.14, -14.5]) rotate([30, 0, 0]) cube([15, 1, 17]);
    translate([0, 39, -14]) rotate([0, 90, 0]) cylinder(h=15, r=1, $fn=60);

    difference() {
        union() {
            translate([0, 0, 11.5]) cube([15, 20, 1.5]);

            for (i = [0 : 2]){
                #translate([0, i * 9, 0]) cube([1, 2, 13]);
                translate([1.0, i * 9, 0]) rotate([0, -7.5, 0]) cube([1.5, 2, 11.5]);
            }
        }
        translate([-2, 0, 0]) cube([2, 20, 15]);
    }
}

translate([0, 1, 0]) stand();
translate([0, -1, 0]) mirror([0, 1, 0]) stand();
