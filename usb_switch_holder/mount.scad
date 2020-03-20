// The lower part of the USB switch holder.

use <usb_switch_holder.scad>

rotate([0, 0, -3]) translate([0, 0, -9]) difference() {
    union() {
        //rotate([45, 0, 0]) 
        translate([45, 0, 4]) cube([96, 4, 10], center=true);

        //rotate([-45, 0, 0]) translate([45, 0, 0]) cube([96, 2, 10], center=true);
        cylinder(h=18, r=6.5, center=true);
        translate([96, 0, 0]) cylinder(h=18, r=5, center=true);
    }
    cylinder(h=16, r=4.5, center=true);
    translate([96, 0, 0]) cylinder(h=16, r=3, center=true);
}

translate([43 + 18, 27 - 15, 14.5]) rotate([0, 0, -90]) cage();
