// R = 6.85; T = 0.5; H = 2.35; // Martin's room. Just cut through, do not cut out anything. Clicks.
// R = 6.85; T = 0.5; H = 2.35; // Bedroom left. Just cut through, do not cut out anything. Friction only.
//R = 7.20; T = 0.5; H = 2.45; // Living room left. Just cut through, do not cut out anything.
R = 7.30; T = 0.7; H = 2.45; // Experiment with oversize for better click-locking. Living room right. Just cut through, do not cut out anything.


difference() {
    union() {
        cylinder(r=R, h=H, $fn=180, center=true);
    }
    union() {
        cylinder(r=R - T, h=H, $fn=180, center=true);
        //translate([-6, 0, 0]) cube([4, 4, 4], center=true);
    }
}
