include <parameters.scad>;
use <body.scad>;
use <bottom.scad>;
use <catchnhole/catchnhole.scad>;
use <mounts.scad>;
use <panel.scad>;
use <push-switches/push-switches.scad>;
use <toggle-switches/toggle-switches.scad>;

e = 10;

module mockup (e = 0) {
  bottom(w, l, thickness, standoff_height);
  translate([ standoff_d / 2, standoff_d / 2, 0 ]) color("red")
    rect_mounting_bolts(w - standoff_d, l - standoff_d, screw_size, screw_l);

  translate([ 0, 0, bottom_height + e ]) {
    body(w, l, body_height, thickness);

    translate([ 0, 0, body_height + e ]) panel_assembly(e, w, l, thickness);
  }
}
mockup(e);
