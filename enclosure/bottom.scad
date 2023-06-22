include <parameters.scad>;
use <catchnhole/catchnhole.scad>
use <mounts.scad>;

module bottom (w, l, thickness, standoff_height) {
  difference() {
    cube([ w, l, thickness ]);
    translate([ standoff_d / 2, standoff_d / 2, 0 ]) {
      rect(w - standoff_d, l - standoff_d) {
        nutcatch_parallel(screw_size);
        bolt(screw_size, length = standoff_height);
      }
    }
    translate([ (w - pcb_mount_w) / 2, (l - pcb_mount_l) / 2, 0 ]) {
      rect(pcb_mount_w, pcb_mount_l) {
        nutcatch_parallel(screw_size);
        bolt(screw_size, length = standoff_height);
      }
    }
  }

  translate([ 0, 0, thickness ]) {
    linear_extrude(standoff_height) {
      difference() {
        square([ w, l ]);
        translate([ thickness, thickness ])
          square([ w - 2 * thickness, l - 2 * thickness ]);
      }
    }

    translate([ standoff_d / 2, standoff_d / 2, 0 ]) {
      rect_mounting_bracket(
        w - standoff_d, l - standoff_d, standoff_d, standoff_height, screw_size
      );
    }

    translate([ (w - pcb_mount_w) / 2, (l - pcb_mount_l) / 2, 0 ]) {
      rect(pcb_mount_w, pcb_mount_l) {
        standoff(pcb_standoff_d, standoff_height, screw_size);
      }
    }
  }
}

bottom(w, l, thickness, standoff_height);
