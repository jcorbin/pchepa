include <BOSL2/screws.scad>
include <BOSL2/std.scad>

// original inspiration <https://www.cleanairkits.com/products/exhalaron>
// cites <https://www.mdpi.com/2075-5309/11/8/329>
// looks similar to <https://www.printables.com/model/386124> -- minimal single
// barrel filter

/// user/customizer parameters

/* [Part Selection] */

mode = 0; // [0:Full Assembly, 1:Base, 2:Cover, 3:Grill]

/* [PC Fan Metrics] */

// <https://superuser.com/questions/225882/what-type-of-screws-are-used-for-computer-fans>
// Apparently they're 7/32" /5.5mm self tapping screws, though some places say
// they're 3/8". I'd note given their design, you should have some leeway since
// the screws cut into the plastic, to use different threads or slightly larger
// screws.

fan_screw = "#4";

fan_size = [ 120, 120, 25 ];

fan_spacing = 5;

fan_id = 116;

fan_screw_spacing = 105;

fan_rounding = 12;

/* [Fan Grill Metrics] */

grill_height = 3;

grill_chamfer = 1;

grill_size = 124;

grill_hole_size = 4;

grill_hole_spacing = 1;

grill_screw = "M3";

grill_screw_head = "flat";

/* [HEPA Filter Metrics] */

filter_od = 7 * 25.4;

filter_id = 6 * 25.4;

filter_height = 5.9 * 25.4;

filter_spacing = 1 * 25.4;

/* [Filter Cover Parameters] */

cover_height = 16;
cover_overhang = 2 + 2;
cover_underhang = 2;

filter_recess = 6;
filter_tolerance = 0.1;

// TODO heatset diam instead
cover_screw_d = struct_val(screw_info(grill_screw), "diameter");
cover_screw_h = 8;

/* [Filter Base Parameters] */

base_height = 20;

base_overhang = 10;

/* [Geometry Detail] */

// Fragment minimum angle
$fa = 4; // 1

// Fragment minimum size
$fs = 0.2; // 0.05

// Epsilon adjustement value for cutouts
$eps = 0.1;

/// dispatch / integration

module __customizer_limit__() {}

cover_od = filter_od + 2*cover_overhang;
base_od = filter_od + 2*base_overhang + filter_recess;

// TODO joinable / duo variant
// TODO wrap around messh wall
// TODO grill might become more of an enclosure shell wrapping around fan sides
// TODO pockets in the base for weights or battery bank

if (mode == 0) {
  // xcopies(spacing=base_od, n=2)

  filter_fan() {
    attach(BOTTOM, TOP, overlap=filter_recess) base();
    attach(TOP, BOTTOM) grill();
  };
}

else if (mode == 1) {
  base() {
    %attach(TOP, BOTTOM, overlap=filter_recess) hepa_filter();
  };
}

else if (mode == 2) {
  cover() {
    %attach(BOTTOM, TOP, overlap=filter_recess) hepa_filter();
    %attach(TOP, BOTTOM) pc_fan();
  };
}

else if (mode == 3) {
  grill() {
    %attach(BOTTOM, TOP) pc_fan();
  };
}

/// implementation

module pc_fan(anchor = CENTER, spin = 0, orient = UP) {
  attachable(size = fan_size, anchor = anchor, spin = spin, orient = orient) {
    diff(remove = "bore screw")
        cuboid(size = fan_size, rounding = fan_rounding, edges = "Z") {
      tag("bore") attach(TOP, TOP, fan_size[2] + $eps)
          cyl(h = fan_size[2] + 2 * $eps, d = fan_id);
      tag("screw") attach(TOP, BOTTOM, overlap = fan_size[2] + $eps)
          grid_copies(spacing = fan_screw_spacing, n = [ 2, 2 ])
              screw_hole(spec = fan_screw, head = "none", thread = false,
                         length = fan_size[2] + 2 * $eps);
    };
    children();
  }
}

module hepa_filter(anchor = CENTER, spin = 0, orient = UP) {
  attachable(h = filter_height, d = filter_od, anchor = anchor, spin = spin,
             orient = orient) {
    diff() cyl(h = filter_height, d = filter_od) {
      attach(TOP, TOP, overlap = filter_height + $eps) tag("remove")
          cyl(h = filter_height + 2 * $eps, d = filter_id);
    };
    children();
  }
}

module cover(anchor = CENTER, spin = 0, orient = UP) {
  attachable(h = cover_height, d = cover_od, anchor = anchor, spin = spin, orient = orient) {

    diff(remove="flow filter screw")
      cyl(h=cover_height, d=cover_od, chamfer2=cover_overhang, chamfer1=cover_underhang) {

        tag("flow")
          attach(TOP, TOP, overlap=cover_height+$eps)
          cyl(h=cover_height+2*$eps, d=fan_id);

        tag("filter")
          attach(BOTTOM, TOP, overlap=filter_recess)
          cyl(h=filter_recess+$eps, d=filter_od + filter_tolerance);

        tag("screw")
          grid_copies(spacing = fan_screw_spacing, n = [ 2, 2 ])
          attach(TOP, BOTTOM, overlap=cover_screw_h)
          cyl(h=cover_screw_h+$eps, d=cover_screw_d);

      };

    children();
  }
}

module base(anchor = CENTER, spin = 0, orient = UP) {
  attachable(h = base_height, d = base_od, anchor = anchor, spin = spin, orient = orient) {

    diff(remove="filter")
      cyl(h=base_height, d=base_od, chamfer2=base_overhang) {

        tag("filter")
          attach(TOP, BOTTOM, overlap=filter_recess)
          cyl(h=filter_recess+$eps, d=filter_od + filter_tolerance);

      };

    children();
  }
}

module filter_fan(anchor = CENTER, spin = 0, orient = UP) {
  height = fan_size[2] + cover_height - filter_recess + filter_height;
  attachable(h = height, d = base_od, anchor = anchor, spin = spin, orient = orient) {

    up(height/2)
    down(fan_size[2])
    down(cover_height/2)
      cover() {
        %attach(BOTTOM, TOP, overlap=filter_recess) hepa_filter();
        %attach(TOP, BOTTOM) pc_fan();
      };

    children();
  }
}

module grill(anchor = CENTER, spin = 0, orient = UP) {
  screw_length = fan_size[2] + grill_height;
  size = [ grill_size, grill_size, grill_height ];
  attachable(size = size, anchor = anchor, spin = spin, orient = orient) {

    diff(remove="screw holes")
      cuboid(size=size, chamfer=grill_chamfer) {

        tag("screw") attach(TOP, BOTTOM, overlap = screw_length + $eps)
            grid_copies(spacing = fan_screw_spacing, n = [ 2, 2 ])
                screw_hole(spec = grill_screw, head = grill_screw_head, thread = false,
                           length = screw_length + 2 * $eps);

        tag("holes")
          attach(TOP, BOTTOM, overlap=size[2] + $eps)
          grid_copies(
            spacing=grill_hole_size + grill_hole_spacing,
            size=grill_size,
            stagger=true,
            inside=circle(d=fan_id)
          )
            zrot(30)
            cyl(h=size[2] + 2*$eps, d=grill_hole_size, $fn=6);

      };

    children();
  }
}
