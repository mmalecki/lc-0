use <body.scad>;
use <panel.scad>;
use <mounts.scad>;
use <bottom.scad>;
use <toggle-switches/toggle-switches.scad>;
use <push-switches/push-switches.scad>;
use <catchnhole/catchnhole.scad>;
include <parameters.scad>;


module t (str_) {
  linear_extrude(text_h) text(str_, size = text_size, halign="center", font="Liberation Sans:style=Bold");
}

module panel_annotations () {
  translate([panel_margin_left, panel_margin_bottom, 0]) {
    translate([0, 13, 0]) color("green") t("POWER");

    translate([20, 4.5, 0]) color("red") t("ARM");
    translate([20, 13, 0]) color("yellow") t("ARMED");

    translate([w - 1.95 * panel_margin_left, 0, 0])
      color("red") t("LAUNCH");
  }
}

module panel_components () {
  translate([standoff_d / 2, standoff_d / 2, 0])
    rect_mounting_bolts(w - standoff_d, l - standoff_d, screw_size, thickness, countersink = 1);

  translate([panel_margin_left, panel_margin_bottom, 0]) {
    translate([0, 20, 0]) {
      rotate([0, 0, 90])
        tht_led_5mm_mount(l, thickness);
    }

    translate([20, 0, 0]) {
      translate([0, 20, 0])
        rotate([0, 0, 90])
          tht_led_5mm_mount(l, thickness);

      // The arm switch:
      rotate([0, 0, 270])
        mts_toggle_switch();
    }

    // The launch switch:
    translate([w - 1.95 * panel_margin_left, 8.5, 0])
      pbs10_push_switch();
  }
}

module bottom_components () {

  translate([standoff_d/2,  standoff_d / 2, 0]) {
    rect_mounting_bracket(w - standoff_d, l - standoff_d, standoff_d, standoff_height, screw_size, pcb_mount_screw_l, nut = true);
    color("red")
      rect_mounting_bolts(w - standoff_d, l - standoff_d, screw_size, screw_l);
  }

  translate([(w - pcb_mount_w) / 2, (l - pcb_mount_l) / 2, 0]) {
    rect_mounting_bracket(pcb_mount_w, pcb_mount_l, pcb_standoff_d, standoff_height, screw_size, pcb_mount_screw_l, nut = true);
  }
}

module mockup (exploded = 1) {
  bottom_height = thickness + standoff_height;
  bottom(w, l, thickness, standoff_height)
    bottom_components();

  body_height = h - (3 * thickness + standoff_height);
  translate([0, 0, bottom_height + exploded * thickness]) {
    body(w, l, body_height, thickness);

    translate([0, 0, body_height + exploded * thickness])
      panel_mockup(w, l, thickness) {
        panel_components();
        panel_annotations();
      }
  }
}

mockup(1);
