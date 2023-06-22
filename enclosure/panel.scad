include <parameters.scad>;
use <mounts.scad>;
use <push-switches/push-switches.scad>;
use <tht-leds/tht-leds.scad>;
use <toggle-switches/toggle-switches.scad>;

e = 10;
print = false;
part = "all";  // ["all", front", "back"]

led_5mm_raster = 2.54;

module tht_led_5mm_mount (channel_l, channel_thickness) {
  tht_led_5mm();

  translate([ led_5mm_raster, -led_5mm_raster / 2, -channel_thickness ])
    rotate([ 0, 0, 90 ]) cube([ led_5mm_raster, channel_l, channel_thickness ]);
}

print_margin = 5;

module panel_slab (x, y, thickness) {
  cube([ x, y, thickness ]);
}

module front_plate (w, l, thickness) {
  difference() {
    union() {
      panel_slab(w, l, thickness);
    }
    translate([ 0, 0, thickness - text_emboss_d ]) panel_annotations();
    panel_components();
  }
}

module back_plate (w, l, thickness) {
  difference() {
    panel_slab(w, l, thickness);
    translate([ 0, 0, thickness ]) panel_components();
  }
}

module panel_assembly (e, w, l, thickness) {
  back_plate(w, l, thickness);
  translate([ 0, 0, thickness + e ]) front_plate(w, l, thickness);
}

module panel_print (w, l, thickness) {
  front_plate(w, l, thickness);
  translate([ 0, l + print_margin, 0 ]) back_plate(w, l, thickness);
}

module panel_components () {
  translate([ standoff_d / 2, standoff_d / 2, 0 ]) rect_mounting_bolts(
    w - standoff_d, l - standoff_d, screw_size, thickness, countersink = 1
  );

  translate([ panel_margin_left, panel_margin_bottom, 0 ]) {
    translate([ 0, 20, 0 ]) {
      rotate([ 0, 0, 90 ]) tht_led_5mm_mount(l, thickness);
    }

    translate([ 20, 0, 0 ]) {
      translate([ 0, 20, 0 ]) rotate([ 0, 0, 90 ]) tht_led_5mm_mount(l, thickness);

      // The arm switch:
      rotate([ 0, 0, 270 ]) mts_toggle_switch();
    }

    // The launch switch:
    translate([ w - 1.95 * panel_margin_left, 8.5, 0 ]) pbs10_push_switch();
  }
}

module t (str_) {
  linear_extrude(text_emboss_d + 0.01)
    text(str_, size = text_size, halign = "center", font = "Liberation Sans:style=Bold");
}

module panel_annotations () {
  translate([ panel_margin_left, panel_margin_bottom, 0 ]) {
    translate([ 0, 13, 0 ]) color("green") t("POWER");

    translate([ 20, 5, 0 ]) color("red") t("ARM");
    translate([ 20, 13, 0 ]) color("yellow") t("ARMED");

    translate([ w - 1.95 * panel_margin_left, 0, 0 ]) color("red") t("LAUNCH");
  }
}

if (print != true)
  panel_assembly(e, w, l, thickness);
else
  panel_print(w, l, thickness);
