include <BOSL2/std.scad>
include <BOSL2/joiners.scad>
include <BOSL2/screws.scad>

// original inspiration <https://www.cleanairkits.com/products/exhalaron>
// cites <https://www.mdpi.com/2075-5309/11/8/329>
// looks similar to <https://www.printables.com/model/386124> -- minimal single
// barrel filter

/// user/customizer parameters

/* [Global] */

// Enables display of meeting-part ghosts ; e.g. adjoining base/cover plate counterpart.
buddy = true;

// How big is your printer's printable area?
build_plate_size = [250, 250];

/* [Part Selection] */

//@make -o dual_example.png --colorscheme='Tomorrow Night' -D mode=0 -D filter_count=2 --camera=-2.56,-4.16,-8.15,55.00,0.00,25.00,1151.54
//@make -o dual/parts.stl -D mode=1 -D filter_count=2
//@make -o dual/base.stl -D mode=10 -D filter_count=2 -D base_with_usbc_port=false
//@make -o dual/base_with_usbc_port.stl -D mode=10 -D filter_count=2 -D base_with_usbc_port=true
//@make -o dual/cover.stl -D mode=20 -D filter_count=2
//@make -o dual/grill_box.stl -D mode=30 -D filter_count=2
//@make -o dual/wall_section.stl -D mode=92 -D filter_count=2
//@make -o dual/test_fit_power_module.stl -D mode=101 -D filter_count=2
//@make -o dual/test_fit_wall.stl -D mode=102 -D filter_count=2
//@make -o dual/test_fit_cover_hole.stl -D mode=103 -D filter_count=2

// Which part to model: base / cover / grill / wall / etc...
mode = 0; // [0:Full Assembly, 1:Small Part Kit, 10:Base, 20:Filter Cover/Fan Integration, 30:Fan Grill Box, 90:Rabbit Clip, 91:Base Channel Plug, 92:Wall Section, 100:Dev, 101:Power Module Fit Test, 102:Wall Fit Test, 103:Cover Hole Test]

// How many filter/fan pairs to use ; NOTE currently 2 is the only value that has been tested to work well ; TODO support 1 and 3
filter_count = 2; // [1, 2]

/* [HEPA Filter Metrics] */

// Height of the HEPA filter cylinder.
filter_height = 5.9 * 25.4;

// Outer diameter of the HEPA filter cylinder.
filter_od = 180;
// Nyemo supposedly has a 7inch spec, so 177.8 = 7*25.4, but in reality it measured more like 180mm.

// Inner diameter of the HEPA filter cylinder cavity.
filter_id = 149;

// Thickness of the teardrop grips that hold the filter inside the base and cover plates. You could set this to zero to disable, but then vertical integrity of the assembly is lost, as no other part is currently designed to hold everything together, instead relying on gripping the filter's plastic ledge.
filter_grip = 1;

// Additional space to leave radially between the filter and mesh wrap wall.
filter_extra_space = 0;

// How far the filter will be recessed into the cover and base plates. TODO back out a filter_lip measured parameter.
filter_recess = 10;

// Additional fit tolerance for the cover/base plate filter recess.
filter_tolerance = 0.1;

/* [Wraparound Wall Metrics] */

// Thickness of the mesh wrap wall, radially away from filter center; set to zero to disable mesh wall.
wrapwall_thickness = 1.6;

// Mesh wrap wall slot depth cut into the base/cover plates.
wrapwall_slot_depth = 5;

// Mesh wrap wall slot fit tolerance for the channel cut into the base/cover plates.
wrapwall_tolerance = 0.4;

// Additional tolerance at the open end of the base/cover plate mesh wall slot.
wrapwall_draft = 0.4;

// Auotmatic determination of mesh wall section length, by dividing the total perimeter evenly.
wrapwall_section_limit = build_plate_size.x - 10;

// Manual setting for how many sections the mesh wrap wall will be split into; overrides wrapwall_section_limit perimeter division.
wrapwall_sections = 0;

// Mesh wrap wall sections will use dovetail joiners of this dimension; [w, h, spacing] vector, set either w or h to 0 to disable dovetails.
wrapwall_dovetail = [5, 3, 15];

/* [PC Fan Metrics] */

// Basic dimensions of the fan, default is for a standard 120mm fan.
fan_size = [ 120, 120, 25 ];

// Corner rounding of the fan, cosmetically used for the development ghost, has no effect on produced geometry.
fan_rounding = 7;

// Inner diameter of the fan housing, used to size the cover bore hole, and the grill perforation area.
fan_id = 116.4;

// Screw size of the fan itself, cosmetically used for the development ghost, has no effect on produced geometry.
fan_screw = "#4";

// <https://superuser.com/questions/225882/what-type-of-screws-are-used-for-computer-fans>
// Apparently they're 7/32" /5.5mm self tapping screws, though some places say
// they're 3/8". I'd note given their design, you should have some leeway since
// the screws cut into the plastic, to use different threads or slightly larger
// screws.

// Spacing between fan screw hole centers.
fan_screw_spacing = 105;

/* [Fan Grill Metrics] */

// Amount of padding to add around each side of the fan within the grill box; should be at least enough to allow routing of fan cables.
grill_padding = 5;

// Thickness of grill box walls.
grill_thickness = 3;

// Corner and edge chamfering of the grill box.
grill_chamfer = 5;

// Grill perforation hole size.
grill_hole_size = 4;

// Grill perforation hole spacing.
grill_hole_spacing = 1;

// Grill perforation hole polygon degree (default: hexagon).
grill_hole_degree = 6;

// Grill box mounting screw size, need to be compatible with the fan_screw size; will bolt through grill, fan, and into cover plate.
grill_screw = "M3";

// Head type for the grill box mounting screw, default is flush/countersunk heads.
grill_screw_head = "flat";

// Cutout window size in the extra space area of the grill box between filters; used to allow access to the control module. Set either dimension to 0 to disable.
grill_window = [ 24, 46 ];

/* [Filter Cover Parameters] */

// Overall Z thickness of the cover plate between the filter and fan.
cover_height = 20;

// Upper chamfer size of the cover plate, additional radial space as needed.
cover_overhang = 4;

// Lower chamfer size of the cover plate, additional radial space as needed.
cover_underhang = 0.8;

// How many joiner clips to use in the cover plate.
cover_clips = 4;

// Size of the cover heatset inserts in [diameter, height]; set either to zero to instead use a screw-into-plastic hole.
cover_heatset_hole = [4.4, 5.3];

// Size of wiring pass through hole(s) in the cover plate; set either dimension to zero to disable.
cover_port = [20, 20];

// Placement, along the Y axis of the inner cover plate edge, of any wire pass through holes
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

power_channel_chamfer = 1;

power_channel_plug_tolerance = 0.2;

/// dispatch / integration

module __customizer_limit__() {}

slot_id = filter_od + filter_extra_space + 2*wrapwall_thickness;
slot_od = slot_id + 2*wrapwall_thickness + 2*wrapwall_tolerance;

cover_od = slot_od + 2*max(cover_overhang, cover_underhang);
base_od = slot_od + 2*base_overhang + filter_recess;

grill_size = fan_size.y + 2*( grill_padding + grill_thickness );

cover_extra = filter_count < 2 ? 0 : base_od - cover_od; // FIXME why not /2 like the others
grill_extra = filter_count < 2 ? 0 : (base_od - grill_size)/2;
slot_extra = filter_count < 2 ? 0 : (base_od - slot_od)/2;

cover_hole = cover_heatset_hole.x * cover_heatset_hole.y > 0
  ? cover_heatset_hole
  : [struct_val(screw_info(grill_screw), "diameter") + 0.2, 8];

power_module_size = [
  max(power_pcb_size[0], power_socket_size[0]),
  power_pcb_size[1] + power_socket_overhang,
  power_pcb_size[2] + power_socket_size[2],
];

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

/* [Geometry Detail] */

// Fragment minimum angle.
$fa = 4; // 1

// Fragment minimum size.
$fs = 0.2; // 0.05

// Nudging value used when cutting out (differencing) solids, to avoid coincident face flicker.
$eps = 0.01;

// TODO pockets in the base for weights or battery bank

/// mode[0-9] -- assemblies

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
        attach(BOTTOM, TOP, overlap=filter_recess) base(with_usbc_port=$idx == 0 ? base_with_usbc_port : false);
        right((base_od - grill_size)/4)
        attach(TOP, BOTTOM, overlap=fan_size[2]) grill();
      };
  }

  else {
    assert(false, "base unsupported filter_count");
  }
}

else if (mode == 1) {
  build_plate() {

    if (filter_count == 2 && base_with_usbc_port) {
      xdistribute(sizes=[
        2*clip_length + 1,
        power_channel_plug_size.x,
        2*clip_length + 1,
      ], spacing=1) {
        xcopies(n=2, spacing=clip_length+1)
        attach(TOP, BACK) clip();

        ydistribute(sizes=[
          2*clip_length,
          power_channel_plug_size.y,
          2*clip_length,
        ], spacing=1) {

          xcopies(n=2, spacing=2*clip_length+1)
          zrot(90) attach(TOP, BACK) clip();

          attach(TOP, BOTTOM) base_power_channel_plug();

          xcopies(n=2, spacing=2*clip_length+1)
          zrot(90) attach(TOP, BACK) clip();
        }

        xcopies(n=2, spacing=clip_length+1)
        attach(TOP, BACK) clip();
      }
    }

    else if (filter_count == 2) {
      ycopies(n=2, spacing=2*clip_length+1)
      xcopies(n=4, spacing=clip_length+1)
        attach(TOP, BACK) clip();
    }

  }
}

/// mode[10-19] -- bases

else if (mode == 10) {
  base() {
    %attach(TOP, BOTTOM, overlap=filter_recess) hepa_filter();
  };

  if (filter_count > 1 && buddy) {
    right(base_od) zrot(180)
      %render() base(with_usbc_port=false);

    up(1.5 * clip_depth)
    down(base_height/2)
    fwd(2*clip_width)
    fwd(base_od/2)
    right(base_od/2)
      %render() xcopies(n=base_clips, spacing=clip_length * 2.5) clip(orient=RIGHT, spin = 90);
  }
}

/// mode[20-29] -- tops (i.e. filter/fan integration cover)

else if (mode == 20) {
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

/// mode[30-39] -- fan grills

else if (mode == 30) {
  grill(orient=$preview ? UP : DOWN) {
    left(filter_count == 1 ? 0 : (base_od - grill_size)/4) {
      %attach(BOTTOM, TOP, overlap=fan_size[2]) pc_fan();
      %attach(BOTTOM, TOP) render() cover();
    }
  }
}

// TODO a flat grill plate (alternate to wraparound / foll coverage box

/// mode[90-99] -- spare parts

else if (mode == 90) {
  clip(orient=FWD);
}

else if (mode == 91) {
  base_power_channel_plug();
}

else if (mode == 92) {
  wall_section();
}

/// mode[100...] -- development aids and tests

else if (mode == 100) {
  echo(str("wall ", wall_section(), " x", wall_sections(), " sections"));
  wall_section() {
    show_anchors();
    #cube($parent_size, center=true);
  }
}

else if (mode == 101) {
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

else if (mode == 102) {
  wall_fit_test();
}

else if (mode == 103) {
  cover_hole_test(orient=$preview ? UP : DOWN);
}

/// implementation

module build_plate(size=build_plate_size) {
  size = scalar_vec3(size, 1);
  down(size.z)
  attachable(size=size) {
    %cube(size=size, center=true);
    children();
  }
}

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
    wall_size[0],
    wall_size[0],
  ]) {
    back(cover_size[1]/2)
    back(cover_cut)
      front_half(s=cut_size, y=-cover_cut) cover(orient=DOWN);

    back((base_od/2 - base_cut)/2)
    back(base_cut)
      front_half(s=cut_size, y=-base_cut) base();

    zrot(90) wall_section(base_od - filter_od);
    zrot(90) wall_section(base_od - filter_od);
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
    anchor = anchor, spin = spin, orient = orient)
    children();
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
    clearance=clip_tolerance,
    anchor = anchor, spin = spin, orient = orient)
    children();
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

module base(
  with_usbc_port=base_with_usbc_port,
  anchor = CENTER, spin = 0, orient = UP
) {
  attachable(size = [base_od, base_od, base_height], anchor = anchor, spin = spin, orient = orient) {
    diff(remove="filter wallslot socket port", keep="grip")
      plate(h=base_height, d=base_od, chamfer2=base_overhang) {
        tag("filter")
          attach(TOP, BOTTOM, overlap=filter_recess)
          cyl(h=filter_recess+$eps, d=filter_od + 2*filter_tolerance);

        if (wrapwall_thickness > 0) {
          tag("wallslot")
            right(slot_extra/2 + $eps) // TODO why the rotational assymetry?
            zrot(180)
            attach(TOP, TOP, overlap=wrapwall_slot_depth)
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
        if (with_usbc_port) {
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
          diff() cyl(
            d1 = slot_od + 2*wrapwall_draft,
            d2 = slot_od,
            h = slot_h)
          tag("remove") cyl(
            d1 = slot_id - 2*wrapwall_draft,
            d2 = slot_id,
            h = slot_h + 2*$eps);
        right_half(s=2.01*slot_od, x=-$eps)
          diff() prismoid(
            size1=[base_od + 2*$eps, slot_od + 2*wrapwall_draft],
            size2=[base_od + 2*$eps, slot_od],
            h=slot_h,
            center=true)
          tag("remove") prismoid(
            size1=[base_od + 4*$eps, slot_id - 2*wrapwall_draft],
            size2=[base_od + 4*$eps, slot_id],
            h=slot_h + 2*$eps,
            center=true);
      }

      children();
    }
  }

  else {
    assert(false, "base wallslot not supported for that filter_count");
  }
}

function wall_perim() = let (
  wall_d = filter_od + 3*wrapwall_thickness,
  wall_circ = PI * wall_d,
  wall_leg = base_od/2
) filter_count == 1 ? wall_circ
: filter_count == 2 ? wall_circ + 4*wall_leg
: undef;

function wall_sections() = wrapwall_sections > 0
  ? wrapwall_sections
  : ceil(wall_perim() / wrapwall_section_limit);

function wall_section(w=undef) = [
  default(w, wall_perim() / wall_sections() - 2*wrapwall_tolerance),
  filter_height - 2*filter_recess + 2*wrapwall_slot_depth - 2*wrapwall_tolerance,
  wrapwall_thickness - 2*wrapwall_tolerance
];

module wall_section(w=undef, anchor = CENTER, spin = 0, orient = UP) {
  dovetail_area = wrapwall_dovetail.x * wrapwall_dovetail.y;
  extra = dovetail_area > 0
    ? [wrapwall_dovetail.y, 0, 0]
    : [0, 0, 0];

  wall_size = wall_section(w);
  attachable(size = wall_size + extra, anchor = anchor, spin = spin, orient = orient) {
    translate(-extra/2)
    diff() cube(wall_size, center=true) {
      if (dovetail_area > 0) {
        tag("keep")
        ycopies(l=wall_size.y - wrapwall_dovetail.x, spacing=wrapwall_dovetail.z)
        attach(RIGHT, BOTTOM, overlap=$eps)
          dovetail("male",
            w=wrapwall_dovetail.x,
            h=wrapwall_dovetail.y + $eps,
            thickness=wall_size.z);

        tag("remove")
        ycopies(l=wall_size.y - wrapwall_dovetail.x, spacing=wrapwall_dovetail.z)
        attach(LEFT, TOP, overlap=wrapwall_dovetail.y)
          dovetail("female",
            w=wrapwall_dovetail.x,
            h=wrapwall_dovetail.y + $eps,
            thickness=wall_size.z);

      }
    };

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
              cyl(h=size[2] + 2*$eps, d=grill_hole_size, $fn=grill_hole_degree);

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
