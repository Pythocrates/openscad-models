
TOL = 0.05;

module wheel() {
    {
        difference() {
            cylinder(r=12.5 - TOL / 2, h=2, center=true, $fn=60);
            cylinder(r=4 + TOL / 2, h=2, center=true, $fn=60);
        }

        for (i=[-3:2]) {
            rotate([0, 0, 7.3 + 22.5 * i]) {
                translate([10, 0, 5 / 2]) {
                    #cylinder(r=0.875, h=5, center=true, $fn=60);
                    translate([0, 0, 5 / 2]) sphere(r=0.875, $fn=60);
                }
            }
        }
    }
}

module base() {
    length = 40;
    cube([40, length, 2], center=true);
    translate([0, 0, 5 / 2]) cylinder(r=4 - TOL/2, h=5, center=true, $fn=60);
    translate([-40 / 2 + 5 / 2, 0, 6 / 2]) cube([5 - TOL, length, 6], center=true);
    translate([40 / 2 - 5 / 2 + TOL, 0, 6 / 2]) cube([5 - TOL, length, 6], center=true);
    #translate([-40 / 2 + 5 + 2.5 / 2 - TOL, 0, 4 / 2 - 1]) cube([2.5 - TOL, length, 4], center=true);
    #translate([40 / 2 - 5 - 2.5 / 2 + 2 * TOL, 0, 4 / 2 - 1]) cube([2.5 - TOL, length, 4], center=true);
}


module tooth(ratio=1, scale=1, skew=0) {
    width = 3.20575;
    height = 4.4045 * scale;
    #difference() {
        linear_extrude(height=2.5) {
            polygon(points=[[-width / 2, 0], [width / 2, 0],[width * skew, height]]);
        }
        translate([0, height * (ratio + 0.5), 1.25]) cube([width, height, 2.5], center=true);
    }
}

module teeth() {
    for (i=[3:3]) {
        translate([i * 3.934, -11.875, 0]) tooth(scale=1.5485, ratio=0.751375, skew=0.1);
    }
    for (i=[-3:-3]) {
        translate([i * 3.934, -11.875, 0]) tooth(scale=1.5485, ratio=0.751375, skew=-0.1);
    }
    for (i=[-2:2]) {
        translate([i * 3.934, -11.875, 0]) tooth(ratio=0.596);
    }
}

module moving_slider(offset) {
    translate([offset, 0, 0]) {
        mirror([0, 1, 0]) {
            translate([-0.5408, 0, 0])
            teeth();
        }
        translate([0.5430, 0, 0]) teeth();
        import("slider_0.stl");
    }
}

module rotating_wheel(angle) {
    rotate([0, 0, angle]) {
        wheel();
    }
}


module assembly(t=0) {
    factor = 64;
    d_slide = t < 0.5 ? -factor * (t - 0.25) : factor * (t - 0.75);
    a_wheel = 4.0 + 4 + 360 * t;

    rotating_wheel(a_wheel);
    moving_slider(d_slide);
}

module parts(t=0) {
    translate([-40, 0, 0]) base();
    rotating_wheel(0);
    translate([60, 0, 0]) moving_slider(0);
}


assembly($t);
//parts();
