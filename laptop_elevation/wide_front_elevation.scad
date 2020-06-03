// Single extensible riser for the laptop to tilt it backwards.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module block() {
    difference() {
        slot(l=150, h=10, r=10, $fn=FN);
        slot(l=150, h=10, r=8, $fn=FN);
    }
    difference() {
        zmove(5) xspread(n=5, l=150) cyl(l=20, r=10, fillet2=10, $fn=FN);
        zmove(4) xspread(n=5, l=150) cyl(l=18, r=8, fillet2=8, $fn=FN);
    }
}


module parts() {
    block();
}


parts();
