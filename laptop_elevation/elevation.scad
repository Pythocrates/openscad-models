// This is a pair of elevation stubs for a Lenovo ThinkPad X1 laptop.

cylinder(r=6, h=27, $fn=60);
translate([0, 0, 27]) sphere(r=6, $fn=60);

translate([15 + 6 + 3, 0, 0]) cylinder(r=3, h=12, $fn=60);
translate([15 + 6 + 3, 0, 12]) sphere(r=3, $fn=60);


translate([0, 0, 1]) rotate([0, 90, 0]) linear_extrude(height=15 + 6 + 3, scale=[1, 0.5]) square([2, 12], center=true);


