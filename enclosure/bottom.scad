include <parameters.scad>;

module bottom(w, l, thickness, standoff_height) {
  cube([w, l, thickness]);

  translate([0, 0, thickness]) {
    linear_extrude (standoff_height) {
      difference () {
        square([w, l]);
        translate([thickness, thickness])
          square([w - 2 * thickness, l - 2 * thickness]);
      }
    }

    if ($children >= 1) children();
  }
}
