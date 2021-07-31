// This is a model of a ring-shaped spoon holder.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module spoon_holder(radius, thickness, height) {
    gap = 1;
    open_radius = radius + gap / (2 * PI); // slightly bigger radius for tightening the ring with a screw
    difference() {
        union() {
            zcyl(r=open_radius + thickness, h=height, $fn=FN);
            //ymove(-open_radius - thickness + 0.5) cuboid([10 + gap, 10, 2 * height], align=V_FRONT);
            ymove(-open_radius - thickness + 0.5) zmove(height / 2)
                prismoid(size1=[10 + gap, 2 * height], size2=[10 + gap, height], shift=[0, -height / 2], h=10, orient=ORIENT_Y, align=V_FRONT);
        }
        zcyl(r=open_radius, h=height, $fn=FN);
        ymove(-open_radius) cuboid([gap, 12 * thickness, 3 * height]);

        zmove(0.5) ymove(-open_radius - thickness - 3){
            xmove((10 + gap) / 2) xcyl(d=3.6, h=2, align=V_LEFT, $fn=FN);  // place for the screw head 
            xmove(-(10 + gap) / 2) xcyl(d=4.4, h=2, align=V_RIGHT, $fn=6);  // place for the nut
            xcyl(d=2.2, h=10 + gap, $fn=FN);
        }

        // spoon holder
        zmove(height / 2) {
            #ymove(-open_radius - thickness - 8) prismoid(size1=[4.2 + gap, 2.5], size2=[5.2 + gap, 2.5], h=2 * height, align=V_CENTER + V_BACK);
            #ymove(-open_radius - thickness - 8) prismoid(size1=[4 + gap, 1.5], size2=[4 + gap, 1.5], h=2 * height, align=V_CENTER + V_FRONT);
        }
    }
}


module nut_test_block() {
    difference() {
        cuboid([8, 40, 8]);
        for (i = [0 : 4]) {
            ymove((i - 2) * 8) {
                xcyl(d=2.1, h=8, $fn=FN);
                xmove(2.5) xcyl(d=3.5 + 0.05 * i, h=1.5, align=V_RIGHT, $fn=FN);
                xrot(0) xmove(-2.5) xcyl(d=4 + 0.1 * i, h=1.5, align=V_LEFT, $fn=6);
            }
        }
    }
}

SMALL_RADIUS = 57.5 / 2;
SMALL_THICKNESS = 2;
SMALL_HEIGHT = 4;
spoon_holder(radius=SMALL_RADIUS, thickness=SMALL_THICKNESS, height=SMALL_HEIGHT);

//nut_test_block();
