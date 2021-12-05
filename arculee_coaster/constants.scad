TOP_PLATE = 0;
UPPER_BODY = 1;
LOWER_BODY = 2;
SCREW = 3;
NUT = 4;
WHEEL = 5;
WHEEL_UNIT = 6;
PLATE_DEPRESSOR = 7;
SKIN = 8;

WHEEL_THICKNESS = 5;
WHEEL_RADIAL_TOLERANCE = 1;
WHEEL_AXIAL_TOLERANCE = 0.5;

SKIN_WIDTH = 94;  // 753;
SKIN_LENGTH = 100;  // 803;
SKIN_HEIGHT = 15;  // 120;
SKIN_WIDTH_MARGIN = 8.5;  // 67;
SKIN_LENGTH_MARGIN = 9.0;  // 72;
width_margin = 13;
length_margin = 14;

WALL_THICKNESS = 3.75; // 30;
VERTICAL_EDGE_RADIUS = 3.5;  // 25;
TOLERANCE = 0.2;  // 10;
BODY_WIDTH = SKIN_WIDTH - 2 * WALL_THICKNESS - TOLERANCE;
BODY_LENGTH = SKIN_LENGTH - 2 * WALL_THICKNESS - TOLERANCE;
BODY_HEIGHT = 28;  // 227;

WHEEL_DIAMETER = 12;

RADIAL_SLACK = 1;
AXIAL_SLACK = 1;

SCREW_HEAD_OUTER_DIAMETER = 30;
SCREW_HEAD_INNER_DIAMETER = 21;
SCREW_HEAD_THICKNESS = 2;

SCREW_THREAD_DIAMETER = 17;
MUG_DIAMETER = 82;

TOP_FILLET_RADIUS = 1;


VISIBILITY_MASK = (
    0 * (1 * bitwise_lsh(1, WHEEL_UNIT) + 1 * bitwise_lsh(1, NUT) + 1 * bitwise_lsh(1, LOWER_BODY)) +
    0 * (1 * bitwise_lsh(1, TOP_PLATE) + 1 * bitwise_lsh(1, UPPER_BODY) + 1 * bitwise_lsh(1, PLATE_DEPRESSOR)) +
    0 * (1 * bitwise_lsh(1, TOP_PLATE)) +
    0 * (1 * bitwise_lsh(1, SKIN)) +
    1 * (1 * bitwise_lsh(1, UPPER_BODY)) +
    1 * (1 * bitwise_lsh(1, SCREW)) +
    0
);


FN = 122;