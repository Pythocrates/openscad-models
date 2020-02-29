// Cap for the metal rods in the garden. Simon's cat version.

translate([0, 0, 8]) cylinder(r=38, h=2, $fn=120);
difference() {
    cylinder(r=23.5, h=10, $fn=120);
    cylinder(r=21.25, h=8, $fn=120);    
}

translate([0, 0, 10])
    resize([0, 0, 80], auto=true)
        rotate([0, 0, 0])
            translate([0, 0, 0])
                import("/home/mkrzykaw/Downloads/3d_models/Simons_hungry_Cat/files/simonscathungrylowerres.stl");
rotate([0, 0, 0]) rotate_extrude(convexity=10, $fn=60)
    translate([38, 9, 0])
        circle(r = 1);
