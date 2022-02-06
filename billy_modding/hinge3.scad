// This a more sophisticated hinge accounting for the opening angle by getting longer in the middle section.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;

X = 25;
Y = 25;

hole_distance = 32;
hole_edge_distance = 38;
wall_thickness = 19;


module wall() {
    color("white") difference() {
        cuboid([19, 200, 200], align=V_RIGHT + V_BACK);
        translate([19, hole_edge_distance, 0]) zspread(n=4, spacing=hole_distance) xcyl(l=12, d=5, align=V_LEFT);
    }
    //zmove(10) color("black") translate([X, Y, 0]) zcyl(h=100, r=2.5, align=V_DOWN, $fn=FN);
}


module rotated_wall(angle=0) {
    zrot(angle) xflip() wall();
}


module connector_2(angle) {
    radius = sqrt(X ^ 2 + Y ^ 2);
    theta = atan2(Y, X);
    center = 0.5 * [radius * (cos(theta) + cos(180 - theta + angle)), radius * (sin(theta) + sin(180 - theta + angle)), 0];

    diagonal = radius * sqrt((sin(angle + 45) - sin(-45)) ^ 2 + (cos(angle + 45) - cos(-45)) ^ 2);
    trapezoid_angle = acos((diagonal - 2 * X) / 2 / 30);


    color("brown") translate([25, 25, 0]) {
        rotate(angle / 2) cuboid([diagonal, 2, 2], align=V_LEFT);
        rotate(angle / 2 - 90 - (90 - trapezoid_angle)) cuboid([30, 2, 2], align=V_RIGHT);
        translate([30 * cos(angle / 2 - 90 - (90 - trapezoid_angle)), 30 * sin(angle / 2 - 90 - (90 - trapezoid_angle)), 0]) rotate(angle / 2) cuboid([2 * X, 2, 2], align=V_LEFT);
    }
    color("brown") translate([-25, 25, 0]) {
        rotate(angle / 2 - 90 - (90 - trapezoid_angle)) cuboid([30, 2, 2], align=V_LEFT);
    }

    color("red")
        rotate(0) {
            translate([25, 10, 0])

            translate([0, 15, 0])
            //rotate(1 * angle / 2)
            rotate(angle / 2 - (90 - trapezoid_angle))
            translate([0, -15, 0])

            /*difference() {
                arced_slot(d=30, h=5, sd=10, sa=270, ea=90, $fn=FN);
                translate([0, 30 / 2, 0]) zcyl(d=2, h=5, $fn=FN);
                translate([0, -30 / 2, 0]) zcyl(d=2, h=5, $fn=FN);
            }*/

            difference() {
                // This is the arm.
                zrot(90) slot(l=30, h=5, $fn=FN);
                translate([0, 30 / 2, 0]) zcyl(d=2, h=5, $fn=FN);
                translate([0, -30 / 2, 0]) zcyl(d=2, h=5, $fn=FN);

                zmove(0.5) translate([0, -30 / 2, 0]) zcyl(d=6.5, h=4, $fn=FN);
                cuboid([21, 1.5, 5]);
            }
    }

    color("white")
        rotate(angle) {
            translate([-25, 10, 0])

            translate([0, 15, 0])
            rotate(-1 * angle / 2)
            translate([0, -15, 0])

            xflip()
                difference() {
                    arced_slot(d=30, h=5, sd=10, sa=270, ea=90, $fn=FN);
                    translate([0, 30 / 2, 0]) zcyl(d=2, h=5, $fn=FN);
                }
    }
}


module connector_anchor() {
    color("blue") {
        translate([18, 38, 16]) xcyl(d=5 - 0.1, h=10, align=V_LEFT, $fn=FN);
        translate([18, 38, -16]) xcyl(d=5 - 0.1, h=10, align=V_LEFT, $fn=FN);
        zflip_copy() difference() {
            translate([25, 25, 5 / 2])
            union() {
                cuboid([5, 10, 5], align=V_UP + V_LEFT);
                zcyl(d=10, h=5, align=V_UP, $fn=FN);
            }
            translate([25, 25, 5 / 2]) zcyl(d=2, h=5, align=V_UP, $fn=FN);
        }
        difference() {
            translate([18, 38 - 10, 0]) cuboid([2, 40, 40], align=V_RIGHT);
            translate([18, 38 - 18, 0]) cuboid([2, 40, 5 + 2], align=V_RIGHT + V_BACK);
        }
    }
}



angle = $t * 180 * 1;

/*
wall();
rotated_wall(angle=angle);
connector_anchor();
connector_2(angle=angle);
*/


module arm() {
    difference() {
        height = 2 * 7.5;
        length = 30;
        spring_diameter = 6.5;
        spring_thickness = 1.5;

        // This is the arm.
        zmove(height / 2) slot(l=length, h=height, $fn=FN);
        translate([length / 2, 0, 0]) zcyl(d=2 + 0.2, h=height, align=V_UP, $fn=FN);
        translate([-length / 2, 0, 0]) zcyl(d=3 + 0.1, h=height, align=V_UP, $fn=FN);

        zmove(1) translate([-length / 2, 0, 0]) zcyl(d=6.5, h=height - 1, align=V_UP, $fn=FN);
        zmove(1) xmove(-length / 2) translate((spring_diameter / 2 - spring_thickness / 2) * [0, -1, 0]) cuboid([18, spring_thickness, height - 1], align=V_UP + V_RIGHT);
        zmove(height / 2) xmove(-length / 2) zrot(45) cuboid([10, length, height / 2], align=V_UP);
    }
}


module middle_piece() {
    height = 2 * 7.5;
    length = 39 + 2 * 5;
    spring_diameter = 6.5;
    spring_thickness = 1.4;

    difference() {
        slot(l=length, h=height, r=5, $fn=FN);

        yrot_copies(n=2) {
            translate([length / 2, 0, 0]) zcyl(d=6.5, h=height / 2 - 1, align=V_DOWN, $fn=FN);
            translate([-length / 2, 0, 0]) zcyl(d=3 + 0.1, h=height, align=V_UP, $fn=FN);

            zmove(height / 2) xmove(length / 2) translate((spring_diameter / 2 - spring_thickness / 2) * [0, 1, 0]) cuboid([18, spring_thickness, height - 1], align=V_DOWN + V_LEFT);
            xmove(length / 2) zrot(45) cuboid([10, length, height / 2], align=V_UP);
        }
    }
}


module adapter_plate() {
    hole_diameter = 5;

    color("blue") {
        difference() {
            cuboid([10, hole_distance + 2 * hole_diameter, hole_edge_distance + hole_diameter], align=V_RIGHT + V_BACK);
            cuboid([10, 30 + 5, 15], align=V_RIGHT + V_BACK);
            ymove(30 - 5) xmove(10 / 2) zcyl(l=60, d=2 + 0.2, $fn=FN);
        }
        zflip_copy() zmove(7.5) ymove(30 - 5) difference() {
            cuboid([10, 10, 10], align=V_RIGHT + V_UP);
            xmove(10 / 2) zcyl(l=60, d=2 + 0.2, $fn=FN);
        }
        ymove(hole_edge_distance) zspread(spacing=hole_distance) cyl(h=10, d=hole_diameter - 0.2, chamfer1=0.5, orient=ORIENT_X, align=V_LEFT, $fn=FN);
    }
}

module assembly() {
    wall();
    xmove(wall_thickness) adapter_plate();

    yrot_copies(n=2) translate([-wall_thickness - 5, 2 * 5, -7.5]) rotate(90) arm();
    ymove(-5) middle_piece();
}



//assembly();
adapter_plate();
