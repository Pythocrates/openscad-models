// This is a set of filament spool based organizer elements.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

FN = 120;
HFN = 360;


module my_text() {
  text("KLUSA", spacing=1, halign="center");
  ymove(-0.2) text("DAY", spacing=1.2, valign="top", halign="center");
}

color("blue") my_text();
