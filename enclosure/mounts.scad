use <catchnhole/catchnhole.scad>;

// The standoff nuts may be hard to reach as is. Give us some slack in
// actually pushing them into place.
DEFAULT_NUT_HEIGHT_CLEARANCE = 0.1;
DEFAULT_NUT_WIDTH_CLEARANCE = 0.1;

module standoff (d, height, screw_size, ) {
  difference() {
    cylinder(d = d, h = height);
    bolt(screw_size, length = height);
  }
}

module rect (w, l) {
  for (pos = [ [ 0, 0 ], [ w, l ], [ w, 0 ], [ 0, l ] ])
    translate(pos) children();
}

module rect_mounting_bracket (w, l, standoff_d, standoff_height, screw_size, ) {
  rect(w, l) standoff(standoff_d, standoff_height, screw_size);
}

module rect_mounting_bolts (w, l, screw_size, screw_length, countersink = 0) {
  rect(w, l)
    bolt(screw_size, screw_length, kind = "countersunk", countersink = countersink);
}
