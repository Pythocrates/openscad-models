// This is a lightweight plate for the skull based smartphone stand.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 60;


module plate() {
    size = [4.0, 72.25, 60];
    difference() {
        sparse_strut(l=size.y, h=size.z, thick=size.x, strut=2, maxang=60);
        cuboid(size - [2, 4, 4], align=V_RIGHT);
    }
}


plate();
