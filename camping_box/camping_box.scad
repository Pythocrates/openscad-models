// A camping box with a bed for an Audi A6 Avant.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 20;
EPSILON = 0.1; // one-side tolerance for extrusions

module euro_box() {
  color("grey") {
    cuboid([400, 300, 280], align=V_UP);
  }    
}


module samla_box(size) {
  color("white") {
    if (size == 1) {
      cuboid([390, 280, 140], align=V_UP);
    } else if (size == 2) {
      cuboid([280, 190, 140], align=V_UP);
    }
  }
}

module car_floor() {
  //cuboid([1000, 1100, 15], align=V_FRONT + V_DOWN);
  //cuboid([20, 1160, 15], align=V_FRONT + V_DOWN);
  color("black") {
    intersection() {
      cuboid([1050, 1160, 10], align=V_FRONT + V_DOWN);
      shift = 960;
      ymove(shift) zcyl(r=1160 + shift, h=10, align=V_DOWN, $fn=FN);
    }
  }
}

// ratio between 0 and 1
module back_rest(inclination_ratio) {
  color("black") {
    xrot(7.5 + (90 + 23.5 - 7.5) * inclination_ratio) cuboid([1200, 650, 100], align=V_BACK + V_DOWN);
  }
}

// A variant with two almost full-width wings as supports. The rest of the length might be inside the box to be pulled out.
// Still missing is the connection(s) between left and right supports.
module variant_1(inclination_ratio) {
  BOTTOM_THICKNESS = 10; // We can make the bottom thinner as it is not much under load.
  THICKNESS = 18;
  BED_LENGTH = 1900;
  BOX_SIZE = [1000, 700, 140 + THICKNESS + BOTTOM_THICKNESS];
  INNER_SIZE = [BOX_SIZE.x - 2 * THICKNESS, BOX_SIZE.y - 2 * THICKNESS, BOX_SIZE.z - THICKNESS - BOTTOM_THICKNESS];

  ymove(-100) {
    // Box
    move([0, 0, 0]) cuboid([BOX_SIZE.x, BOX_SIZE.y, BOTTOM_THICKNESS], align=V_FRONT + V_UP); // bottom
    zmove(BOTTOM_THICKNESS) {
      move([0, -40, 0]) cuboid([INNER_SIZE.x, THICKNESS, INNER_SIZE.z], align=V_FRONT + V_UP); // front
      move([0, -290, 0]) cuboid([INNER_SIZE.x, THICKNESS, INNER_SIZE.z], align=V_BACK + V_UP); // middle
      move([0, -BOX_SIZE.y, 0]) cuboid([INNER_SIZE.x, THICKNESS, INNER_SIZE.z], align=V_BACK + V_UP); // rear

      // left side
      move([-BOX_SIZE.x / 2 + THICKNESS / 2, 0, 0]) difference() {
        cuboid([THICKNESS, BOX_SIZE.y, INNER_SIZE.z], align=V_FRONT + V_UP);
        move([0, 0, THICKNESS]) cuboid([THICKNESS, THICKNESS, INNER_SIZE.z - 2 * THICKNESS], align=V_FRONT + V_UP);
      }
      // left support
      color("blue") move([-BOX_SIZE.x / 2 + THICKNESS / 2, -THICKNESS, 0]) zrot(-90 * (inclination_ratio < 0.5 ? 0.0 : 2 * (inclination_ratio - 0.5)), cp=[0, THICKNESS / 2, 0]) difference() {
        cuboid([THICKNESS, BOX_SIZE.x - 50, INNER_SIZE.z], align=V_BACK + V_UP, fillet=THICKNESS / 2, edges=EDGES_Z_FR, $fn=FN);
        move([0, 0, 0]) cuboid([THICKNESS, THICKNESS, THICKNESS], align=V_BACK + V_UP);
        move([0, 0, INNER_SIZE.z]) cuboid([THICKNESS, THICKNESS, THICKNESS], align=V_BACK + V_DOWN);
        move([0, 100 + THICKNESS, -BOTTOM_THICKNESS]) xrot(7.5) cuboid([1200, 650, 100], align=V_BACK + V_DOWN);
        move([0, 762.43, 74.85]) cuboid([THICKNESS, 400, 80], align=V_BACK + V_DOWN); // just a rough guess
      }

      // right side
      move([BOX_SIZE.x / 2 - THICKNESS / 2, 0, 0]) difference() {
        cuboid([THICKNESS, BOX_SIZE.y, INNER_SIZE.z], align=V_FRONT + V_UP);
        move([0, 0, THICKNESS]) cuboid([THICKNESS, THICKNESS + 20, INNER_SIZE.z - 2 * THICKNESS], align=V_FRONT + V_UP);
      }
      // right support
      color("blue") move([BOX_SIZE.x / 2 - THICKNESS / 2, -THICKNESS - 20, 0]) zrot(90 * (inclination_ratio < 0.5 ? 2 * inclination_ratio : 1.0), cp=[0, THICKNESS / 2, 0]) difference() {
        cuboid([THICKNESS, BOX_SIZE.x - 50, INNER_SIZE.z], align=V_BACK + V_UP, fillet=THICKNESS / 2, edges=EDGES_Z_FR, $fn=FN);
        move([0, 0, 0]) cuboid([THICKNESS, THICKNESS + 20, THICKNESS], align=V_BACK + V_UP);
        move([0, 0, INNER_SIZE.z]) cuboid([THICKNESS, THICKNESS + 20, THICKNESS], align=V_BACK + V_DOWN);
        move([0, 100 + THICKNESS + 20, -BOTTOM_THICKNESS]) xrot(7.5) cuboid([THICKNESS, 650, 100], align=V_BACK + V_DOWN);
        move([0, 762.43 + 20, 74.85]) cuboid([THICKNESS, 400, 80], align=V_BACK + V_DOWN); // just a rough guess
      }

      // bed boards
      zmove(INNER_SIZE.z) {
        ///*color("brown") */cuboid([BOX_SIZE.x, BOX_SIZE.y, THICKNESS], align=V_FRONT + V_UP);
        xrot(180 * inclination_ratio, cp=[0, 0, THICKNESS]) {
          cuboid([BOX_SIZE.x, (BED_LENGTH - BOX_SIZE.y) / 2, THICKNESS], align=V_BACK + V_UP);
          ymove((BED_LENGTH - BOX_SIZE.y) / 2) xrot(-180 * inclination_ratio, cp=[0, 0, 0]) cuboid([BOX_SIZE.x, (BED_LENGTH - BOX_SIZE.y) / 2, THICKNESS], align=V_BACK + V_UP);
        }
      }
    }
  }

  zmove(BOTTOM_THICKNESS) {
    // IKEA Samla boxes for the stuff.
    move([-340, -585, 0]) zrot(90) samla_box(1);
    move([0, -585, 0]) zrot(90) samla_box(1);
    move([340, -585, 0]) zrot(90) samla_box(1);

    move([-340, -270, 0]) zrot(0) samla_box(2);
    move([0, -270, 0]) zrot(0) samla_box(2);
    move([340, -270, 0]) zrot(0) samla_box(2);
  }

  // Euro boxes in the back for the infrastructure.
  move([-300, -950, 0]) euro_box();
  move([300, -950, 0]) euro_box();
}


// A variant with two nested U shapes as supports, hidden in the box, to be pulled out.
module variant_2(inclination_ratio) {
  BOTTOM_THICKNESS = 10; // We can make the bottom thinner as it is not much under load.
  THICKNESS = 18;
  BED_LENGTH = 1900;
  BOX_SIZE = [1000, 700, 140 + THICKNESS + BOTTOM_THICKNESS];
  INNER_SIZE = [BOX_SIZE.x - 2 * THICKNESS, BOX_SIZE.y - 2 * THICKNESS, BOX_SIZE.z - THICKNESS - BOTTOM_THICKNESS];

  ymove(-100) {
    // Box
    move([0, 0, 0]) cuboid([BOX_SIZE.x, BOX_SIZE.y, BOTTOM_THICKNESS], align=V_FRONT + V_UP); // bottom
    zmove(BOTTOM_THICKNESS) {
      move([0, -40, 0]) cuboid([INNER_SIZE.x, THICKNESS, INNER_SIZE.z], align=V_FRONT + V_UP); // front
      move([0, -290, 0]) cuboid([INNER_SIZE.x, THICKNESS, INNER_SIZE.z], align=V_BACK + V_UP); // middle
      move([0, -BOX_SIZE.y, 0]) cuboid([INNER_SIZE.x, THICKNESS, INNER_SIZE.z], align=V_BACK + V_UP); // rear

      // left side
      move([-BOX_SIZE.x / 2 + THICKNESS / 2, 0, 0]) difference() {
        cuboid([THICKNESS, BOX_SIZE.y, INNER_SIZE.z], align=V_FRONT + V_UP);
        move([0, 0, THICKNESS]) cuboid([THICKNESS, THICKNESS, INNER_SIZE.z - 2 * THICKNESS], align=V_FRONT + V_UP);
      }

      // right side
      move([BOX_SIZE.x / 2 - THICKNESS / 2, 0, 0]) difference() {
        cuboid([THICKNESS, BOX_SIZE.y, INNER_SIZE.z], align=V_FRONT + V_UP);
        move([0, 0, THICKNESS]) cuboid([THICKNESS, THICKNESS + 20, INNER_SIZE.z - 2 * THICKNESS], align=V_FRONT + V_UP);
      }

      ratio = inclination_ratio < 0.5 ? 1 - 2 * inclination_ratio : 0.0;
      // outer support
      color("blue") ymove(ratio * 1200) difference() {
        union() {
          cuboid([INNER_SIZE.x, THICKNESS, INNER_SIZE.z], align=V_FRONT + V_UP);
          move([-INNER_SIZE.x / 2, -THICKNESS, 0]) cuboid([THICKNESS, INNER_SIZE.y, INNER_SIZE.z], align=V_FRONT + V_UP + V_RIGHT);
          move([INNER_SIZE.x / 2, -THICKNESS, 0]) cuboid([THICKNESS, INNER_SIZE.y, INNER_SIZE.z], align=V_FRONT + V_UP + V_LEFT);
        }
        ymove(-1218) {
          move([0, 100 + THICKNESS, -BOTTOM_THICKNESS]) xrot(7.5) cuboid([1200, 650, 100], align=V_BACK + V_DOWN);
          move([0, 762.43, 74.85]) cuboid([1200, 500, 80], align=V_BACK + V_DOWN); // just a rough guess
        }
      }

      // inner support
      color("green") ymove(ratio * 600) difference() {
        union() {
          ymove(-THICKNESS) cuboid([INNER_SIZE.x - 2 * THICKNESS, THICKNESS, INNER_SIZE.z], align=V_FRONT + V_UP);
          move([-INNER_SIZE.x / 2 + THICKNESS, -THICKNESS * 2, 0]) cuboid([THICKNESS, INNER_SIZE.y - THICKNESS, INNER_SIZE.z], align=V_FRONT + V_UP + V_RIGHT);
          move([INNER_SIZE.x / 2 - THICKNESS, -THICKNESS * 2, 0]) cuboid([THICKNESS, INNER_SIZE.y - THICKNESS, INNER_SIZE.z], align=V_FRONT + V_UP + V_LEFT);
        }
        ymove(-618) {
          move([0, 100 + THICKNESS, -BOTTOM_THICKNESS]) xrot(7.5) cuboid([1200, 650, 100], align=V_BACK + V_DOWN);
          move([0, 762.43, 74.85]) cuboid([1200, 500, 80], align=V_BACK + V_DOWN); // just a rough guess
        }
      }

      // bed boards
      zmove(INNER_SIZE.z) {
        /*color("brown") */cuboid([BOX_SIZE.x, BOX_SIZE.y, THICKNESS], align=V_FRONT + V_UP);
        xrot(180 * inclination_ratio, cp=[0, 0, THICKNESS]) {
          cuboid([BOX_SIZE.x, (BED_LENGTH - BOX_SIZE.y) / 2, THICKNESS], align=V_BACK + V_UP);
          ymove((BED_LENGTH - BOX_SIZE.y) / 2) xrot(-180 * inclination_ratio, cp=[0, 0, 0]) cuboid([BOX_SIZE.x, (BED_LENGTH - BOX_SIZE.y) / 2, THICKNESS], align=V_BACK + V_UP);
        }
      }
    }
  }

  zmove(BOTTOM_THICKNESS) {
    // IKEA Samla boxes for the stuff.
    move([-285, -585, 0]) zrot(90) samla_box(1);
    move([0, -585, 0]) zrot(90) samla_box(1);
    move([285, -585, 0]) zrot(90) samla_box(1);

    move([-285, -270, 0]) zrot(0) samla_box(2);
    move([0, -270, 0]) zrot(0) samla_box(2);
    move([285, -270, 0]) zrot(0) samla_box(2);
  }

  // Euro boxes in the back for the infrastructure.
  move([-300, -950, 0]) euro_box();
  move([300, -950, 0]) euro_box();
}


// A simple variant without hidden parts.
module variant_3(inclination_ratio) {
  BOTTOM_THICKNESS = 10; // We can make the bottom thinner as it is not much under load.
  THICKNESS = 18;
  BED_LENGTH = 1900;
  BOX_SIZE = [1000, 700, 140 + THICKNESS + BOTTOM_THICKNESS];
  INNER_SIZE = [BOX_SIZE.x - 2 * THICKNESS, BOX_SIZE.y - 2 * THICKNESS, BOX_SIZE.z - THICKNESS - BOTTOM_THICKNESS];

  LATH_FRAME_GROOVE_SIZE = [20, 0, 10];
  FRAME_WOOD_SIZE = [40, 0, 40];

  ymove(-100) {
    // Box
    move([0, 0, 0]) cuboid([BOX_SIZE.x, BOX_SIZE.y, BOTTOM_THICKNESS], align=V_FRONT + V_UP); // bottom
    zmove(BOTTOM_THICKNESS) {
      move([0, -40, 0]) cuboid([INNER_SIZE.x, THICKNESS, INNER_SIZE.z], align=V_FRONT + V_UP); // front
      move([0, -290, 0]) cuboid([INNER_SIZE.x, THICKNESS, INNER_SIZE.z], align=V_BACK + V_UP); // middle
      move([0, -BOX_SIZE.y, 0]) cuboid([INNER_SIZE.x, THICKNESS, INNER_SIZE.z], align=V_BACK + V_UP); // rear

      // left side
      move([-BOX_SIZE.x / 2 + THICKNESS / 2, 0, 0]) difference() {
        cuboid([THICKNESS, BOX_SIZE.y, INNER_SIZE.z], align=V_FRONT + V_UP);
        move([0, 0, THICKNESS]) cuboid([THICKNESS, THICKNESS, INNER_SIZE.z - 2 * THICKNESS], align=V_FRONT + V_UP);
      }

      // right side
      move([BOX_SIZE.x / 2 - THICKNESS / 2, 0, 0]) difference() {
        cuboid([THICKNESS, BOX_SIZE.y, INNER_SIZE.z], align=V_FRONT + V_UP);
        move([0, 0, THICKNESS]) cuboid([THICKNESS, THICKNESS + 20, INNER_SIZE.z - 2 * THICKNESS], align=V_FRONT + V_UP);
      }

      ratio = inclination_ratio < 0.5 ? 1 - 2 * inclination_ratio : 0.0;
      // outer support
      /*
      color("blue") ymove(ratio * 1200) difference() {
        union() {
          cuboid([INNER_SIZE.x, THICKNESS, INNER_SIZE.z], align=V_FRONT + V_UP);
          move([-INNER_SIZE.x / 2, -THICKNESS, 0]) cuboid([THICKNESS, INNER_SIZE.y, INNER_SIZE.z], align=V_FRONT + V_UP + V_RIGHT);
          move([INNER_SIZE.x / 2, -THICKNESS, 0]) cuboid([THICKNESS, INNER_SIZE.y, INNER_SIZE.z], align=V_FRONT + V_UP + V_LEFT);
        }
        ymove(-1218) {
          move([0, 100 + THICKNESS, -BOTTOM_THICKNESS]) xrot(7.5) cuboid([1200, 650, 100], align=V_BACK + V_DOWN);
          move([0, 762.43, 74.85]) cuboid([1200, 500, 80], align=V_BACK + V_DOWN); // just a rough guess
        }
      }
      */

      // inner support
      /*
      color("green") ymove(ratio * 600) difference() {
        union() {
          ymove(-THICKNESS) cuboid([INNER_SIZE.x - 2 * THICKNESS, THICKNESS, INNER_SIZE.z], align=V_FRONT + V_UP);
          move([-INNER_SIZE.x / 2 + THICKNESS, -THICKNESS * 2, 0]) cuboid([THICKNESS, INNER_SIZE.y - THICKNESS, INNER_SIZE.z], align=V_FRONT + V_UP + V_RIGHT);
          move([INNER_SIZE.x / 2 - THICKNESS, -THICKNESS * 2, 0]) cuboid([THICKNESS, INNER_SIZE.y - THICKNESS, INNER_SIZE.z], align=V_FRONT + V_UP + V_LEFT);
        }
        ymove(-618) {
          move([0, 100 + THICKNESS, -BOTTOM_THICKNESS]) xrot(7.5) cuboid([1200, 650, 100], align=V_BACK + V_DOWN);
          move([0, 762.43, 74.85]) cuboid([1200, 500, 80], align=V_BACK + V_DOWN); // just a rough guess
        }
      }
      */

      // support frame
      color("green") zmove(BOX_SIZE.z) ymove(250) {
        xmove(-(900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x)) / 2)
          zrot(90 * (1 - ratio), cp=[1 * FRAME_WOOD_SIZE.x, 0 * FRAME_WOOD_SIZE.x, 0])
            cuboid([FRAME_WOOD_SIZE.x, 270, FRAME_WOOD_SIZE.z], align=V_FRONT + V_DOWN + V_RIGHT);
        xmove((900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x)) / 2)
          zrot(-90 * (1 - ratio), cp=[-1 * FRAME_WOOD_SIZE.x, 0 * FRAME_WOOD_SIZE.x, 0])
            cuboid([FRAME_WOOD_SIZE.x, 270, FRAME_WOOD_SIZE.z], align=V_FRONT + V_DOWN + V_LEFT);

        cuboid([900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x), FRAME_WOOD_SIZE.x, FRAME_WOOD_SIZE.z], align=V_BACK + V_DOWN);
        xmove(-(900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x)) / 2)
          zrot(-90 * (1 - ratio), cp=[FRAME_WOOD_SIZE.x, FRAME_WOOD_SIZE.x, 0]) {
            cuboid([FRAME_WOOD_SIZE.x, (900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x)) / 2, FRAME_WOOD_SIZE.z], align=V_BACK + V_DOWN + V_RIGHT);
            ymove((900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x)) / 2)
              zrot(180 * (1 - ratio), cp=[0, 0, 0]) {
                cuboid([FRAME_WOOD_SIZE.x, (900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x)) / 2, FRAME_WOOD_SIZE.z], align=V_BACK + V_DOWN + V_RIGHT);
                ymove((900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x)) / 2)
                  zrot(-90 * (1 - ratio), cp=[1 * FRAME_WOOD_SIZE.x, -1 * FRAME_WOOD_SIZE.x, 0])
                    cuboid([900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x), FRAME_WOOD_SIZE.x, FRAME_WOOD_SIZE.z], align=V_FRONT + V_DOWN + V_RIGHT);
              }
          }
        xmove((900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x)) / 2)
          zrot(90 * (1 - ratio), cp=[-FRAME_WOOD_SIZE.x, FRAME_WOOD_SIZE.x, 0]) {
            cuboid([FRAME_WOOD_SIZE.x, (900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x)) / 2, FRAME_WOOD_SIZE.z], align=V_BACK + V_DOWN + V_LEFT);
            ymove((900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x)) / 2)
              zrot(-180 * (1 - ratio), cp=[0, 0, 0]) cuboid([FRAME_WOOD_SIZE.x, (900 + 2 * (FRAME_WOOD_SIZE.x - LATH_FRAME_GROOVE_SIZE.x)) / 2, FRAME_WOOD_SIZE.z], align=V_BACK + V_DOWN + V_LEFT);
          }
      }

      // bed boards
      zmove(INNER_SIZE.z) {
        /*color("brown") */cuboid([BOX_SIZE.x, BOX_SIZE.y, THICKNESS], align=V_FRONT + V_UP);
        xrot(180 * inclination_ratio, cp=[0, 0, THICKNESS]) {
          //cuboid([BOX_SIZE.x, (BED_LENGTH - BOX_SIZE.y) / 2, THICKNESS], align=V_BACK + V_UP);
          ymove((BED_LENGTH - BOX_SIZE.y) / 2) xrot(-180 * inclination_ratio, cp=[0, 0, 0]) cuboid([BOX_SIZE.x, (BED_LENGTH - BOX_SIZE.y) / 2, THICKNESS], align=V_BACK + V_UP);
        }
      }
    }
  }

  zmove(BOTTOM_THICKNESS) {
    // IKEA Samla boxes for the stuff.
    move([-285, -585, 0]) zrot(90) samla_box(1);
    move([0, -585, 0]) zrot(90) samla_box(1);
    move([285, -585, 0]) zrot(90) samla_box(1);

    move([-285, -270, 0]) zrot(0) samla_box(2);
    move([0, -270, 0]) zrot(0) samla_box(2);
    move([285, -270, 0]) zrot(0) samla_box(2);
  }

  // Euro boxes in the back for the infrastructure.
  move([-300, -950, 0]) euro_box();
  move([300, -950, 0]) euro_box();
}



$t = 0.0;
if ($t < 0.5) {
  back_rest(0.0);
  //variant_1(2.0 * $t);
  variant_3(2.0 * $t);
} else {
  back_rest(2.0 * ($t - 0.5));
  //variant_1(1.0);
  variant_3(1.0);
}
car_floor();
