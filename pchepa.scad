include <BOSL2/std.scad>
include <BOSL2/joiners.scad>
include <BOSL2/screws.scad>

// original inspiration <https://www.cleanairkits.com/products/exhalaron>
// cites <https://www.mdpi.com/2075-5309/11/8/329>
// looks similar to <https://www.printables.com/model/386124> -- minimal single
// barrel filter

/// user/customizer parameters

/* [Part Selection] */

mode = 0; // [0:Full Assembly, 1:Base, 2:Cover, 3:Grill, 10:Rabbit Clips, 11:Base Channel Plug, 12:Wall Section, 20:Spare Parts, 42:Dev, 43:Power Module Fit Test, 44:Wall Fit Test, 45:Cover Hole Test]

filter_count = 1; // [1, 2]
// TODO filter_count = 3

buddy = true;

/* [Wraparound Wall Metrics] */

wrapwall_thickness = 0.4 * 4;

wrapwall_tolerance = 0.4;

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

fan_id = 120 - 2*1.8;

fan_screw_spacing = 105;

fan_rounding = 7;

fan_wire_channel = 0;
fan_wire_channel_chamfer = 3;
fan_wire_inset = 30;

/* [Fan Grill Metrics] */

grill_size = 136;

grill_thickness = 3;

grill_chamfer = 5;

grill_hole_size = 4;

grill_hole_spacing = 1;

grill_screw = "M3";

grill_screw_head = "flat";

grill_window = [ 24, 46 ];

/* [HEPA Filter Metrics] */

// filter_od = 7 * 25.4; // 7 inch spec...
filter_od = 180; // ... but actually need another couple mm

filter_thickness = 31;

filter_id = filter_od - filter_thickness;

filter_grip = 1;

filter_height = 5.9 * 25.4;

filter_spacing = 1 * 25.4;

filter_extra_space = 0;

/* [Filter Cover Parameters] */

cover_height = 20;
cover_overhang = 2 + 2;
cover_underhang = 0.8;
cover_clips = 4;

filter_recess = 10;
filter_tolerance = 0.1;

cover_heatset_hole = [5.0, 4.0];

cover_port = [20, 20];
cover_port_at = [-48, 48];

/* [Filter Base Parameters] */

base_height = 20;

base_overhang = 10;

base_clips = 4;

base_with_usbc_port = true;

/* [Joiner Clip Parameters] */

clip_length = 2 * 7;
clip_width = 2 * 7;
clip_depth = 3;
clip_snap = 0.75;
clip_thick = 1.6;
clip_compress = 0.2;
clip_tolerance = 0.6;

/* [Power Module] */

// Tune for a particular USB-C 12v power trigger module

power_pcb_size = [10.8, 16.25, 1.5];
power_socket_size = [9, 6.8, 3.2];
power_socket_overhang = 1.6;
power_socket_rounding = 1;
power_module_cut = 4;
power_module_porch = 14;
power_module_tolerance = 0.2;

power_module_size = [
  max(power_pcb_size[0], power_socket_size[0]),
  power_pcb_size[1] + power_socket_overhang,
  power_pcb_size[2] + power_socket_size[2],
];

power_channel_chamfer = 1;

power_channel_size = [
  power_pcb_size[0] + 2*power_channel_chamfer,
  sqrt(power_pcb_size[1]^2/2) +
  sqrt(power_pcb_size[2]^2/2) +
  2*power_channel_chamfer,
  100,
];

power_channel_plug_size = [
  power_channel_size[0],
  power_channel_size[1] - 4*power_module_tolerance,
  base_height - power_module_size[2]/2,
];

power_channel_plug_tolerance = 0.2;

/* [Geometry Detail] */

// Fragment minimum angle
$fa = 4; // 1

// Fragment minimum size
$fs = 0.2; // 0.05

// Epsilon adjustement value for cutouts
$eps = 0.01;

/// dispatch / integration

module __customizer_limit__() {}

slot_id = filter_od + filter_extra_space + 2*wrapwall_thickness;
slot_od = slot_id + 2*wrapwall_thickness + 2*wrapwall_tolerance;

cover_od = slot_od + 2*cover_overhang;
base_od = slot_od + 2*base_overhang + filter_recess;

cover_extra = filter_count < 2 ? 0 : base_od - cover_od; // FIXME why not /2 like the others
grill_extra = filter_count < 2 ? 0 : (base_od - grill_size)/2;
slot_extra = filter_count < 2 ? 0 : (base_od - slot_od)/2;

cover_hole = cover_heatset_hole[0] * cover_heatset_hole[1] > 0
  ? cover_heatset_hole
  : [struct_val(screw_info(grill_screw), "diameter") + 0.2, 8];

// TODO pockets in the base for weights or battery bank

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

  if (filter_count > 1 && buddy) {
    right(base_od) zrot(180)
      %render() base();

    up(1.5 * clip_depth)
    down(base_height/2)
    fwd(2*clip_width)
    fwd(base_od/2)
    right(base_od/2)
      %render() xcopies(n=base_clips, spacing=clip_length * 2.5) clip(orient=RIGHT, spin = 90);
  }
}

else if (mode == 2) {
  cover(orient=$preview ? UP : DOWN) {
    %attach(BOTTOM, TOP, overlap=filter_recess) hepa_filter();
    %attach(TOP, BOTTOM) pc_fan();
  };

  if (filter_count > 1 && buddy) {
    right(base_od) zrot(180)
      %render() cover();

    down(1.5 * clip_depth)
    up(cover_height/2)
    fwd(2*clip_width)
    fwd(cover_od/2)
    right(base_od/2)
      %render() xcopies(n=cover_clips, spacing=clip_length * 2.5) clip(orient=RIGHT, spin = 90);
  }
}

else if (mode == 3) {
  grill(orient=$preview ? UP : DOWN) {
    left(filter_count == 1 ? 0 : (base_od - grill_size)/4) {
      %attach(BOTTOM, TOP, overlap=fan_size[2]) pc_fan();
      %attach(BOTTOM, TOP) render() cover();
    }
  }
}

else if (mode == 10) {
  clip(orient=FWD);
}

else if (mode == 11) {
  base_power_channel_plug();
}

else if (mode == 12) {
  wall_section();
}

else if (mode == 20) {
  ycopies(n=2, spacing=2*clip_length+1)
  xcopies(n=4, spacing=clip_length+1)
    clip(orient=BACK, anchor=BOTTOM);

  right((clip_length+1)*2.5)
    base_power_channel_plug(anchor=BOTTOM);
}

else if (mode == 42) {
  cover_hole_test() {
    show_anchors();
    #cube($parent_size, center=true);
  }
}

else if (mode == 43) {
  power_module_fit_test() {
    if (!$preview) {
      fwd(power_channel_chamfer)
      back(power_channel_size[1] / 2)
      left(power_channel_size[0])
      up(power_channel_plug_size[2])
      attach(LEFT+BOTTOM, RIGHT+TOP)
        base_power_channel_plug();
    }
  }
}

else if (mode == 44) {
  wall_fit_test();
}

else if (mode == 45) {
  cover_hole_test(orient=$preview ? UP : DOWN);
}

/// implementation

module cover_hole_test(anchor = CENTER, spin = 0, orient = UP) {
  attachable(size=[
    cover_od/2 + cover_extra/2,
    cover_od/2,
    base_height
  ], anchor = anchor, spin = spin, orient = orient) {
    fwd(cover_od/4)
    right((cover_od + cover_extra)/4)
    back_half(s=base_od*2.1)
    left_half(s=base_od*2.1)
      cover();

    children();
  }
}

module wall_fit_test() {
  cut_size = 2.1*base_od;
  extra = wrapwall_thickness*8 + clip_length;

  cover_cut = cover_od/2 - cover_overhang - extra;
  base_cut = base_od/2 - base_overhang - extra;

  cover_size = [base_od, cover_od/2 - cover_cut, cover_height];
  base_size = [base_od, base_od/2 - base_cut, base_height];
  wall_size = wall_section(base_od - filter_od);

  ydistribute(sizes=[
    cover_size[1],
    base_size[1],
    wall_size[0]
  ]) {
    back(cover_size[1]/2)
    back(cover_cut)
      front_half(s=cut_size, y=-cover_cut) cover(orient=DOWN);

    back((base_od/2 - base_cut)/2)
    back(base_cut)
      front_half(s=cut_size, y=-base_cut) base();

    zrot(90)
      wall_section(base_od - filter_od);
  }

}

module power_module_fit_test(extra = 5, anchor = CENTER, spin = 0, orient = UP) {
  left_cut = base_od - clip_length - (
    $preview
      ? (1.5 * power_module_size[0]/8*7) // tunnel cutaway when previewing
      : (1.5 * power_module_size[0] + extra));
  back_cut = base_od - power_module_size[1] - power_channel_size[1] - extra;

  test_size = [
    base_od - left_cut,
    base_od - back_cut,
    base_height
  ];

  attachable(size = test_size, anchor = anchor, spin = spin, orient = orient) {
    back(back_cut/2)
    left(left_cut/2)
    diff(remove="cut") base() {
      tag("cut")
        attach(LEFT, RIGHT, overlap=left_cut)
        cube([left_cut + $eps, base_od + 2*$eps, base_height + 2*$eps]);
      tag("cut")
        attach(BACK, FRONT, overlap=back_cut)
        cube([base_od + 2*$eps, back_cut + $eps, base_height + 2*$eps]);
    }

    children();
  }
}

module base_power_channel_plug(
  tolerance = power_channel_plug_tolerance,
  anchor = CENTER, spin = 0, orient = UP
) {
  size = power_channel_plug_size - [2*tolerance, 2*tolerance, 0];

  attachable(size = size, anchor = anchor, spin = spin, orient = orient) {
    diff(remove="channel notch")
    cuboid(size, chamfer=power_channel_chamfer - tolerance, edges="Z") {
        tag("channel")
        attach(FRONT, BACK, overlap=size[1] - size[0]/4)
          cuboid([
            size[0]/2,
            size[1] - size[0]/4 + $eps,
            size[2] + 2*$eps
          ], chamfer=power_channel_chamfer - tolerance, edges=[
            [0, 0, 0, 0], // yz -- +- -+ ++
            [0, 0, 0, 0], // xz
            [0, 0, 1, 1], // xy
          ]);

        tag("notch")
        attach(BACK, FRONT, overlap=power_channel_chamfer)
          cuboid([
            size[0]/3,
            power_channel_chamfer + $eps,
            size[2] + 2*$eps
          ], chamfer=power_channel_chamfer - tolerance, edges=[
            [0, 0, 0, 0], // yz -- +- -+ ++
            [0, 0, 0, 0], // xz
            [1, 1, 0, 0], // xy
          ]);

    }

    children();
  }
}

module clip(anchor = CENTER, spin = 0, orient = UP) {
  rabbit_clip(
    type="double",
    length=clip_length,
    width=clip_width,
    snap=clip_snap,
    thickness=clip_thick,
    depth=clip_depth,
    compression=clip_compress,
    anchor = anchor, spin = spin, orient = orient);
}

module clip_socket(anchor = CENTER, spin = 0, orient = UP) {
  rabbit_clip(
    type="socket",
    length=clip_length + $eps,
    width=clip_width,
    snap=clip_snap,
    thickness=clip_thick,
    depth=clip_depth,
    compression=clip_compress,
    clearance = clip_tolerance,
    anchor = anchor, spin = spin, orient = orient);
}

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
  size = [cover_od + cover_extra, cover_od, cover_height];

  attachable(size = size, anchor = anchor, spin = spin, orient = orient) {

    diff(remove="flow filter wallslot screw socket channel port", keep="grip")
      plate(
        h=cover_height, d=cover_od, extra=cover_extra,
        chamfer1=cover_underhang, chamfer2=cover_overhang) {

        tag("flow")
          attach(TOP, TOP, overlap=cover_height+$eps)
          cyl(h=cover_height+2*$eps, d=fan_id);

        tag("filter")
          attach(BOTTOM, TOP, overlap=filter_recess)
          cyl(h=filter_recess+$eps, d=filter_od + 2*filter_tolerance);

        if (wrapwall_thickness > 0) {
          tag("wallslot")
            right((base_od - slot_od)/4 + $eps)
            attach(BOTTOM, TOP, overlap=wrapwall_slot_depth)
            wallslot();
        }

        tag("screw")
          grid_copies(spacing = fan_screw_spacing, n = [ 2, 2 ])
          attach(TOP, BOTTOM, overlap=cover_hole[1])
          cyl(h=cover_hole[1]+$eps, d=cover_hole[0]);

        if (filter_count > 1 && cover_clips > 0) {
          tag("socket")
            down(clip_depth * 1.5)
            up(cover_height / 2)
            ycopies(l=(cover_od - 2*cover_overhang - 1.5 * clip_width), n=cover_clips)
            attach(RIGHT, TOP, overlap=clip_length)
            clip_socket();
        }

        if (fan_wire_channel > 0) {
          channel_length = (base_od - fan_size[0])/2 + fan_wire_inset + fan_wire_channel / 2;

          tag("channel")
            ycopies(n=2, spacing=fan_size[1] - 2*fan_wire_channel)
            up($eps)
            left(channel_length)
            attach(RIGHT + TOP, LEFT + TOP)
            xrot(90)
            cuboid(
              size=[
                channel_length + $eps,
                fan_wire_channel,
                fan_wire_channel + $eps,
              ],
              chamfer=fan_wire_channel_chamfer, edges=[
                [1, 1, 0, 0], // yz -- +- -+ ++
                [1, 0, 0, 0], // xz
                [1, 0, 1, 0], // xy
              ]);
        }

        if (filter_grip > 0) {
          tag("grip")
          zrot_copies(n = 8)
          up(filter_grip)
          left(filter_od/2)
          down(cover_height/2)
            teardrop(
              h = 2*filter_grip,
              r = filter_grip
            );
        }

        if (cover_port[0] * cover_port[1] > 0) {
          port_chamfer = min(cover_port/4);
          port_size = [cover_port[0], cover_port[1], cover_height];

          tag("port")
            ycopies(cover_port_at)
            left(port_size[0] / 2)
            attach(TOP + RIGHT, TOP + LEFT)
            up($eps)
            xrot(90)
              cuboid(port_size + [0, 0, 2*$eps], chamfer=port_chamfer, edges="Z");
        }


      };

    children();
  }
}

module power_module(tolerance=0, profile=false, anchor = CENTER, spin = 0, orient = UP) {
  socket_length = (profile ? power_pcb_size[1] + power_socket_overhang : power_socket_size[1]);
  socket_overlap = socket_length - power_socket_overhang;
  pcb_height = profile
    ? power_pcb_size[2] + power_socket_size[2]/2
    : power_pcb_size[2];

  vtol = [tolerance, tolerance, tolerance];

  attachable(size = power_module_size + 2*vtol, anchor = anchor, spin = spin, orient = orient) {

    down(power_module_size[2]/2)
    up(pcb_height/2)
    back(power_socket_overhang/2 + tolerance)
    cuboid([
      power_pcb_size[0],
      power_pcb_size[1],
      pcb_height
    ] + 2*vtol) {

      down($eps)
      back(socket_overlap)
      down(profile ? power_socket_size[2]/2 : 0)
      attach(FRONT+TOP, BACK+BOTTOM)
      cuboid([
        power_socket_size[0],
        socket_length,
        power_socket_size[2] + $eps,
      ] + 2*vtol,
        rounding=power_socket_rounding + tolerance, edges="Y");

      if (profile && power_module_porch > 0) {
        fwd(power_module_porch + 2*tolerance)
        up(power_module_size[2] + 2*tolerance)
        attach(BACK+BOTTOM, FRONT+TOP)
          cube([
            power_pcb_size[0],
            power_module_porch,
            power_module_size[2],
          ] + 2*vtol);
      }

    }

    children();
  }
}

module base(anchor = CENTER, spin = 0, orient = UP) {
  attachable(h = base_height, d = base_od, anchor = anchor, spin = spin, orient = orient) {
    diff(remove="filter wallslot socket port", keep="grip")
      plate(h=base_height, d=base_od, chamfer2=base_overhang) {
        tag("filter")
          attach(TOP, BOTTOM, overlap=filter_recess)
          cyl(h=filter_recess+$eps, d=filter_od + 2*filter_tolerance);

        if (wrapwall_thickness > 0) {
          tag("wallslot")
            attach(TOP, BOTTOM, overlap=wrapwall_slot_depth)
            wallslot();
        }

        if (filter_count > 1 && base_clips > 0) {
          tag("socket")
            up(clip_depth * 1.5)
            down(base_height / 2)
            ycopies(l=(base_od - 2*base_overhang - 1.5 * clip_width), n=base_clips)
            attach(RIGHT, TOP, overlap=clip_length)
            clip_socket();
        }

        if (filter_grip > 0) {
          tag("grip")
          zrot_copies(n = 8)
          down(filter_grip)
          up(base_height/2)
          left(filter_od/2)
          xrot(180)
            teardrop(
              h = 2*filter_grip,
              r = filter_grip
            );
        }

        // USB C port and wire channel
        if (base_with_usbc_port) {
          tag("port")
            up(power_module_size[2])
            down(base_height/2)
            back(power_module_size[1]) fwd($eps)
            left(power_module_size[0])
            left(clip_length)
            attach(FRONT+RIGHT, BACK)
            yrot(-45)
            power_module(profile=true, tolerance=power_module_tolerance) {

              fwd($eps)
              attach(BACK+BOTTOM, FRONT+BOTTOM) xrot(-90)
                cuboid(power_channel_size, chamfer=power_channel_chamfer, edges="Z");

              cut_size = [
                power_module_size[0] + 2*power_module_tolerance,
                1.5*power_module_cut + 2*power_module_tolerance,
                3*power_module_cut + 2*power_module_tolerance,
              ];

              fwd(sqrt(cut_size[1]^2 + cut_size[2]^2)/2)
              fwd(power_channel_chamfer)
              up(2*power_module_tolerance)
              fwd(power_module_tolerance)
              attach(BACK+TOP, FRONT+BOTTOM)
                xrot(45)
                cube(cut_size)
                  back(power_socket_size[2])
                  up($eps)
                  attach(BOTTOM+FRONT, FRONT+BOTTOM)
                  cube([
                    cut_size[0],
                    power_socket_size[2] + $eps,
                    power_socket_size[2]
                  ]);

              back(2*power_module_tolerance)
              %attach(CENTER, CENTER)
                yrot(180)
                power_module()
                  back(power_module_tolerance)
                  attach(BACK+BOTTOM, FRONT+BOTTOM) 
                  xrot(-90)
                  base_power_channel_plug();

            }
        }

      };

    children();
  }
}

module wallslot(h=undef, anchor = CENTER, spin = 0, orient = UP) {
  slot_h = !is_undef(h) ? h : wrapwall_slot_depth + $eps;

  if (filter_count == 1) {
    attachable(h = slot_h, d = slot_od, anchor = anchor, spin = spin, orient = orient) {
      ring(h = slot_h, id = slot_id, od = slot_od);
      children();
    }
  }

  else if (filter_count == 2) {
    attachable(size = [slot_od + slot_extra + $eps, slot_od, slot_h], anchor = anchor, spin = spin, orient = orient) {
      left((slot_extra + $eps)/2) {
        left_half(s=2.01*slot_od)
          diff() cyl(d = slot_od, h = slot_h)
          tag("remove") cyl(d = slot_id, h = slot_h + 2*$eps);
        right_half(s=2.01*slot_od, x=-$eps)
          diff() cube([base_od + 2*$eps, slot_od, slot_h], center=true)
          tag("remove") cube([base_od + 4*$eps, slot_id, slot_h + 2*$eps], center=true);
      }

      children();
    }
  }

  else {
    assert(false, "base wallslot not supported for that filter_count");
  }
}

function wall_section(w=undef) = let (
  wall_d = filter_od + 3*wrapwall_thickness,
  wall_h = filter_height - 2*filter_recess + 2*wrapwall_slot_depth - 2*wrapwall_tolerance,
  wall_circ = PI * wall_d,
  wall_leg = base_od/2,
  wall_x = !is_undef(w) ? w
    : filter_count == 1 ? wall_circ/2
    : filter_count == 2 ? wall_circ/4 + wall_leg
    : undef
  ) [
    wall_x,
    wall_h - 2*wrapwall_thickness,
    wrapwall_thickness - wrapwall_tolerance
  ];

module wall_section(w=undef, anchor = CENTER, spin = 0, orient = UP) {
  size = wall_section(w);
  attachable(size = size, anchor = anchor, spin = spin, orient = orient) {
    cube(size, center=true);
    children();
  }
}

module plate(h, d, extra=0, chamfer1=0, chamfer2=0, anchor=CENTER, spin=0, orient=UP) {
  r = d/2 - 1/1024;

  if (filter_count == 1) {
    attachable(h = h, d = d, anchor = anchor, spin = spin, orient = orient) {
      cyl(h=h, r=r, chamfer1=chamfer1, chamfer2=chamfer2);
      children();
    }
  }

  else if (filter_count == 2) {
    size = [d + extra, d, h];
    attachable(size = size, anchor = anchor, spin = spin, orient = orient) {
      left(extra/2) {

        left_half(s=2.1*size[0])
          cyl(h=h, r=r, chamfer1=chamfer1, chamfer2=chamfer2);

        right((d/2 + extra)/2)
          if (chamfer1 > 0) {
            upper = max(h/2, chamfer2);
            lower = h - upper;
            up(upper/2)
              cuboid(size=[d/2 + extra + $eps, d, upper], chamfer=chamfer2, edges=[
                [0, 0, 1, 1], // yz -- +- -+ ++
                [0, 0, 0, 0], // xz
                [0, 0, 0, 0], // xy
              ]);
            down(lower/2)
              cuboid(size=[d/2 + extra + $eps, d, lower], chamfer=chamfer1, edges=[
                [1, 1, 0, 0], // yz -- +- -+ ++
                [0, 0, 0, 0], // xz
                [0, 0, 0, 0], // xy
              ]);
          } else {
            cuboid(size=[d/2 + extra + $eps, d, h], chamfer=chamfer2, edges=[
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
  size = [
    grill_size + grill_extra,
    grill_size,
    fan_size[2] + grill_thickness
  ];

  screw_length = fan_size[2] + grill_thickness;

  attachable(size = size, anchor = anchor, spin = spin, orient = orient) {

    diff(remove="screw hollow holes window")
      cuboid(size=size, chamfer=grill_chamfer, edges=[
        [0, 0, 1, 1], // yz -- +- -+ ++
        [0, 0, 1, grill_extra > 0 ? 0 : 1], // xz
        [1, grill_extra > 0 ? 0 : 1, 1, grill_extra > 0 ? 0 : 1], // xy
      ]) {

        tag("hollow")
          right(grill_extra ? grill_thickness + $eps : 0)
          attach(BOTTOM, TOP, overlap=fan_size[2])
          cuboid(size=[
            grill_size + grill_extra - 2 * grill_thickness + (grill_extra > 0 ? grill_thickness + $eps : 0),
            grill_size - 2 * grill_thickness,
            fan_size[2] + $eps,
          ], chamfer = grill_thickness, edges = [
            [0, 0, 1, 1], // yz -- +- -+ ++
            [0, 0, 0, 0], // xz
            [1, grill_extra > 0 ? 0 : 1, 1, grill_extra > 0 ? 0 : 1], // xy
          ]);

        left(grill_extra/2) {

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

        if (grill_window[0] * grill_window[1] > 0) {
          window_size = [
            grill_window[0] + 2 * grill_thickness,
            grill_window[1] + 2 * grill_thickness, 4 *
            grill_thickness
          ];

          tag("window")
            left(window_size[0] / 2)
            up(window_size[2] / 2)
            attach(TOP + RIGHT, TOP + LEFT)
            xrot(90)
              cuboid(window_size + [0, 0, $eps], chamfer=2 * grill_thickness);
        }

      };

    children();
  }
}
