include <BOSL2/std.scad>
include <BOSL2/joiners.scad>
include <BOSL2/screws.scad>
include <BOSL2/walls.scad>

// original inspiration <https://www.cleanairkits.com/products/exhalaron>
// cites <https://www.mdpi.com/2075-5309/11/8/329>
// looks similar to <https://www.printables.com/model/386124> -- minimal single
// barrel filter

/// user/customizer parameters

/* [Global] */

// Enables display of meeting-part ghosts ; e.g. adjoining base/cover plate counterpart.
buddy = true;

// Enables preview cutaway for some parts.
cutaway = false;

// How big is your printer's printable area?
build_plate_size = [250, 250];

/* [Part Selection] */

//@make -o duo/render.png --colorscheme='Tomorrow Night' --camera=-2.56,-4.16,-8.15,55.00,0.00,25.00,1151.54 -D mode=0 -D filter_count=2

//@make -o duo/base_a.stl -D mode=10 -D filter_count=2
//@make -o duo/base_b.stl -D mode=11 -D filter_count=2

//@make -o duo/cover_a.stl -D mode=20 -D filter_count=2
//@make -o duo/cover_b.stl -D mode=21 -D filter_count=2

//@make -o duo/grill_box_a.stl -D mode=30 -D filter_count=2
//@make -o duo/grill_box_b.stl -D mode=31 -D filter_count=2

//@make -o duo/wall_section.stl -D mode=92 -D filter_count=2

//@make -o test/power_module.stl -D mode=101 -D filter_count=2
//@make -o test/wall.stl -D mode=102 -D filter_count=2
//@make -o test/cover_hole.stl -D mode=103 -D filter_count=2
//@make -o test/joiner_clip.stl -D mode=104

//@make -o parts/duo_kit.stl -D mode=1 -D filter_count=2
//@make -o parts/clip.stl -D mode=90
//@make -o parts/base_channel_plug.stl -D mode=91

// Which part to model: base / cover / grill / wall / etc...
mode = 0; // [0:Full Assembly, 1:Small Part Kit, 10:Base Plate A, 11:Base Plate B, 20:Cover Plate A, 21:Cover Plate B, 30:Grill Box A, 31:Grill Box B, 90:Rabbit Clip, 91:Base Channel Plug, 92:Wall Section, 100:Dev, 101:Power Module Fit Test, 102:Wall Fit Test, 103:Cover Hole Test, 104:Clip Tolerance Test]

// How many filter/fan pairs to use ; NOTE currently 2 is the only value that has been tested to work well ; TODO support 1 and 3
filter_count = 2; // [1, 2]

/* [HEPA Filter Metrics] */

// Height of the HEPA filter cylinder.
filter_height = 5.9 * 25.4;

// Outer diameter of the HEPA filter cylinder.
filter_od = 180;
// Nyemo supposedly has a 7inch spec, so 177.8 = 7*25.4, but in reality it measured more like 180mm.

// Inner diameter of the HEPA filter cylinder cavity.
filter_id = 114;

// Size of the filter lip: X value is the radial wall thickness, Y value is the height.
filter_lip_size = [2, 8];

// Thickness of the teardrop grips that hold the filter inside the base and cover plates. You could set this to zero to disable, but then vertical integrity of the assembly is lost, as no other part is currently designed to hold everything together, instead relying on gripping the filter's plastic ledge.
filter_grip = 1;

// Additional space to leave radially between the filter and mesh wrap wall.
filter_extra_space = 0;

// Additional fit tolerance for the cover/base plate filter recess.
filter_tolerance = 0.1;

/* [Designed Supports] */

// Interface gap between support and supported part.
support_gap = 0.2;

// Bridging gap between supports.
support_every = 15;

// Thickness of support walls and internal struts.
support_width = 0.8;

// Enable to show support walls in preview, otherwise only active in production renders.
$support_preview = false;

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

// Fan grill box preview color.
grill_color = "#22c6b4";

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

// Cover plate preview color.
cover_color = "#22c6b4";

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

// Base plate preview color.
base_color = "#545651";

// Base label cut depth.
base_label_depth = 1;

// Overall Z thickness of the base plate under the filter.
base_height = 20;

// Chamfer size of the base plate, additional radial space as needed.
base_overhang = 10;

// How many joiner clips to use in the base plate.
base_clips = 4;

/* [Joiner Clip Parameters] */

// Size of the joiner BOSL2 rabbit clips used to join base and cover plate pairs: [width, length, depth]
clip_size = [14, 14, 3];

// The snap parameter gives the depth of the clip sides, which controls how easy the clip is to insert and remove.  
clip_snap = 0.75;

// Thickness of the curved line that forms the clip.  
clip_thick = 1.6;

// The clip "ears" are made over-wide by the compression value. A nonzero compression helps make the clip secure in its socket.
clip_compress = 1.0;

// Extra space in the socket for easier insertion.
clip_tolerance = 0.35;

// Clip fit test tolerance range: [start, step, end]
clip_fit_test = [0.2, 0.05, 0.6];

/* [Power Module] */

// Tune for a particular USB-C 12v power trigger module

// Measured size of the USB-C power module PCB.
power_pcb_size = [10.8, 16.25, 1.5];

// Measured size of the power module USB-C female socket itself.
power_socket_size = [9, 6.8, 3.2];

// Edge rounding of the power module USB-C female socket.
power_socket_rounding = 1;

// How far the USB-C socket hangs out past the power module PCB edge.
power_socket_overhang = 1.6;

// How much of solder pad / wiring "porch" to allow at the back of the USB-C power module.
power_module_porch = 14;

// Diagonal cutting factor behind the USB-C power module to allow easy installation.
power_module_cut = 3;

// Fit tolerance for the USB-C power module.
power_module_tolerance = 0.2;

// Edge chamfering for the power module wiring channel.
power_channel_chamfer = 1;

// Fit tolerance for the fixation plug that will fill the power module wiring channel after installation.
power_channel_plug_tolerance = 0.1;

// Offset power channel from back of power module PCB; this helps the channel to miss the wrap wall channel, but needs to be low enough to still keep the USB-C socket pressed forward vs insertion.
power_channel_backset = 0.4;

// Notch in the back of the channel plug, allowing it to flex and be removed by a tool (like pliers).
channel_plug_notch_size = [ 5, 3 ];

/* [Geometry Detail] */

// Fragment minimum angle.
$fa = 4; // 1

// Fragment minimum size.
$fs = 0.2; // 0.05

// Nudging value used when cutting out (differencing) solids, to avoid coincident face flicker.
$eps = 0.01;

/// dispatch / integration

module __customizer_limit__() {}

pchepa_version = ""; // $gitvar$describe$

filter_recess = filter_lip_size[1] + 2*filter_grip;

// So the slot od/id span needs to accomdate wrapwall_thickness, wrapwall_draft, and still provide enoough
// surrounding wall thickness either side of that drafted wallslot channel
slot_inner_wall = 2*wrapwall_thickness;
slot_outer_wall = wrapwall_thickness;
slot_width = wrapwall_thickness > 0 ? wrapwall_thickness + 2*wrapwall_tolerance : 0;
slot_id = filter_od + filter_extra_space + slot_inner_wall;
slot_od = slot_id + slot_width + slot_outer_wall;
wall_d = slot_id/2 + slot_od/2;

cover_od = slot_od + 2*max(cover_overhang, cover_underhang);
base_od = slot_od + 2*base_overhang + filter_recess;

cover_extra = filter_count < 2 ? 0 : base_od - cover_od; // FIXME why not /2 like the others
slot_extra = filter_count < 2 ? 0 : (base_od - slot_od)/2;
wall_extra = (base_od - wall_d)/2;

cover_hole = cover_heatset_hole.x * cover_heatset_hole.y > 0
  ? cover_heatset_hole
  : [struct_val(screw_info(grill_screw), "diameter") + 0.2, 8];

power_channel_size = [
  power_pcb_size[0] + 2*power_channel_chamfer,
  sqrt(power_pcb_size[1]^2/2) +
  sqrt(power_pcb_size[2]^2/2) +
  2*power_channel_chamfer,
];

// TODO pockets in the base for weights or battery bank

/// mode[0-9] -- assemblies

if (mode == 0) {
  if (filter_count == 1) {
    assembly();
  }

  else if (filter_count == 2) {
    left(base_od/2)
    assembly($idx = 0)
    attach(RIGHT, LEFT) assembly($idx = 1);
  }

  else {
    assert(false, "base unsupported filter_count");
  }
}

else if (mode == 1) {
  build_plate() {

    if (filter_count == 2) {
      power_channel_plug_size = channel_plug_size();
      xdistribute(sizes=[
        2*clip_size.y + 1,
        power_channel_plug_size.x,
        2*clip_size.y + 1,
      ], spacing=1) {
        xcopies(n=2, spacing=clip_size.y+1)
        attach(TOP, BACK) clip();

        ydistribute(sizes=[
          2*clip_size.y,
          power_channel_plug_size.y,
          2*clip_size.y,
        ], spacing=1) {

          xcopies(n=2, spacing=2*clip_size.y+1)
          zrot(90) attach(TOP, BACK) clip();

          attach(TOP, BOTTOM) channel_plug();

          xcopies(n=2, spacing=2*clip_size.y+1)
          zrot(90) attach(TOP, BACK) clip();
        }

        xcopies(n=2, spacing=clip_size.y+1)
        attach(TOP, BACK) clip();
      }
    }

    else if (filter_count == 2) {
      ycopies(n=2, spacing=2*clip_size.y+1)
      xcopies(n=4, spacing=clip_size.y+1)
        attach(TOP, BACK) clip();
    }

  }
}

/// mode[10-19] -- bases

else if (mode >= 10 && mode < 20) {
  base_i = mode - 10;
  by = base_i % 2 == 0 ? RIGHT : LEFT;
  bb = base_i % 2 == 0 ? LEFT : RIGHT;

  translate($preview ? bb*base_od/2 : [0, 0, 0])
  preview_cutaway(dir=by)
  recolor(base_color) base($idx = base_i, label = !$preview) recolor(undef) {
    %if (buddy) {

      if (base_i == 0) {
        position("power_module") power_module();
        position("power_channel") channel_plug(anchor=BOTTOM);
      }

      attach(TOP, BOTTOM, overlap=filter_recess) hepa_filter();
    }
  }
}

/// mode[20-29] -- tops (i.e. filter/fan integration cover)

else if (mode >= 20 && mode < 30) {
  cover_i = mode - 20;
  preview_cutaway(dir=FRONT)
  recolor(cover_color)
  cover($idx = cover_i, orient = $preview ? UP : DOWN) recolor(undef) {
    %if (buddy) {
      attach(BOTTOM, TOP, overlap=filter_recess) hepa_filter();

      attach(TOP, "vent_bottom")
      recolor(grill_color) grill($idx=cover_i) recolor(undef) {
        attach("vent_interior", TOP) pc_fan();
      }
    }
  }
}

/// mode[30-39] -- fan grills

else if (mode >= 30 && mode < 40) {
  grill_i = mode - 30;
  preview_cutaway(dir=FRONT)
  recolor(grill_color)
  grill($idx = grill_i, orient=$preview ? UP : DOWN) recolor(undef) {
    %if (buddy) {
      attach("vent_interior", TOP) pc_fan();
      attach("vent_bottom", TOP) render() cover($idx = grill_i);
    }
  }
}

// TODO a flat grill plate (alternate to wraparound / foll coverage box

/// mode[90-99] -- spare parts

else if (mode == 90) {
  clip(orient=FWD);
}

else if (mode == 91) {
  channel_plug();
}

else if (mode == 92) {
  wall_section();
}

/// mode[100...] -- development aids and tests

else if (mode == 100) {
  xdistribute(spacing=clip_size.x*1.5) {
    clip(compression = 2.0, orient=BACK);
    clip(compression = 2.4, orient=BACK);
    clip(compression = 2.8, orient=BACK);
  }
}

else if (mode == 101) {
  preview_cut(RIGHT, t=power_channel_size.x*7/8)
  power_module_fit_test() {
    if (!$preview) {
      fwd(power_channel_chamfer)
      back(power_channel_size.y / 2)
      left(power_channel_size.x)
      up(base_size().z - power_module_size().z/2)
      attach(LEFT+BOTTOM, RIGHT+TOP)
        channel_plug();
    }
  }
}

else if (mode == 102) {
  wall_fit_test();
}

else if (mode == 103) {
  cover_hole_test(orient=$preview ? UP : DOWN);
}

else if (mode == 104) {
  zrot($preview ? 0 : 180)
  preview_cut(FRONT) clip_socket_tolerance_test(
    tolerances=[ for (tol = [ clip_fit_test.x : clip_fit_test.y : clip_fit_test.z ]) tol ],
    orient=$preview ? UP : BACK);
}

/// implementation

module qrcode(file,
  size = undef,
  dat_size = 256,
  range = 100,
  convexity = 5,
  margin = 0,
  anchor = CENTER, spin = 0, orient = UP
) {
  dsize = scalar_vec2(dat_size);
  from_size = [dsize.x, dsize.y, range];
  to_size = default(scalar_vec3(size), from_size);
  marg = scalar_vec3(margin);
  sz = to_size + [ 2*marg.x, 2*marg.y, marg.z ];
  attachable(anchor, spin, orient, size=sz) {
    intersection() {
      up(marg.z/2)
      scale(v_div(to_size, from_size)) {
        down(range/2)
        zrot(-90)
          surface(file = file, center = true, convexity = convexity);
        cube(v_mul(sz, [1, 1, 0.5]), anchor=TOP);
      }

      cube(sz, center=true);
    }

    children();
  }
}

module build_plate(size=build_plate_size, anchor = CENTER, spin = 0, orient = UP) {
  size = scalar_vec3(size, 1);
  down(size.z)
  attachable(anchor, spin, orient, size=size) {
    %cube(size=size, center=true);
    children();
  }
}

// Development cutaway aid
module preview_cut(v=UP, s=max(build_plate_size), t=0) {
  if ($preview && cutaway) {
    half_of(v, s=s)
    translate(scalar_vec3(t))
      children();
  } else {
    children();
  }
}

module assembly(anchor = CENTER, spin = 0, orient = UP) {
  i = default($idx, 0);

  b = base_size();
  g = grill_size();
  over = cover_height - filter_recess + g.z;
  under = b.z - filter_recess;
  h = filter_height + under + over;

  attachable(anchor, spin, orient, size=[b.x, b.y, h]) {
    up((under - over)/2)
    hepa_filter() {

      attach(TOP, BOTTOM, overlap=filter_recess)
        recolor(cover_color) cover($idx=i) {
          attach(TOP, "vent_bottom")
          recolor(grill_color) grill($idx=i)
          recolor(undef) {
            %attach("vent_interior", TOP) pc_fan();
          }
        }

      attach(BOTTOM, TOP, overlap=filter_recess)
        recolor(base_color) base($idx=i, label=!$preview) recolor(undef) {
          if (i == 0) {
            position("power_module") power_module();
            position("power_channel") channel_plug(anchor=BOTTOM);
          }
        }

    }

    children();
  }
}

module cover_hole_test(anchor = CENTER, spin = 0, orient = UP) {
  attachable(anchor, spin, orient, size=[
    (cover_od + cover_extra)/2,
    cover_od/2,
    base_size().z
  ]) {
    fwd(cover_od/4)
    right((cover_od + cover_extra)/4)
    back_half(s=base_od*2.1)
    left_half(s=base_od*2.1)
      cover($idx=0);

    children();
  }
}

module wall_fit_test() {
  cut_size = 2.1*base_od;
  extra = wrapwall_thickness*8 + clip_size.y;

  cover_cut = cover_od/2 - cover_overhang - extra;
  base_cut = base_od/2 - base_overhang - extra;

  cover_size = cover_od/2 - cover_cut;
  base_size = base_od/2 - base_cut;
  wall_len = 50;
  wall_size = wall_section(wall_len).x;

  ydistribute(sizes=[
    cover_size,
    base_size,
    wall_size,
    wall_size,
  ]) {
    back(cover_size/2)
    back(cover_cut)
      front_half(s=cut_size, y=-cover_cut) cover($idx=0, orient=DOWN);

    back((base_od/2 - base_cut)/2)
    back(base_cut)
      front_half(s=cut_size, y=-base_cut) base_plate();

    zrot(90) wall_section(wall_len);
    zrot(90) wall_section(wall_len);
  }
}

module power_module_fit_test(
  label = "",
  extra = 5,
  plate = true,
  socket_lip_chamfer = 0,
  buddies = buddy,
  anchor = CENTER, spin = 0, orient = UP
) {
  left_cut = base_od - clip_size.y - (1.5 * power_module_size().x + extra);
  back_cut = base_od - power_module_size().y - power_channel_size.y - extra;

  test_size = [
    base_od - left_cut,
    base_od - back_cut,
    base_size().z
  ];

  module block() {
    if (plate) {
      back(back_cut/2)
      left(left_cut/2)
      base_plate() children();
    } else {
      cuboid(test_size, chamfer=power_channel_chamfer, edges="Z") children();
    }
  }

  attachable(anchor, spin, orient, size = test_size) {
    diff(remove="cut label port") block() {
      tag("port")
      left(1.5*clip_size.y)
      up(power_module_size().z/2)
      fwd($eps)
      position(FRONT+RIGHT+BOTTOM)
        base_power_port(anchor=FRONT+RIGHT+BOTTOM, lip_chamfer=socket_lip_chamfer)
          if (buddies) {
            %position("module") tag("buddy") power_module();
            %position("channel") tag("buddy") channel_plug(anchor=BOTTOM);
          }

      if (plate) {
        tag("cut")
          attach(LEFT, RIGHT, overlap=left_cut)
          cube([left_cut + $eps, base_od + 2*$eps, test_size.z + 2*$eps]);
        tag("cut")
          attach(BACK, FRONT, overlap=back_cut)
          cube([base_od + 2*$eps, back_cut + $eps, test_size.z + 2*$eps]);
      }

      if (len(label) > 0) {
        tag("label")
          left(test_size.x/2)
          back(test_size.y/2 + power_channel_size.y/4)
          down(1.2)
          position(TOP+FRONT+RIGHT)
          text3d(label, h=1.2 + $eps, size=power_channel_size.y/2, anchor=BOTTOM+LEFT+FRONT);
      }

    }

    children();
  }
}

function channel_plug_size(tolerance = power_channel_plug_tolerance) = [
  power_channel_size.x - 2*tolerance,
  power_channel_size.y - 4*power_module_tolerance - 2*tolerance,
];

module channel_plug(
  h = base_size().z - power_module_size().z/2,
  tolerance = power_channel_plug_tolerance,
  anchor = CENTER, spin = 0, orient = UP
) {
  size = point3d(channel_plug_size(), h);
  notch_wall = 2*power_channel_chamfer;
  channel_size = [
    size.x/2,
    size.y - channel_plug_notch_size.y - notch_wall,
    size.z
  ];
  notch_size = [
    channel_plug_notch_size.x,
    channel_plug_notch_size.y,
    size.z
  ];

  attachable(anchor, spin, orient, size = size) {
    diff(remove="channel notch") cuboid(
      size,
      chamfer=power_channel_chamfer - tolerance,
      edges="Z")
    {
      tag("channel")
      attach(FRONT, BACK, overlap=channel_size.y) cuboid(
        channel_size + [0, $eps, 2*$eps],
        chamfer=power_channel_chamfer - tolerance,
        edges=[
          [0, 0, 0, 0], // yz -- +- -+ ++
          [0, 0, 0, 0], // xz
          [0, 0, 1, 1], // xy
        ]);

      tag("notch")
      attach(BACK, FRONT, overlap=notch_size.y) cuboid(
        notch_size + [0, $eps, 2*$eps],
        chamfer=power_channel_chamfer - tolerance,
        edges=[
          [0, 0, 0, 0], // yz -- +- -+ ++
          [0, 0, 0, 0], // xz
          [1, 1, 0, 0], // xy
        ]);
    }

    children();
  }
}

module if_support() {
  if (!$preview || $support_preview) {
    children();
  }
}

module support_wall(
  h, l,
  gap = support_gap,
  width = support_width,
  anchor = CENTER, spin = 0, orient = UP
) {
  wid = scalar_vec2(width);
  if_support()
  tag("support")
  attachable(anchor, spin, orient, size=[wid.x, l, h]) {
    sparse_wall(
      h=h - 2*gap,
      l=l - 2*gap,
      thick=wid.x,
      strut=wid.y);

    children();
  }
}

module clip(
  thickness = clip_thick,
  snap = clip_snap,
  compression = clip_compress,
  anchor = CENTER, spin = 0, orient = UP
) {
  rabbit_clip(type="double",
    length = clip_size.y,
    width = clip_size.x,
    depth = clip_size.z,
    thickness = thickness,
    snap = snap,
    compression = compression,
    anchor = anchor, spin = spin, orient = orient)
    children();
}

module clip_socket(
  thickness = clip_thick,
  snap = clip_snap,
  compression = clip_compress,
  clearance = clip_tolerance,
  anchor = CENTER, spin = 0, orient = UP
) {

  rabbit_clip(type="socket",
    length = clip_size.y + $eps,
    width = clip_size.x,
    depth = clip_size.z + clearance,
    thickness = thickness,
    snap = snap,
    compression = compression,
    clearance = clearance,
    anchor = anchor, spin = spin, orient = orient) {
      attach(CENTER, CENTER) support_wall(h=clip_size.y, l=clip_size.z);

      children();
    }
}

module clip_socket_tolerance_test(
  tolerances, chamfer=1,
  anchor = CENTER, spin = 0, orient = UP
) {
  max_tol = max(tolerances);
  text_size = clip_size.y/3;
  text_depth = clip_size.z/4;
  block_size = [
    clip_size.x + 2*(clip_compress + max_tol) + 4*chamfer,
    clip_size.z + max_tol + 4*chamfer,
    clip_size.y + 3*chamfer,
  ];
  spacing = block_size.x + 2;

  attachable(anchor, spin, orient, size = [
    spacing*len(tolerances),
    block_size.y,
    block_size.z,
  ]) {
    xcopies(spacing = spacing, n = len(tolerances)) {
      let (tol = tolerances[$idx])  {
        diff(remove="socket label", keep="clip support")
        cuboid(block_size, chamfer=chamfer, edges=[
          [1, 1, 0, 0], // yz -- +- -+ ++
          [1, 1, 0, 0], // xz
          [1, 1, 1, 1], // xy
        ]) {

          tag("socket")
          attach(BOTTOM, TOP, overlap=clip_size.y)
            clip_socket(clearance=tol);

          tag("label")
          attach(FRONT, BOTTOM, overlap=text_depth)
            text3d(str(tol),
              h=text_depth+$eps, size=text_size,
              font="Helvetica:Bold",
              anchor=CENTER, atype="ycenter", spin=$preview ? 0 : 180);

          tag("clip")
            attach(BOTTOM, TOP, overlap=clip_size.y)
            %clip();

        }
      }
    }

    children();
  }
}

module pc_fan(anchor = CENTER, spin = 0, orient = UP) {
  attachable(anchor, spin, orient, size = fan_size) {
    diff(remove = "bore screw")
        cuboid(size = fan_size, rounding = fan_rounding, edges = "Z") {
      tag("bore") attach(TOP, TOP, fan_size.z + $eps)
          cyl(h = fan_size.z + 2 * $eps, d = fan_id);
      tag("screw") attach(TOP, BOTTOM, overlap = fan_size.z + $eps)
          grid_copies(spacing = fan_screw_spacing, n = [ 2, 2 ])
              screw_hole(spec = fan_screw, head = "none", thread = false,
                         length = fan_size.z + 2 * $eps);
    };
    children();
  }
}

module hepa_filter(anchor = CENTER, spin = 0, orient = UP) {
  attachable(anchor, spin, orient, d = filter_od, h = filter_height) {
    recolor("#aaaaaa") tube(
      h=filter_height - 2*filter_lip_size[1] + 2*$eps,
      od=filter_od - 2*filter_lip_size[0],
      id=filter_id + 2*filter_lip_size[0]) {

      attach([TOP, BOTTOM], BOTTOM)
        recolor("#333333")
        tube(h=filter_lip_size[1], od=filter_od, id=filter_id);

    }

    children();
  }
}

module cover(anchor = CENTER, spin = 0, orient = UP) {
  cover_i = $idx;

  size = [cover_od + cover_extra, cover_od, cover_height];

  attachable(anchor, spin, orient, size = size) {

    plate_mirror_idx(cover_i)
    diff(remove="flow filter wallslot screw socket channel port", keep="grip support")
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
          down($eps) position(BOTTOM+RIGHT)
            wallslot(anchor=BOTTOM+RIGHT);
        }

        tag("screw")
          grid_copies(spacing = fan_screw_spacing, n = [ 2, 2 ])
          attach(TOP, BOTTOM, overlap=cover_hole[1])
          cyl(h=cover_hole[1]+$eps, d=cover_hole[0]);

        if (filter_count > 1 && cover_clips > 0) {
            down(clip_size.z * 1.5)
            up(cover_height / 2)
            ycopies(l=(cover_od - 2*cover_overhang - 1.5 * clip_size.x), n=cover_clips)
              tag("socket")
              attach(RIGHT, TOP, overlap=clip_size.y)
              clip_socket();
        }

        if (filter_grip > 0) {
          tag("grip")
          zrot_copies(n = 8)
          up(filter_grip)
          left(filter_od/2)
          down(cover_height/2)
            teardrop(h = 2*filter_grip, r = filter_grip);
        }

        if (cover_port.x * cover_port.y > 0) {
          port_chamfer = min(cover_port/4);
          port_size = [cover_port.x, cover_port.y, cover_height];

          tag("port")
            ycopies(cover_port_at)
            left(port_size[0] / 2)
            attach(TOP + RIGHT, TOP + LEFT)
            up($eps)
            xrot(90)
              cuboid(port_size + [0, 0, 2*$eps], chamfer=port_chamfer, edges="Z");
        }


      }

    children();
  }
}

function power_module_size(tolerance=0) = [
  max(power_pcb_size.x, power_socket_size.x) + 2*tolerance,
  power_pcb_size.y + 2*tolerance + power_socket_overhang + 2*tolerance,
  power_pcb_size.z + 2*tolerance + power_socket_size.z + 2*tolerance
];

module power_module(tolerance=0, profile=false, anchor = CENTER, spin = 0, orient = UP) {
  socket_length = (profile ? power_pcb_size.y + power_socket_overhang : power_socket_size.y);
  socket_overlap = socket_length - power_socket_overhang;
  pcb_height = profile
    ? power_pcb_size.z + power_socket_size.z/2
    : power_pcb_size.z;

  pcb_size = [power_pcb_size.x, power_pcb_size.y, pcb_height] + scalar_vec3(2*tolerance);

  socket_size = [power_socket_size.x, socket_length, power_socket_size.z] + scalar_vec3(2*tolerance);

  size = power_module_size(tolerance);

  pcb_front_anchor = [
    0,
    (-pcb_size.y + power_socket_overhang)/2 + tolerance,
    -size.z/2
  ];

  attachable(anchor, spin, orient,
    size = size,
    anchors = [
      named_anchor("pcb_front_bottom", pcb_front_anchor, FRONT),
      named_anchor("pcb_front_top", pcb_front_anchor + [0, 0, power_pcb_size.z + 2*tolerance], FRONT)
    ]
  ) {

    down(size.z/2 - tolerance)
    up(pcb_height/2)
    back(power_socket_overhang/2 + tolerance)
    cuboid(pcb_size) {

      down($eps)
      back(socket_overlap)
      down(profile ? power_socket_size.z/2 : 0)
      position(FRONT+TOP)
      cuboid(socket_size + [0, 0, $eps],
        anchor=BACK+BOTTOM,
        rounding=power_socket_rounding + tolerance, edges="Y");

      if (profile && power_module_porch > 0) {
        fwd(power_module_porch + 2*tolerance)
        position(BACK+BOTTOM)
          cube([
            power_pcb_size.x + 2*tolerance,
            power_module_porch + 2*tolerance,
            size.z
          ], anchor=FRONT+BOTTOM);
      }

    }

    children();
  }
}

function base_size(h=undef) = let (
  dh = base_height
) [
  base_od,
  base_od,
  default(h, dh)
];

module base_plate(
  h = base_size().z,
  overhang = base_overhang,
  num_clips = base_clips,
  anchor = CENTER, spin = 0, orient = UP
) {
  size = base_size(h);
  attachable(
    anchor, spin, orient,
    size = size,
    anchors = [
      named_anchor("filter", [0, 0, size.z/2 - filter_recess], UP)
    ]
  ) {
    tag_scope("base_plate")
    diff(remove="filter wallslot socket", keep="grip support")
      plate(h=size.z, d=size.x, chamfer2=overhang) {
        tag("filter")
          attach(TOP, BOTTOM, overlap=filter_recess)
          cyl(h=filter_recess+$eps, d=filter_od + 2*filter_tolerance);

        if (wrapwall_thickness > 0) {
          tag("wallslot")
          up($eps)
          position(TOP+RIGHT)
            wallslot(anchor=TOP+RIGHT, zflip=true);
        }

        if (filter_count > 1 && num_clips > 0) {
          zcopies(spacing=[0 - size.z/2])
          ycopies(l=(size.y - 2*overhang - 1.5 * clip_size.x), n=num_clips)
            tag("socket")
            left(clip_size.y/2)
            position(RIGHT+TOP)
            clip_socket(orient=LEFT, spin=90);
        }

        if (filter_grip > 0) {
          tag("grip")
          zrot_copies(n = 8)
          down(filter_grip)
          up(size.z/2)
          left(filter_od/2)
          xrot(180)
            teardrop(h = 2*filter_grip, r = filter_grip);
        }
      };

    children();
  }
}

module plate_mirror_idx(i=$idx) {
  if (i % 2 == 1) {
    xflip() children();
  } else {
    children();
  }
}

module base_label(
  i = 0,
  h = base_label_depth,
  anchor = CENTER, spin = 0, orient = UP
) {
  module txt(mess, size, center = true) {
    text3d(mess,
      h = h,
      font = "Liberation Sans:style=Bold",
      size = size,
      anchor = center ? BOTTOM : BOTTOM+LEFT,
      $fa = 16, $fs = 0.4
    );
  }

  attachable(anchor, spin, orient, d=filter_id, h=h) {
    down(h/2)
    union() {
      if (i == 0) {
        qr_res = 256;
        qr_border = 8;
        qr_size = 60;
        border = qr_size * qr_border / qr_res;

        back(qr_size/2 + border + 1 + 4)
          txt("PCHEPA", size=8);
        fwd(qr_size/2 + border + 1 + 3 + 4)
          txt(pchepa_version, size=6);

        qrcode("user_guide/v1.qr.png",
          size = [qr_size, qr_size, h],
          dat_size = qr_res,
          margin = [border, border, 0],
          range = 100,
          anchor = TOP, orient = DOWN
        );
      }

      else if (i == 1) {
        back(24)
          txt("Replacement Filter:", size=6);
        back(12)
          txt("Nyemo H12 / TT-AP006", size=6);
        fwd(6)
          txt("https://github.com/jcorbin/pchepa", size=5);
        fwd(18)
          txt(pchepa_version, size=6);
      }

      else {
        txt("undefined", size=8);
        fwd(10) txt(str("base_", i), size=8);
      }
    }

    children();
  }
}

module base(label = true, anchor = CENTER, spin = 0, orient = UP) {
  base_i = $idx;

  sz = base_size();

  pms = power_module_size(power_module_tolerance);
  filter_r = filter_od/2 + filter_tolerance;

  // inset just behind clip socket row
  power_port_offset = 1.5*clip_size.y;

  join_side = base_i == 0 ? RIGHT : LEFT;

  attachable(
    anchor, spin, orient,
    size = sz,
    anchors = [

      each(base_i == 0 ? let (
        deets = base_power_port_details(),
        power_bounds = struct_val(deets, "size"),
        power_mod_offset = struct_val(deets, "mod_offset"),
        power_chan_offset = struct_val(deets, "chan_offset"),
        power_port_loc = v_mul(FRONT+BOTTOM, sz/2) + UP*pms.z/2 + join_side*power_port_offset,
        power_mod_loc = translate(v_mul(BACK+UP, power_bounds/2) + power_mod_offset, power_port_loc),
        power_chan_loc = translate(v_mul(BACK+UP, power_bounds/2) + power_chan_offset, power_port_loc)
      ) [
        named_anchor("power_module", power_mod_loc, FRONT),
        named_anchor("power_channel", power_chan_loc, UP)
      ] : [])

    ]
  ) {
    plate_mirror_idx(base_i)
    diff(remove="port label") base_plate() {

      // USB C port and wire channel
      if (base_i == 0) {
        tag("port")
        up(pms.z/2)
        left(power_port_offset)
        position(FRONT+RIGHT+BOTTOM)
          base_power_port(anchor=FRONT+RIGHT+BOTTOM, lip_chamfer=2*power_module_tolerance);
      }

      if (label) {
        tag("label")
        attach("filter", BOTTOM, overlap=base_label_depth)
        plate_mirror_idx(base_i)
          base_label(h = base_label_depth + $eps, i = base_i);
      }

    }

    children();
  }
}

function base_power_port_details(
  channel_h = base_size().z,
  tolerance = power_module_tolerance,
  gap = power_channel_backset
) = let (
  mod_size = power_module_size(tolerance),
  chan_size = point3d(power_channel_size, channel_h),
  size = [
    chan_size.x,
    mod_size.y + gap + chan_size.y,
    channel_h
  ]
) [
  ["size", size],
  ["mod_size", mod_size],
  ["chan_size", chan_size],

  ["mod_offset", [
    0,
    (size.y - mod_size.y)/2 - gap - chan_size.y,
    (mod_size.z - size.z)/2
  ]],

  ["chan_offset", [
    0,
    size.y/2 - chan_size.y/2,
    -size.z/2 + tolerance,
  ]],

  ["cut_size", [
    mod_size.x,
    1.5*power_module_cut + 2*tolerance,
    4*power_module_cut + 2*tolerance
  ]],

  ["fill_size", [
    mod_size.x,
    gap + power_channel_chamfer + 2*$eps,
    mod_size.z
  ]]
];

module base_power_port(
  channel_h = base_size().z,
  tolerance = power_module_tolerance,
  gap = power_channel_backset,
  lip_chamfer = 0,
  anchor = CENTER, spin = 0, orient = UP
) {
  deets = base_power_port_details(channel_h, tolerance, gap);
  mod_offset = struct_val(deets, "mod_offset");
  chan_offset = struct_val(deets, "chan_offset");

  attachable(anchor, spin, orient, size=struct_val(deets, "size"),
    anchors=[
      named_anchor("channel", chan_offset),
      named_anchor("module", mod_offset),
    ]) {

    translate(mod_offset)
    power_module(profile=true, tolerance=tolerance) {

      // front lip back-chamfer
      if (lip_chamfer > $eps) {
        lcw = power_socket_size.x + 2*tolerance;
        lcs = sqrt(2) * lip_chamfer;
        back(sqrt(2) * lcs/2)
        attach("pcb_front_top", BACK+TOP)
          cube([lcw, lcs, lcs], center=true);
      }

      // channel -- vertical shaft, plug goes here
      chan_size = struct_val(deets, "chan_size");
      back(gap)
      position(BACK+BOTTOM)
        cuboid(chan_size, anchor=FRONT+BOTTOM, chamfer=power_channel_chamfer, edges="Z");

      // backfill -- between the channel and back of power module (over any backset)
      fill_size = struct_val(deets, "fill_size");
      position(BACK+BOTTOM)
      fwd($eps)
      cube(fill_size, anchor=FRONT+BOTTOM);

      // diagonal cut -- allows pcb entry and wire egress from rear of pcb
      cut_size = struct_val(deets, "cut_size");
      csdg = sqrt(cut_size.y^2 + (cut_size.z - power_module_cut)^2)/2;
      nudge = power_module_cut/2 - 2*tolerance;
      fwd(csdg + nudge)
      up(csdg - nudge)
      position(BACK+BOTTOM)
        left(cut_size.x/2)
        xrot(-45) cube(cut_size);

    }

    children();
  }
}

function wallarc(
  start = 0,
  end = 1,
  d = wall_d
) = let (

  r = d/2,
  extra = (base_od - d)/2 + $eps,
  outline = turtle([
    "left", 180,
    "move", r + extra,
    "arcright", r, 180,
    "move", r + extra,
  ], state=[r + extra/2, -r]),

  maxlen = path_length(outline),
  start_at = maxlen * start,
  end_at = maxlen * end,

  at_start = approx(start_at, 0, $eps),
  at_end = approx(end_at, maxlen, $eps)

) at_start && at_end ? outline
: at_start ? path_cut(outline, end_at)[0]
: at_end ? path_cut(outline, start_at)[1]
: path_cut(outline, [start_at, end_at])[1];

module wallarc(
  profile,
  start = 0,
  end = 1,
  d = wall_d,
  anchor = CENTER, spin = 0, orient = UP
) {
  outline = wallarc(start, end, d);
  path_sweep(profile, outline, anchor = anchor, spin = spin, orient = orient)
    children();
}

module wallslot(h=undef, zflip = false, anchor = CENTER, spin = 0, orient = UP) {
  slot_h = default(h, wrapwall_slot_depth + $eps);
  w2 = (slot_od - slot_id)/2;
  w1 = w2 + 2*wrapwall_draft;
  dg = sqrt(slot_h^2 + wrapwall_draft^2);
  t1 = acos(wrapwall_draft / dg);
  t2 = 90 - t1;

  profile = apply(zflip ? yflip() : ident(3), turtle([
    "move", w2,
    "right", t1,
    "move", dg,
    "right", 90 + t2,
    "move", w1,
    "right", t1 + 2*t2,
    "move", dg,
  ], state=[-w2/2, slot_h/2]));

  if (filter_count == 1) {
    // TODO use profile
    tube(h = slot_h, id = slot_id, od = slot_od, anchor = anchor, spin = spin, orient = orient)
      children();
  }

  else if (filter_count == 2) {
    wallarc(profile, anchor = anchor, spin = spin, orient = orient)
      children();
  }

  else {
    assert(false, "base wallslot not supported for that filter_count");
  }
}

function wall_perim() = let (
  wall_circ = PI * wall_d,
  wall_leg = base_od/2
) filter_count == 1 ? wall_circ
: filter_count == 2 ? wall_circ + 4*wall_leg
: undef;

function even_ceil(n) = 2*ceil(n/2);

// NOTE: rounding wall_sections up to an even number avoids placing a dovetail joint at the greastest point of bend
function wall_sections() = wrapwall_sections > 0
  ? wrapwall_sections
  : even_ceil(ceil(wall_perim() / wrapwall_section_limit));

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
  attachable(anchor, spin, orient, size = wall_size + extra) {
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
    cyl(h=h, r=r, chamfer1=chamfer1, chamfer2=chamfer2, anchor = anchor, spin = spin, orient = orient)
      children();
  }

  else if (filter_count == 2) {
    outline = turtle([
      "left", 180,
      "move", r + extra,
      "arcright", r, 180,
      "move", r + extra,
    ], state=[r + extra/2, -r]);

    profile = turtle([
      "right", 45,
      "move", sqrt(2)*chamfer2,
      "right", 45,
      "move", h - chamfer1 - chamfer2,
      "right", 45,
      "move", sqrt(2)*chamfer1,
    ], state=[
      [[-chamfer2, h/2]],
      [1, 0],
      90, 0
    ]);

    attachable(anchor, spin, orient, size = [d + extra, d, h]) {
      hull() path_sweep(profile, outline);

      children();
    }
  }

  else {
    assert(false, "base unsupported filter_count");
  }
}

function grill_size() = let (
  d = fan_size.y + 2*grill_padding + 2*grill_thickness,
  extra = filter_count < 2 ? 0 : (base_od - d)/2
) [
  d + extra,
  d,
  fan_size.z + grill_thickness
];

module grill_block(
  remove = "remove",
  keep = "keep",
  size = undef,
  chamfer = grill_chamfer,
  anchor = CENTER, spin = 0, orient = UP
) {
  sz = default(size, grill_size());
  extra = sz.x - sz.y;
  diff(remove=remove, keep=keep)
  conv_hull(str(remove, " ", keep))
    cuboid(size=sz, chamfer=chamfer, edges=[
      [0, 0, 1, 1], // yz -- +- -+ ++
      [0, 0, 1, extra > 0 ? 0 : 1], // xz
      [1, extra > 0 ? 0 : 1, 1, extra > 0 ? 0 : 1], // xy
    ]) children();
}

module grill(
  chamfer = grill_chamfer,
  anchor = CENTER, spin = 0, orient = UP
) {
  grill_i = $idx;

  size = grill_size();
  extra = size.x - size.y;

  inner_h = size.z - grill_thickness;
  screw_length = inner_h + grill_thickness;

  vent_loc = [extra/2 * (grill_i == 0 ? -1 : 1), 0, size.z/2];

  screw_hole_tops = grid_copies(p = vent_loc, spacing = fan_screw_spacing, n = [ 2, 2 ]);

  attachable(
    anchor, spin, orient,
    size = size,
    anchors = [
      named_anchor("vent_exterior", vent_loc, UP),
      named_anchor("vent_interior", vent_loc + grill_thickness*DOWN, DOWN),
      named_anchor("vent_bottom", vent_loc + size.z*DOWN, DOWN),
      each([
        for (i = idx(screw_hole_tops))
        named_anchor(str("screw_hole_", i), screw_hole_tops[i], DOWN)]),
    ]
  ) {
    plate_mirror_idx(grill_i)
    grill_block(size=size, remove="screw hollow vent window") {

      tag("hollow")
        right(extra ? grill_thickness + $eps : 0)
        attach(BOTTOM, TOP, overlap=inner_h)
        cuboid(size=[
          size.x - 2 * grill_thickness + (extra > 0 ? grill_thickness + $eps : 0),
          size.y - 2 * grill_thickness,
          inner_h + $eps,
        ], chamfer = grill_thickness, edges = [
          [0, 0, 1, 1], // yz -- +- -+ ++
          [0, 0, 0, 0], // xz
          [1, extra > 0 ? 0 : 1, 1, extra > 0 ? 0 : 1], // xy
        ]);

      left(extra/2) {

        tag("screw")
          attach(TOP, BOTTOM, overlap = screw_length + $eps)
            grid_copies(spacing = fan_screw_spacing, n = [ 2, 2 ])
                screw_hole(spec = grill_screw, head = grill_screw_head, thread = false,
                           length = screw_length + 2 * $eps);

        tag("vent")
          attach(TOP, BOTTOM, overlap=size[2] + $eps)
          grid_copies(
            spacing=grill_hole_size + grill_hole_spacing,
            size=size.y,
            stagger=true,
            inside=circle(d=fan_id)
          )
            zrot(30)
            cyl(h=size[2] + 2*$eps, d=grill_hole_size, $fn=grill_hole_degree);

      }

      if (filter_count > 1 && grill_window[0] * grill_window[1] > 0) {
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

    }

    children();
  }
}

module preview_cutaway(dir=BACK, at=0, r=[0, 0, 0], s=max(base_od, filter_height)*2.1) {
  if (cutaway && $preview) {
    difference() {
      rotate(r)
      children();
      translate(dir*(at - s/2))
        cube(s, center=true);
    }
  } else {
    children();
  }
}

function scalar_vec2(v, dflt) =
  is_undef(v)? undef :
  is_list(v)? [for (i=[0:1]) default(v[i], default(dflt, 0))] :
  !is_undef(dflt)? [v,dflt] : [v,v];
