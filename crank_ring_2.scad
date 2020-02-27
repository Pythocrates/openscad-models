difference() {
    union() {
        cylinder(r=7, h=2.5, $fn=180, center=true);
    }
    union() {
        cylinder(r=6.25, h=3.0, $fn=180, center=true);
        translate([-6, 0, 0]) cube([4, 4, 4], center=true);
    }
}
