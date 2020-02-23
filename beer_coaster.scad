// A personalized beer coaster.

difference() {
    union() {
        translate([36.5, 36.5, 0]) {
            cylinder(r=10, h=2, center=true);
        }
        translate([-36.5, 36.5, 0]) {
            cylinder(r=10, h=2, center=true);
        }
        translate([36.5, -36.5, 0]) {
            cylinder(r=10, h=2, center=true);
        }
        translate([-36.5, -36.5, 0]) {
            cylinder(r=10, h=2, center=true);
        }

        cube([73, 93, 2], center=true);
        cube([93, 73, 2], center=true);
    }
    union() {
       translate([-40, 4, 2]) {
            linear_extrude(4, center=true) {
                //text("Wernis", font="Liberation Sans:style=Bold Italic", size=16);
                text("Martins", font="Liberation Sans:style=Bold Italic", size=15);
            }
        }
       translate([-30, -18, 0]) {
            linear_extrude(4, center=true) {
                text("Weizen", font="Liberation Sans:style=Bold Italic", size=15);
            }
        }

        translate([-15, 30, -4.15 - 1.5]) {
            scale([0.3, 0.3, 1]) mirror([0, 1, 0]) translate([-12, 0, 0]) import("/home/mkrzykaw/Downloads/3d_models/Hop_Flower/files/hop_flower.stl");
        }
        translate([0, 30, -7]) {
            scale([0.3, 0.3, 1]) mirror([0, 1, 0]) translate([-12, 0, 0]) import("/home/mkrzykaw/Downloads/3d_models/Hop_Flower/files/hop_flower.stl");
        }
        translate([15, 30, -4.15 - 1.0]) {
            scale([0.3, 0.3, 1]) mirror([0, 1, 0]) translate([-12, 0, 0]) import("/home/mkrzykaw/Downloads/3d_models/Hop_Flower/files/hop_flower.stl");
        }

        translate([-18, -30, -4.15 - 2.5]) {
            scale([0.3, 0.3, 1]) mirror([0, 1, 0]) translate([-12, 24, 0]) import("/home/mkrzykaw/Downloads/3d_models/Hop_Flower/files/hop_flower.stl");
        }
        translate([0, -30, -4.15 - 2.5]) {
            scale([0.3, 0.3, 1]) mirror([0, 1, 0]) translate([-12, 24, 0]) import("/home/mkrzykaw/Downloads/3d_models/Hop_Flower/files/hop_flower.stl");
        }
        translate([18, -30, -4.15 - 2.5]) {
            scale([0.3, 0.3, 1]) mirror([0, 1, 0]) translate([-12, 24, 0]) import("/home/mkrzykaw/Downloads/3d_models/Hop_Flower/files/hop_flower.stl");
        }
    }
}
translate([-4.8, -10, 0]) rotate([0, 0, -7]) cube([1, 10, 2], center=true);
translate([22.4, -10, -0.5]) rotate([0, 0, -7]) cube([1, 10, 1], center=true);

translate([35, 35, 1]) {
    scale([0.2, 0.2, 0.2]) mirror([0, 1, 0]) import("/home/mkrzykaw/Downloads/3d_models/Zirbelnuss/files/finial_cds_q0.9.stl");
}
translate([-35, -35, 1]) {
    scale([0.2, 0.2, 0.2]) mirror([0, 1, 0]) import("/home/mkrzykaw/Downloads/3d_models/Zirbelnuss/files/finial_cds_q0.9.stl");
}
translate([35, -35, 1]) {
    scale([0.2, 0.2, 0.2]) mirror([0, 1, 0]) import("/home/mkrzykaw/Downloads/3d_models/Zirbelnuss/files/finial_cds_q0.9.stl");
}
translate([-35, 35, 1]) {
    scale([0.2, 0.2, 0.2]) mirror([0, 1, 0]) import("/home/mkrzykaw/Downloads/3d_models/Zirbelnuss/files/finial_cds_q0.9.stl");
}
