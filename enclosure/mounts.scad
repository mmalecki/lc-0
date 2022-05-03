use <catchnhole/catchnhole.scad>;

// The standoff nuts may be hard to reach as is. Give us some slack in
// actually pushing them into place.
DEFAULT_NUT_HEIGHT_CLEARANCE = 0.1;
DEFAULT_NUT_WIDTH_CLEARANCE = 0.1;

module standoff (d, height, screw_size, screw_length, nut = false, nut_height_clearance = DEFAULT_NUT_HEIGHT_CLEARANCE, nut_width_clearance = DEFAULT_NUT_WIDTH_CLEARANCE) {
  difference () {
    cylinder(d = d, h = height);

    bolt(screw_size, length = screw_length);
    if (nut) nutcatch_sidecut(screw_size, length = d / 2, height_clearance = nut_height_clearance, width_clearance = nut_width_clearance);
  }
}

module rect_mounting_bracket (w, l, standoff_d, standoff_height, screw_size, screw_length, nut = false, nut_height_clearance = DEFAULT_NUT_HEIGHT_CLEARANCE) {
  rotate([0, 0, 45])
    standoff(standoff_d, standoff_height, screw_size, screw_length, nut, nut_height_clearance);

  translate([w, 0, 0])
    rotate([0, 0, 135])
      standoff(standoff_d, standoff_height, screw_size, screw_length, nut, nut_height_clearance);

  translate([w, l, 0])
    rotate([0, 0, 225])
      standoff(standoff_d, standoff_height, screw_size, screw_length, nut, nut_height_clearance);

  translate([0, l, 0]) 
    rotate([0, 0, -45])
      standoff(standoff_d, standoff_height, screw_size, screw_length, nut, nut_height_clearance);
}

module rect_mounting_bolts (w, l, screw_size, screw_length, countersink = 0) {
  bolt(screw_size, screw_length, kind = "countersunk", countersink = countersink);

  translate([w, 0, 0])
    bolt(screw_size, screw_length, kind = "countersunk", countersink = countersink);

  translate([w, l, 0])
    bolt(screw_size, screw_length, kind = "countersunk", countersink = countersink);

  translate([0, l, 0]) 
    bolt(screw_size, screw_length, kind = "countersunk", countersink = countersink);
}
