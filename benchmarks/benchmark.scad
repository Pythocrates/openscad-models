// Some simple print for a comparison of filament materials.


module rectangular_u() {
    difference() {
        cube([30, 14, 5], center=true);
        translate([-1, 0, 0]) cube([28, 10, 5], center=true);
    }
}


rectangular_u();
