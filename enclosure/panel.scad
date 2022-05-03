use <tht-leds/tht-leds.scad>;

led_5mm_raster = 2.54;

module tht_led_5mm_mount (channel_l, channel_thickness) {
  tht_led_5mm();

  translate([led_5mm_raster, -led_5mm_raster / 2, -channel_thickness])
    rotate([0, 0, 90]) cube([led_5mm_raster, channel_l, channel_thickness]);
}

print_margin = 5;

module panel_slab (x, y, thickness) {
  cube([x, y, thickness]);
}

module front_plate (w, l, thickness) {
  difference () {
    union () {
      panel_slab(w, l, thickness);
      if ($children >= 2) translate([0, 0, thickness]) children(1);
    }
    children(0);
  }
}

module back_plate (w, l, thickness) {
  difference () {
    panel_slab(w, l, thickness);
    translate([0, 0, thickness]) children(0);
  }
}

module panel_mockup (w, l, thickness) {
  translate([0, 0, thickness]) {
    front_plate(w, l, thickness) children(0);

    color("blue") children(0);
    if ($children >= 2)
      translate([0, 0, thickness]) children(1);
  }
  back_plate(w, l, thickness) children(0);
}

module panel_print (w, l, thickness) {
  front_plate(w, l, thickness) {
    // Components
    children(0);

    // Annotations
    if ($children >= 2) children(1);
  }
  translate([0, l + print_margin, 0]) back_plate(w, l, thickness) children(0);
}
