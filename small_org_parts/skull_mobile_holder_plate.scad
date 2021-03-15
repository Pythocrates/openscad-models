// This is a small holder to hold the TAN generator in the desk drawer.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 60;


module plate() {
    size = [72, 71, 3.8];
    sparse_strut(l=size.x, h=size.y, thick=size.z, strut=2, maxang=60);
}


plate();
