
/*
%translate([-68.03333, -40.8165, -1]) {
difference() {
    import("reciprocating.stl");
    cube([150, 100, 1]);
    translate([130, 130, 0]) cube([20, 20, 28]);
}
}
*/

FN = 60;
TOL = 0.1;


module rotating_stud() {
    height = 6;
    cylinder(r=1.5, h=height, $fn=FN);
    translate([0, 0, height]) cylinder(r=1.0, h=2, $fn=FN);
}

module linear_ridge() {
    difference() {
        translate([20, 3, 12 / 2]) cube([160, 8, 12 - TOL], center=true);
        translate([-25, 3, 12 / 2]) cube([40, 8, 8], center=true);
        translate([25, 3, 12 / 2]) cube([40, 8, 8], center=true);
    }
    #translate([26 + 80 / 2 - 3.5 / 2, -3, 12 / 2]) cube([3.5, 20, 10 - TOL], center=true);
    #translate([-120 / 2 + 3.5 / 2, -3, 12 / 2]) cube([3.5, 20, 10 - TOL], center=true);
    translate([0, -1.5, 1 + 2.5 + 0.5 + 2]) {
        cube([4, 15, 4], center=true);
        translate([0, -7.5, 0]) cylinder(r=2, h=4, center=true, $fn=FN);
        translate([-28, 5, -6]) cylinder(r=2, h=11, $fn=FN);
    }
    
}

module rotating_studs() {
    rotate([0, 0, -37.05]) translate([0, -11.87, 2]) rotating_stud();
    rotate([0, 0, 180 - 37.05]) translate([0, -11.87, 2]) rotating_stud();
}

module single_plate() {
    difference() {
        cylinder(r=15, h=2, $fn=FN);
        cylinder(r=4 + TOL, h=2, $fn=FN);
    }
}

module top_plate() {
    difference() {
        single_plate();
        translate([0, 0, -8]) rotating_studs();
    }
}

module bottom_plate() {
    union() {
        top_plate();
        rotating_studs();
    }
}

module rotating_wheel() {
    translate([0, 0, 8]) single_plate();
    bottom_plate();
}

module lever(angle=0) {
    height = 4;

    rotate([0, 0, angle]) {
        difference() {
            union() {
                cylinder(r=4, h=height, $fn=FN);
                translate([-4, 0, 0]) cube([8, 26, height]);
            }
            cylinder(r=2, h=height, $fn=FN);
            translate([-(4 + TOL) / 2, 17, 0]) cube([4 + TOL, 9, height]);
            translate([0, 17, 0]) cylinder(r=2 + TOL / 2, h=height, $fn=FN);
        }
        rotate([0, 0, 10.05]) {
            translate([14.6, 0, 0]) cylinder(r=1.25, h=height, $fn=FN);
            translate([2.7, 0, height / 2]) rotate([0, 90, 0]) linear_extrude(height=12, scale=[1, 0.454545]) {
                square([height, 5.5], center=true);
            };
        }
    }
}

module base_plate() {
    cube([100, 50, 2]);

    // rotation axis
    translate([42.5, 20, 0]) {
        cylinder(r=8, h=1 + 2 - TOL / 2, $fn=FN);
    }

    // lever axis
    translate([19.0, 21.0, 0]) {
        cylinder(r=4.0, h=6 - TOL / 2, $fn=FN);
    }
}

module axes() {
    // rotation axis
    translate([42.5, 20, 0]) {
        cylinder(r=4 - TOL, h=10 + 2  + 2, $fn=FN);
        cylinder(r=2, h=12 + 2 + 2, $fn=FN);
    }

    // guide axes
    for (x=[5, 95]) {
        for (y=[5.6, 34.6, 45.6]) {
            translate([x, y, 0]) {
                cylinder(r=1.5 - TOL, h=12 + 2, $fn=FN);
                cylinder(r=1.2 - TOL, h=12 + 2 + 2, $fn=FN);
            }
        }
    }

    // lever axis
    translate([19.0, 21.0, 0]) {
        cylinder(r=2.0 - TOL, h=12 + 2, $fn=FN);
        cylinder(r=1.5 - TOL, h=12 + 2 + 2, $fn=FN);
    }
}

module bottom() {
    base_plate();
    axes();
}

module top() {
    difference() {
        translate([0, 0, 16]) mirror([0, 0, 1]) base_plate();
        axes();
    }
}

module assembly() {
    bottom();
    top();
    translate([42.5, 20, 3]) rotating_wheel();
    translate([19.0, 21.0, 6]) lever(angle=-8.8);
    translate([50 + $t * 10, 37, 2]) linear_ridge();
}

module parts() {
    bottom();
    rotate([180, 0, 0]) translate([0, -110, -16]) top();
    translate([132.5, 20, 3]) rotating_wheel();
    translate([129.0, 61.0, 6]) lever(angle=-8.8);
    translate([60, 120, 7]) rotate([-90, 0, 0]) translate([0, 0, 0]) linear_ridge();
}

//assembly();
parts();
