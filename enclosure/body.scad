include <parameters.scad>;
include <mounts.scad>;

e = 0.001;

module body (w, l, h, thickness) {
  difference () {
    linear_extrude (h) {
      difference () {
        square([w, l]);
        translate([thickness, thickness])
          square([w - 2 * thickness, l - 2 * thickness]);
      }
    }

    translate([banana_plug_mount_x, l, banana_plug_mount_z]) {
      rotate([90, 0, 0]) {
        translate([-banana_plug_mount_distance / 2, 0, 0])
          cylinder(d = banana_plug_mount_d, h = thickness + e);

        translate([banana_plug_mount_distance / 2, 0, 0])
          cylinder(d = banana_plug_mount_d, h = thickness + e);
      }
    }

    translate([0, (l - power_cable_w) / 2, 0]) {
      cube([thickness, power_cable_w, power_cable_h]);
    }

  }

  translate([standoff_d/2,  standoff_d / 2, 0]) {
    rect_mounting_bracket(w - standoff_d, l - standoff_d, standoff_d, h, screw_size, h);
  }
}
