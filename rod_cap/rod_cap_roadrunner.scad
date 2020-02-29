// Cap for the metal rods in the garden. Spongebob version.

difference() {
    cylinder(r=23.5, h=10, $fn=120);
    cylinder(r=21.25, h=8, $fn=120);    
}

translate([15, 0, 9])
    resize([0, 0, 60], auto=true)
        rotate([0, 0, 0])
            translate([0, 0, 12.5])
                import("/home/mkrzykaw/Downloads/3d_models/day-1-the-road-runner/source/roadrunner.stl");

translate([15, -0.75, 29])
    rotate([0, 45, 0])
        cylinder(r=1, h=10, center=true, $fn=64);
translate([15, 0.75, 29])
    rotate([0, 45, 0])
        cylinder(r=1, h=10, center=true, $fn=64);
