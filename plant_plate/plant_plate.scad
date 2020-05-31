// A simple plant label plate to put into soil.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>


FN = 120;


module half_slot(length, width=10, thickness=3) {
    xmove((length - width) / 2) {
        intersection() {
            slot(h=thickness, l=length, d=width, $fn=FN);  
            xmove(width / 2) cuboid([length, width, thickness]);
        }
    }
}

module stake() {
    xmove(-45) {
        intersection() {
            slot(h=3, l=100, d=10, $fn=FN);  
            xmove(-5) cuboid([100, 10, 3]);
        }
    }
    yrot(45, [0, 0, 1.5]) xmove(5) {
        intersection() {
            slot(h=3, l=20, d=10, $fn=FN);  
            xmove(5) cuboid([20, 10, 3]);
        }
    }
    //slot(h=3, l=100, d1=10, d2=8);  
}


module plate() {
    cuboid([60, 30, 2], align=V_UP + V_REAR, fillet=3, edges=EDGES_Z_ALL, $fn=FN);
    ymove(5) difference() {
        zrot(90) zmove(-1) half_slot(length=23, width=16, thickness=2);
        zrot(90) zmove(-1) half_slot(length=20, width=10, thickness=2);
    }
}


module parts() {
    stake();
    ymove(30) plate();
}

module assembly() {

}


parts();
