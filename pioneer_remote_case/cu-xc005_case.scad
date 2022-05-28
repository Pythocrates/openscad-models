// This is a simplified case for the CU-XC005 Pioneer remote.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;


module case() {
    plate = [70, 130, 3];
    hole = [54.25, 81.5, 3];
    angle = -6.3;

    difference() {
        union() {
            cuboid(plate, align=V_UP + V_FRONT, fillet=5, edges=EDGES_Z_ALL, $fn=FN);
            xrot(angle, cp=[0, -plate.y + 10, 0]) ymove(-plate.y) cuboid([hole.x + 2.5 * 2, 10, 7], align=V_BACK, fillet=2.5, edges=EDGES_Y_BOT, $fn=FN);

            part1 = [hole.x, 9, 13];
            ymove(-9.5 - 2) xrot(angle) difference() {
                cuboid(part1 + [2.5 * 2, 0, 2.5], align=V_DOWN + V_FRONT, fillet=3, edges=EDGES_Y_BOT, $fn=FN);
                cuboid(part1, align=V_DOWN + V_FRONT, fillet=3 - 2.5, edges=EDGES_Y_BOT, $fn=FN);
            }

            part2 = [hole.x, 43, 7];
            ymove(-31.5) difference() {
                cuboid(part2 + [2.5 * 2, 0, 2.5], align=V_DOWN + V_FRONT, fillet=3, edges=EDGES_Y_BOT, $fn=FN);
                cuboid(part2, align=V_DOWN + V_FRONT, fillet=3 - 2.5, edges=EDGES_Y_BOT, $fn=FN);
            }
        }
        ymove(-9.5) cuboid(hole, align=V_UP + V_FRONT, fillet=3, edges=EDGES_Z_ALL);
        zmove(-3) xrot(angle, cp=[0, -plate.y + 5, 0]) cuboid(plate + [0, 5, 0], align=V_DOWN + V_FRONT);
        ymove(-plate.y) cuboid([plate.x, 5, 2* plate.z], align=V_FRONT);
        zmove(plate.z) cuboid(plate, align=V_UP + V_FRONT);
    }
    ymove(-93) cuboid([10, 1, 2], align=V_DOWN + V_FRONT, fillet=1, edges=EDGES_Y_BOT, $fn=FN);
    ymove(-7) {
        //xspread(spacing=40) back_half() xcyl(h=2, r=2, $fn=FN);
        xspread(spacing=40) prismoid(size1=[2, 2], size2=[2, 0], shift=[0, 1], h=4, orient=ORIENT_Y, align=V_DOWN + V_BACK);

    }



}


case();
