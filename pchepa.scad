include <BOSL2/screws.scad>
include <BOSL2/std.scad>

// original inspiration <https://www.cleanairkits.com/products/exhalaron>
// cites <https://www.mdpi.com/2075-5309/11/8/329>
// looks similar to <https://www.printables.com/model/386124> -- minimal single
// barrel filter

/// user/customizer parameters

/* [Part Selection] */

mode = 0; // [0:Full Assembly, 1:Base, 2:Cover, 3:Grill]

filter_count = 1; // [1, 2]
// TODO filter_count = 3

/* [Wraparound Wall Metrics] */

wrapwall_thickness = 0.4 * 4;

wrapwall_slot_depth = 5;

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

grill_size = 128;

grill_thickness = 3;

grill_chamfer = 5;

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

cover_od = filter_od + 2*wrapwall_thickness + 2*cover_overhang;
base_od = filter_od + 2*wrapwall_thickness + 2*base_overhang + filter_recess;

// TODO joinery
// TODO pockets in the base for weights or battery bank
// TODO wire passthru holes in the cover and base plates for battery integration
// TODO model mode to generate wraparoudn wall panel

if (mode == 0) {
  // xcopies(spacing=base_od, n=2)

  if (filter_count == 1) {
    filter_fan() {
      attach(BOTTOM, TOP, overlap=filter_recess) base();
      attach(TOP, BOTTOM, overlap=fan_size[2]) grill();
    };
  }

  else if (filter_count == 2) {
    xcopies(spacing=base_od, n=2) zrot(180 * $idx)
      filter_fan() {
        attach(BOTTOM, TOP, overlap=filter_recess) base();
        right((base_od - grill_size)/4)
        attach(TOP, BOTTOM, overlap=fan_size[2]) grill();
      };
  }

  else {
    assert(false, "base unsupported filter_count");
  }
}

else if (mode == 1) {
  base() {
    %attach(TOP, BOTTOM, overlap=filter_recess) hepa_filter();
  };
  if (filter_count > 1) {
    right(base_od) zrot(180)
      %render() base();
  }
}

else if (mode == 2) {
  cover() {
    %attach(BOTTOM, TOP, overlap=filter_recess) hepa_filter();
    %attach(TOP, BOTTOM) pc_fan();
  };
  if (filter_count > 1) {
    right(base_od) zrot(180)
      %render() cover();
  }
}

else if (mode == 3) {
  grill() {
    left(filter_count == 1 ? 0 : (base_od - grill_size)/4) {
      %attach(BOTTOM, TOP, overlap=fan_size[2]) pc_fan();
      %attach(BOTTOM, TOP) render() cover();
    }
  }
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
  extra = filter_count == 0 ? 0 : (base_od - cover_od)/2;
  size = [cover_od + extra, cover_od, cover_height];

  attachable(size = size, anchor = anchor, spin = spin, orient = orient) {

    diff(remove="flow filter wallslot screw")
      plate(
        h=cover_height, d=cover_od, extra=extra,
        chamfer1=cover_underhang, chamfer2=cover_overhang) {

        tag("flow")
          attach(TOP, TOP, overlap=cover_height+$eps)
          cyl(h=cover_height+2*$eps, d=fan_id);

        tag("filter")
          attach(BOTTOM, TOP, overlap=filter_recess)
          cyl(h=filter_recess+$eps, d=filter_od + filter_tolerance);

        if (wrapwall_thickness > 0) {
          tag("wallslot")
            attach(BOTTOM, TOP, overlap=wrapwall_slot_depth)
            wallslot();
        }

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
    diff(remove="filter wallslot")
      plate(h=base_height, d=base_od, chamfer2=base_overhang) {
        tag("filter")
          attach(TOP, BOTTOM, overlap=filter_recess)
          cyl(h=filter_recess+$eps, d=filter_od + filter_tolerance);

        if (wrapwall_thickness > 0) {
          tag("wallslot")
            attach(TOP, BOTTOM, overlap=wrapwall_slot_depth)
            wallslot();
        }

      };

    children();
  }
}

module wallslot(anchor = CENTER, spin = 0, orient = UP) {
  slot_h = wrapwall_slot_depth + $eps;
  slot_id = filter_od + 2*wrapwall_thickness;
  slot_od = filter_od + 4*wrapwall_thickness;

  if (filter_count == 1) {
    attachable(h = slot_h, d = slot_od, anchor = anchor, spin = spin, orient = orient) {
      ring(h = slot_h, id = slot_id, od = slot_od);
      children();
    }
  } 

  else if (filter_count == 2) {
    extra = (base_od - slot_od)/2;
    attachable(size = [
      slot_od + extra,
      slot_od,
      slot_h,
    ], anchor = anchor, spin = spin, orient = orient) {

      union() {
        diff() ring(h = slot_h, id = slot_id, od = slot_od) {
          attach(RIGHT, LEFT, overlap=slot_od/2)
            tag("remove") cube(size = [
              slot_od/2 + $eps,
              slot_od + 2*$eps,
              slot_h + 2*$eps,
            ]);
        };

        right(base_od/4 + $eps)
          ycopies(spacing=slot_od - wrapwall_thickness-$eps, n=2)
          cube(size = [
            base_od/2 + 3*$eps,
            wrapwall_thickness,
            slot_h,
          ], center=true);
      }

      children();
    } 
  }

  else {
    assert(false, "base wallslot not supported for that filter_count");
  }
}

module ring(id, od, h, anchor = CENTER, spin = 0, orient = UP) {
  attachable(h = h, d = od, anchor = anchor, spin = spin, orient = orient) {
    tag_scope("ring") diff() cyl(h = h, d = od)  {
      tag("remove")
        attach(TOP, BOTTOM, overlap=h + $eps)
        cyl(h = h + 2*$eps, d = id);
    }
    children();
  }
}

module plate(h, d, extra=0, chamfer1=0, chamfer2=0, anchor = CENTER, spin = 0, orient = UP) {
  if (filter_count == 1) {
    attachable(h = h, d = d, anchor = anchor, spin = spin, orient = orient) {
      cyl(h=h, d=d, chamfer1=chamfer1, chamfer2=chamfer2);
      children();
    }
  }

  else if (filter_count == 2) {
    size = [d + extra, d, h];
    attachable(size = size, anchor = anchor, spin = spin, orient = orient) {
      union() {
        left(extra/2)
          cyl(h=h, d=d, chamfer1=chamfer1, chamfer2=chamfer2);

        right(extra/2)
        right(d/4)
          if (chamfer1 > 0) {
            upper = max(h/2, chamfer2);
            lower = h - upper;

            up(upper/2)
              cuboid(size=[d/2 + extra, d, upper], chamfer=chamfer2, edges=[
                [0, 0, 1, 1], // yz -- +- -+ ++
                [0, 0, 0, 0], // xz
                [0, 0, 0, 0], // xy
              ]);

            down(lower/2)
              cuboid(size=[d/2 + extra, d, lower], chamfer=chamfer1, edges=[
                [1, 1, 0, 0], // yz -- +- -+ ++
                [0, 0, 0, 0], // xz
                [0, 0, 0, 0], // xy
              ]);
          } else {
            cuboid(size=[d/2 + extra, d, h], chamfer=chamfer2, edges=[
              [0, 0, 1, 1], // yz -- +- -+ ++
              [0, 0, 0, 0], // xz
              [0, 0, 0, 0], // xy
            ]);
          }
      }

      children();
    }
  }

  else {
    assert(false, "base unsupported filter_count");
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
  extra = filter_count == 1 ? 0 : (base_od - grill_size)/2;
  size = [
    grill_size + extra,
    grill_size,
    fan_size[2] + grill_thickness
  ];

  screw_length = fan_size[2] + grill_thickness;

  attachable(size = size, anchor = anchor, spin = spin, orient = orient) {

    diff(remove="screw hollow holes")
      cuboid(size=size, chamfer=grill_chamfer, edges = [
        [0, 0, 1, 1], // yz -- +- -+ ++
        [0, 0, 1, extra > 0 ? 0 : 1], // xz
        [1, extra > 0 ? 0 : 1, 1, extra > 0 ? 0 : 1], // xy
      ]) {

        tag("hollow")
          right(extra ? grill_thickness + $eps : 0)
          attach(BOTTOM, TOP, overlap=fan_size[2])
          cuboid(size=[
            grill_size + extra - 2 * grill_thickness + (extra > 0 ? grill_thickness + $eps : 0),
            grill_size - 2 * grill_thickness,
            fan_size[2] + $eps,
          ], chamfer = grill_thickness, edges =[
            [0, 0, 0, 0], // yz -- +- -+ ++
            [0, 0, 0, 0], // xz
            [1, extra > 0 ? 0 : 1, 1, extra > 0 ? 0 : 1], // xy
          ]);

        left(extra/2) {

          tag("screw")
            attach(TOP, BOTTOM, overlap = screw_length + $eps)
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

        }
      };

    children();
  }
}