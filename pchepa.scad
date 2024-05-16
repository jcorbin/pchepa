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

//@make -o duo/render.png --colorscheme='Tomorrow Night' --camera=-2.56,-4.16,-8.15,55.00,0.00,25.00,1151.54 -D mode=0 -D filter_count=2 -D base_embed_power_bank=true

//@make -o duo/base_a.stl -D mode=10 -D filter_count=2
//@make -o duo/base_b.stl -D mode=11 -D filter_count=2

//@make -o duo/base_bank_a.stl -D mode=10 -D filter_count=2 -D base_embed_power_bank=true
//@make -o duo/base_bank_b.stl -D mode=11 -D filter_count=2 -D base_embed_power_bank=true

//@make -o duo/cover_a.stl -D mode=20 -D filter_count=2
//@make -o duo/cover_b.stl -D mode=21 -D filter_count=2

//@make -o duo/grill_box_basic.stl -D mode=30 -D filter_count=2 -D grill_ear=[0,0] -D grill_window=[24,46] -D pwm_ctl_pcb_size=[0,0,0]
//@make -o duo/grill_box_a.stl -D mode=30 -D filter_count=2
//@make -o duo/grill_box_b.stl -D mode=31 -D filter_count=2

//@make -o duo/wall_section.stl -D mode=92 -D filter_count=2 -D wrapwall_dovetail=[0,0,0]
//@make -o duo/wall_section_dovetails.stl -D mode=92 -D filter_count=2

//@make -o test/power_module.stl -D mode=101 -D filter_count=2
//@make -o test/wall.stl -D mode=102 -D filter_count=1
//@make -o test/cover_hole.stl -D mode=103 -D filter_count=1
//@make -o test/joiner_clip.stl -D mode=104
//@make -o test/power_bank_a.stl -D mode=105 -D base_embed_power_bank=true
//@make -o test/power_bank_b.stl -D mode=106 -D base_embed_power_bank=true
//@make -o test/grill_ear.stl -D mode=107
//@make -o test/pwm_ctl_mount.stl -D mode=108

//@make -o parts/clip.stl -D mode=90
//@make -o parts/base_channel_plug.stl -D mode=91
//@make -o parts/base_bank_channel_plug.stl -D mode=91 -D base_embed_power_bank=true
//@make -o parts/pwm_knob.stl -D mode=93

// Which part to model: base / cover / grill / wall / etc...
mode = 0; // [0:Full Assembly, 1:Assembly A, 2:Assembly B, 10:Base Plate A, 11:Base Plate B, 20:Cover Plate A, 21:Cover Plate B, 30:Grill Box A, 31:Grill Box B, 90:Rabbit Clip, 91:Base Channel Plug, 92:Wall Section, 93:PWM Knob, 100:Dev, 101:Power Module Fit Test, 102:Wall Fit Test, 103:Cover Hole Test, 104:Clip Tolerance Test, 105:Base Label Dev, 106:Base Join Test A, 107:Base Join Test B, 108:Grill Ear Test, 108:PWM Contoller Test]

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

// Thickness of footer support walls that run parallel to and underneath floating external walls.
support_wall_width = 2.4;

// Enable to show support walls in preview, otherwise only active in production renders.
$support_preview = false;

/* [Wraparound Wall Metrics] */

// Mesh wrap wall preview color.
wrapwall_color = "#545651";

// Thickness of the mesh wrap wall, radially away from filter center; set to zero to disable mesh wall.
wrapwall_thickness = 1.6;

// Mesh wrap wall slot depth cut into the base/cover plates.
wrapwall_slot_depth = 5;

// Mesh wrap wall slot fit tolerance for the channel cut into the base/cover plates.
wrapwall_tolerance = 0.2;

// Additional tolerance at the open end of the base/cover plate mesh wall slot.
wrapwall_draft = 0.4;

// Auotmatic determination of mesh wall section length, by dividing the total perimeter evenly.
wrapwall_section_limit = build_plate_size.x - 10;

// Manual setting for how many sections the mesh wrap wall will be split into; overrides wrapwall_section_limit perimeter division.
wrapwall_sections = 0;

// Mesh wrap wall sections will use dovetail joiners of this dimension; [w, h, spacing] vector, set either w or h to 0 to disable dovetails.
wrapwall_dovetail = [5, 3, 15];

// Additional tolerance added to mesh wrap wall dovetail receptacles.
wrapwall_dovetail_tolerance = 0.1;

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
grill_color = "#246f5a";

// Amount of padding to add around each side of the fan within the grill box; should be at least enough to allow routing of fan cables.
grill_padding = 5;

// Thickness of grill box walls.
grill_thickness = 3;

// Corner and edge chamfering of the grill box.
grill_chamfer = 5;

// Optional side anchor/handle ear on the fan grill gox; diameter/height vector, set either to 0 to disable.
grill_ear = [15, 4];

// Optional hole in any side anchor ear for a carrying strap attachment; set to 0 to disable.
grill_ear_hole = 10;

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

grill_screw_drive = "hex";

// Cutout window size in the extra space area of the grill box between filters. Set either dimension to 0 to disable.
grill_window = [ 0, 0 ];

/* [Filter Cover Parameters] */

// Cover plate preview color.
cover_color = "#4390e0";

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
cover_port = [40, 20];

// Access notch cutout on the underside of cover, aides mesh wall and filter removal; will be positioned on the bottom surface of cover, centered at the aapex of filter od.
cover_notch = [20, 20, 20];

// Rounding radius for any cover notch cutout.
cover_notch_rounding = 5;

// Placement, along the Y axis of the inner cover plate edge, of any wire pass through holes
cover_port_at = [-48, 48];

/* [Filter Base Parameters] */

// Base plate preview color.
base_color = "#4390e0";

// Overall Z thickness of the base plate under the filter.
base_height = 20;

// Chamfer size of the base plate, additional radial space as needed.
base_overhang = 10;

// How many joiner clips to use in the base plate.
base_clips = 4;

// Enable a cavity and access tunnel for a power bank inside/between a pair of base plates.
base_embed_power_bank = false;

// Height under the power bank from base plate bottom; needs to be able to accomodate a row of joiner clips.
base_power_bank_lift = 12;

// Tunnel shrink radius in front of the power bank main cavity.
base_power_bank_tunnel_inset = 1;

// Corner and mouth flare chamfering on the power bank access tunnel.
base_power_bank_tunnel_chamfer = 4;

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

/* [Power Bank] */

power_bank_size = [ 62, 90.2, 22.5 ];
power_bank_rounding = 9;
power_bank_rounding_edges = "Y";
power_bank_sockets = [

  struct_set(socket_spec("usb-c"), [
    "offset", [15.5, 0]
  ]),

  struct_set(socket_spec("usb-a-micro"), [
    "offset", [0, 0]
  ]),

  struct_set(socket_spec("usb-a"), [
    "offset", [-15.5, 0, 2]
  ]),

  // led window
  [
    ["size", [11, 1.5, 1]],
    ["offset", [0, 0, -2.8]]
  ],

  // button window
  [
    ["size", [10, 5, 1]],
    ["rounding", 1],

    ["anchor", LEFT+FRONT],
    ["attach", BOTTOM],
    ["rotate", [0, -45, 0]],
    ["offset", [0, 10, 0]]

  ]

];

/* [PWM Controller] */

pwm_ctl_tolerance = 0.2;

pwm_ctl_inset = 10;

pwm_ctl_pcb_size = [20, 26, 1.2];

pwm_ctl_pot_size = [9.6, 12.2, 11.5];

pwm_ctl_pot_shaft = [6.8, 15];

pwm_ctl_pot_key = [2, 1, 0.9];

pwm_ctl_pot_offset = 0.6;

pwm_ctl_led_win = [4, 1, 1];

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

else if (mode >= 1 && mode < 10) {
  assembly($idx = mode - 1);
}

/// mode[10-19] -- bases

else if (mode >= 10 && mode < 20) {
  base_i = mode - 10;
  by = base_i % 2 == 0 ? RIGHT : LEFT;
  bb = base_i % 2 == 0 ? LEFT : RIGHT;

  translate($preview ? bb*base_od/2 : [0, 0, 0])
  preview_cutaway(dir=by)
  recolor(base_color)
  base($idx = base_i, label = !$preview) recolor(undef) {
    %if (buddy) {

      if (base_i == 0) {
        position("power_module") power_module();
        position("power_channel") channel_plug(anchor=BOTTOM);
      }

      if (base_embed_power_bank) {
        position("power_bank") power_bank();
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

        if (cover_i == 0 && pwm_ctl_pcb_size.x*pwm_ctl_pcb_size.y*pwm_ctl_pcb_size.z > 0) {
          attach("pwm_pot_hole_interior", "pot_shaft_base", overlap=-$eps)
            pwm_controller();
        }
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

else if (mode == 93) {
  pwm_pot_knob();
}

/// mode[100...] -- development aids and tests

else if (mode == 100) {
  pwm_controller()
  {
    // show_anchors();
    // #cube($parent_size, center=true);
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

else if (mode == 105) {
  xcopies(n=filter_count, spacing = filter_id + 5)
  let ( base_i = $idx )
  diff() cyl(d = filter_id, h=2)
    tag("remove")
    attach(TOP, BOTTOM, overlap=1)
      base_label(i=base_i, h=1 + $eps);
}

else if (mode == 106 || mode == 107) {
  $idx = mode - 106;
  pad = 5;
  plate_xcut_idx(base_od/2 - power_bank_size.x/2 - pad)
  preview_cutaway(dir=BOTTOM)
  front_half(s=base_od*2.1, y=power_bank_size.y/2 + pad)
    base(label = false);
}

else if (mode == 108) {
  sz = grill_size();
  y_cut = sz.y/4;
  left_cut = -sz.x/2 + grill_thickness;
  yrot($preview ? 0 : 180)
  back_half(y=-y_cut, s=2.1*base_od)
  front_half(y=y_cut, s=2.1*base_od)
  left(left_cut) left_half(x=left_cut, s=2.1*base_od)
    grill();
}

else if (mode == 108) {
  w = pwm_ctl_pcb_size.x + 2*pwm_ctl_inset;
  l = pwm_ctl_pcb_size.y + grill_thickness +  pwm_ctl_inset;
  x_cut = grill_size().x/2 - w;
  y_cut = grill_size().y/2 - l;

  yrot($preview ? 0 : 180)
  left(w/2) left(x_cut)
  back(l/2) back(y_cut)
  right_half(s=2.1*base_od, x=x_cut)
  front_half(s=2.1*base_od, y=-y_cut)
    grill($idx = 0);
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
    union() {
      up(marg.z/2)
      scale(v_div(to_size + [0, 0, $eps], from_size))
      down(range/2)
      zrot(-90)
        surface(file = file, center = true, convexity = convexity);
      cube(v_mul(sz, [1, 1, 0.5]), anchor=TOP);
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

            screw_length = grill_size().z + 5;
            %attach(["screw_hole_0", "screw_hole_1", "screw_hole_2", "screw_hole_3"], BOTTOM, overlap=screw_length)
              recolor("#333333")
              screw(
                spec = grill_screw,
                head = grill_screw_head,
                drive = grill_screw_drive,
                thread = false, length = screw_length);

            %attach("vent_interior", TOP) recolor("#666666") pc_fan();

            if (i == 0 && pwm_ctl_pcb_size.x*pwm_ctl_pcb_size.y*pwm_ctl_pcb_size.z > 0) {
              %attach("pwm_pot_hole_interior", "pot_shaft_base", overlap=-$eps)
                pwm_controller();

              %attach("pwm_pot_hole_exterior", BOTTOM, overlap=-0.5)
                recolor(grill_color) pwm_pot_knob();
            }
          }
        }

      recolor(base_color)
      attach(BOTTOM, TOP, overlap=filter_recess)
        base($idx=i, label=!$preview) recolor(undef) {
          position(TOP+(i % 2 == 0 ? RIGHT : LEFT))
          down(wrapwall_slot_depth)
          zrot(i % 2 == 0 ? 0 : 180)
          recolor(wrapwall_color)
            wallmock(filter_height - 2*filter_recess + 2*wrapwall_slot_depth, anchor=RIGHT+BOTTOM);

          if (i == 0) {
            %position("power_module") recolor("silver") power_module();
            position("power_channel") recolor(base_color) channel_plug(anchor=BOTTOM);
          }

          if (base_embed_power_bank) {
            %position("power_bank") recolor("#333333") power_bank();
          }
        }

    }

    children();
  }
}

module pwm_pot_knob(
  h = 18,
  base_d = 15, base_h = 5,   // exterior base size
  nut_d = 13, nut_h = 6,     // clearance to spin around the mounting nut/washer
  shaft_d = 6, shaft_fn = 8, // exterior knob/shaft; fn is polygon arity
  point_size = [0.8, 3],     // indicator point oriented towards back face
  chamfer = 1,               // tip edge and transition from base to knob
  tolerance = 0.1,
  anchor = CENTER, spin = 0, orient = UP
) {
  shaft_h = h - 2;
  trans_d = base_d - 2*chamfer;
  trans_h = chamfer;
  tap_d = trans_d - trans_h;
  tip_d = tap_d - 2*chamfer;

  attachable(anchor, spin, orient, d=base_d, h=h) {
    down(h/2)
    difference() {
      conv_hull()
      cyl(d=base_d, h=base_h, chamfer2=chamfer, anchor=BOTTOM) {
        down(chamfer/2)
        attach(BACK, BACK, overlap=2)
          cube([point_size.x, point_size.y, base_h - chamfer]);
        attach(TOP, BOTTOM, overlap=$eps)
          cyl(d1=trans_d, d2=tap_d, h=trans_h + $eps, $fn=shaft_fn) {
          tag("keep")
          attach(TOP, BOTTOM, overlap=$eps)
            cyl(d1=tap_d, d2=tip_d, h=h - trans_h - base_h + $eps, chamfer2=chamfer, $fn=shaft_fn - 1);
        }
      }
      down($eps) cyl(
        d1=nut_d + 2*tolerance,
        d2=shaft_d + 2*tolerance,
        h=nut_h + 2*$eps,
        anchor=BOTTOM)
        attach(TOP, BOTTOM, overlap=$eps) cyl(
          d=shaft_d + 2*tolerance,
          h=shaft_h - nut_h + $eps);
    }

    children();
  }
}

module pwm_controller(
  anchor = CENTER, spin = 0, orient = UP,
  tolerance = 0, cut = 0
) {
  // TODO as measured from FIXME product ; parameterize?

  vtol = scalar_vec3(tolerance);

  under_clearance = 1.6;
  pcb_size = pwm_ctl_pcb_size + [2*tolerance, 2*tolerance, 0];

  pot_size = pwm_ctl_pot_size + 2*vtol;
  pot_shaft = pwm_ctl_pot_shaft + [2*tolerance, tolerance];
  pot_key_size = pwm_ctl_pot_key + 2*vtol;

  // TODO egress wires are the most likely thing to be quite different on another product?
  wire_d = 1.2;
  lead_l = 10;
  wire_bundle_pitch = 2.1;
  wire_bundle_width = 3*wire_d + 2*wire_bundle_pitch;

  // TODO as measured; validate against spec?
  fan_header_base_size = [5.7, 10.2, 3.2] + 2*vtol;
  fan_pin_size = [0.6, 7.5];
  fan_pin_pitch = 2.8;
  fan_key_tab_offset = 1.1;
  fan_key_tab_size = [0.8, 5, 7.5];

  size = pcb_size
       + [0, pot_shaft.y, pot_size.z]
       + [0, 0, under_clearance];

  loc_shaft_tip = [
    size.x/2 - pot_size.x/2 - pwm_ctl_pot_offset,
    -size.y/2,
    -size.z/2 + under_clearance + pcb_size.z + pot_size.z/2
  ];

  attachable(
    anchor, spin, orient,
    size=size,
    anchors=[
      named_anchor("pot_shaft_tip", loc_shaft_tip, FRONT),
      named_anchor("pot_shaft_base", loc_shaft_tip + [0, pot_shaft.y, 0], FRONT),
      named_anchor("pot_key", [
        size.x/2 - pot_size.x/2 - pwm_ctl_pot_offset,
        -size.y/2 + pot_shaft.y,
        -size.z/2 + under_clearance + pcb_size.z + pot_key_size.z/2
      ], FRONT),
      named_anchor("wire_exit", [
        size.x/2 - wire_bundle_width/2,
        size.y/2,
        -size.z/2 + under_clearance/2
      ], BACK),
      named_anchor("fan_header", [
        -size.x/2 + fan_header_base_size.x/2,
        size.y/2 - fan_header_base_size.y/2,
        -size.z/2 + under_clearance + pcb_size.z + fan_header_base_size.z
      ], UP)
    ]
  ) {

    recolor("blue")
    back(pot_shaft.y/2)
    down(pot_size.z/2)
    up(under_clearance/2)
      cube(pcb_size, center=true) {

      // TODO likely need to parameterize pot-attach-from

      recolor("green")
      left(pwm_ctl_pot_offset)
      position(FRONT+TOP+RIGHT)
        cube(pot_size, anchor=BOTTOM+RIGHT+FRONT) {

          recolor("red")
          back($eps)
          down(2*tolerance) // bodge
          position(FRONT+BOTTOM)
            cube(pot_key_size + [0, $eps, 0], anchor=BACK+BOTTOM);

          attach(FRONT, BOTTOM, overlap=$eps)
            recolor("silver")
            cyl(d=pot_shaft.x, h=pot_shaft.y + $eps);

          if (pwm_ctl_led_win.x*pwm_ctl_led_win.y*pwm_ctl_led_win.z > 0) {
            led_win_size = pwm_ctl_led_win + 2*vtol;
            recolor("orange")
            back($eps)
            position(FRONT+BOTTOM+LEFT)
              cube(size=led_win_size + [0, cut + 2*$eps, 0], anchor=BACK+BOTTOM+RIGHT);
          }

        }

      // 4-pin fan header with key tab
      recolor("white")
        position(TOP+LEFT+BACK)
        cube(
          fan_header_base_size
          + (tolerance == 0 ? [0, 0, 0] : [0, 0, fan_pin_size.y + tolerance]),
          anchor=BOTTOM+LEFT+BACK)
          if (tolerance == 0) {
            recolor("silver")
            position(TOP)
              ycopies(n=4, spacing=fan_pin_pitch)
              cyl(d=fan_pin_size.x, h=fan_pin_size.y, anchor=BOTTOM);
            fwd(fan_key_tab_offset)
            position(TOP+LEFT+BACK)
              cuboid(
                size=fan_key_tab_size,
                anchor=BOTTOM+LEFT+BACK,
                rounding=1,
                edges=[
                  [0, 0, 1, 1], // yz -- +- -+ ++
                  [0, 0, 0, 0], // xz
                  [0, 0, 0, 0], // xy
                ]);
          }

      if (tolerance == 0) {
        back(lead_l/4)
        down(wire_d/2)
        left(wire_bundle_width/2)
        position(BOTTOM+BACK+RIGHT)
          xcopies(n=3, spacing=wire_bundle_pitch)
            recolor(["yellow", "red", "purple"][$idx])
            %cyl(d=wire_d, h=lead_l, anchor=FRONT+BACK, orient=BACK);
      }

    }

    children();
  }
}

module power_bank(blank = false, tolerance = 0, anchor = CENTER, spin = 0, orient = UP) {
  sz = power_bank_size + 2*scalar_vec3(tolerance);
  if (blank) {
    cuboid(
      size = sz,
      rounding = power_bank_rounding + tolerance,
      edges = power_bank_rounding_edges,
      anchor=anchor, spin=spin, orient=orient)
      children();
  } else {
    socketed_block(
      size = sz,
      rounding = power_bank_rounding + tolerance,
      edges = power_bank_rounding_edges,
      sockets = power_bank_sockets,
      anchor=anchor, spin=spin, orient=orient)
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
  wall_size = wall_section(base_od - filter_od).x;

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

    zrot(90) wall_section(base_od - filter_od);
    zrot(90) wall_section(base_od - filter_od);
  }
}

module socketed_block(
  size, sockets,
  rounding=0, chamfer=0, edges=EDGES_ALL,
  anchor = CENTER, spin = 0, orient = UP
) {
  socket_anchors = [
    for (socket = sockets)
    if (is_def(struct_val(socket, "name")))
    let (
      anchor = struct_val(socket, "anchor", FRONT),
      off = struct_val(socket, "offset"),
      sz = struct_val(socket, "size")/2
    ) named_anchor(
      struct_val(socket, "name"),
      v_mul(size/2, anchor) + off + sz/2,
      anchor
    )];

  attachable(anchor, spin, orient, size = size, anchors = socket_anchors) {
    diff(remove="socket")
    cuboid(size, rounding=rounding, edges=edges) {
      tag("socket") attach_sockets(sockets);
    }

    children();
  }
}

module attach_sockets(specs, anchors=[], offsets=[]) {
  for ($idx = idx(specs)) {
    spec = socket_spec(specs[$idx]);
    anchor = default(anchors[$idx], struct_val(spec, "anchor", FRONT));
    off = default(offsets[$idx], struct_val(spec, "offset", [0, 0]));
    assert(is_vector(off, 2) || is_vector(off, 3));
    depth = struct_val(spec, "size").z;
    // TODO spin
    translate(off)
    attach(anchor, struct_val(spec, "attach", BOTTOM), overlap=depth)
    rotate(struct_val(spec, "rotate", [0, 0, 0]))
      socket(spec)
        children();
  }
}

function socket_spec(type) =
  is_struct(type) ?
    assert(is_vector(struct_val(type, "size"), 3))
    type
  : is_vector(type, 3) ? [["size", type]]
  : type == "usb-a" ? [["size", [12.5, 5.1, 13]]]
  : type == "usb-a-micro" ? [  
    ["size", [7.5, 2.5, 7]],
    ["chamfer", 1],
    ["edges", [
      [0, 0, 0, 0], // yz -- +- -+ ++
      [0, 0, 0, 0], // xz
      [1, 1, 0, 0], // xy
    ]]
  ]
  // TODO usb-a-mini
  // TODO usb-b
  : type == "usb-c" ? [
    ["size", [9, 3.2, 6.8]],
    ["rounding", 1]
  ]
  : undef;

module socket(size, chamfer, rounding, edges, anchor = FRONT, spin = 0, orient = UP) {
  spec = socket_spec(size);
  assert(is_struct(spec));

  // TODO after <https://github.com/BelfrySCAD/BOSL2/pull/1418>
  //   entry = struct_set(spec, [
  //     ["rounding", rounding],
  //     ["chamfer", chamfer],
  //     ["edges", edges],
  //   ])
  // then eliminate sz/r/c/e below and default(...) calls

  sz = struct_val(spec, "size");
  r = default(rounding, struct_val(spec, "rounding"));
  c = default(chamfer, struct_val(spec, "chamfer"));
  e = default(edges, struct_val(spec, "edges", "Z"));

  up($eps/2) cuboid(
    size=sz + [0, 0, $eps], rounding=r, chamfer=c, edges=e,
    anchor=anchor, spin=spin, orient=orient
  ) children();
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

/* Distributes sparse support walls within a cubic volume.
 *
 * gap specifies interface gap around all 6 faces of the cube, and may be:
 * - a single number to use constant gap around
 * - a 3-list specifying x/y/x gap values
 * - further within the 3-list, each entry maybe a pair of negative/positive gap values
 * 
 * every specifies an upper bound on wall spacing along the Y axis:
 * - walls will be spaced at most this far apart between starting/ending Y gap offsets
 * - the actual spacing will be adjusted down to evenly distribute size.y after gap
 */
module support_walls(
  size,
  gap = support_gap,
  every = support_every,
  width = support_width,
  wall_width = support_wall_width,
  anchor = CENTER, spin = 0, orient = UP
) {
  if_support()
  tag("support")
  attachable(anchor, spin, orient, size=size) {
    wid = scalar_vec2(width);

    xgap = scalar_vec2(is_list(gap) ? gap[0] : gap);
    ygap = scalar_vec2(is_list(gap) ? gap[1] : gap);
    zgap = scalar_vec2(is_list(gap) ? gap[2] : gap);
    pre_gap = [xgap[0], ygap[0], zgap[0]];
    post_gap = [xgap[1], ygap[1], zgap[1]];
    foot_gap = max(zgap);

    isize = size - pre_gap - post_gap;

    first_at = wid.x/2;
    last_at = isize.y - wid.x/2;
    at_span = last_at - first_at;
    at_space = at_span / ceil(at_span / every);
    nominal_at = [
      for (y = [ each [first_at : at_space : last_at], last_at ])
      y - isize.y/2
    ];

    xfoot = [
      pre_gap.x == 0 ? wall_width : 0,
      post_gap.x == 0 ? wall_width : 0
    ];
    yfoot = [
      pre_gap.y == 0 ? wall_width : wid.x,
      post_gap.y == 0 ? wall_width : wid.x
    ];

    xthick = flatten([
      xfoot[0] > 0 ? xfoot[0] : [],
      xfoot[1] > 0 ? xfoot[1] : []
    ]);
    ythick = [
      yfoot[0],
      each(repeat(wid.x, len(nominal_at) - 2)),
      yfoot[1]
    ];

    actual_at_x = flatten([
      xfoot[0] > 0 ? -(isize.x - wall_width)/2 : [],
      xfoot[1] > 0 ? (isize.x - wall_width)/2 : []
    ]);
    actual_at_y = [for (i=idx(nominal_at))
      nominal_at[i]
      + (i == 0 ? 1 : -1)
      * (ythick[i] - wid.x)/2
    ];

    translate((pre_gap - post_gap)/2) {

      ycopies(spacing=actual_at_y)
      right(xfoot[0] > 0 ? (xfoot[0] - $eps)/2 : 0)
      left(xfoot[1] > 0 ? (xfoot[1] - $eps)/2 : 0)
        support_wall(
          h = isize.z,
          l = isize.x
            - (xfoot[0] > 0 ? xfoot[0] + $eps : 0)
            - (xfoot[1] > 0 ? xfoot[1] + $eps : 0)
            ,
          gap = 0,
          spin = 90,
          width = [ythick[$idx], wid.y]);

      xcopies(spacing=actual_at_x)
        support_wall(
          h = isize.z,
          l = size.y - 2*foot_gap,
          gap = 0,
          width = [xthick[$idx], wid.y]);

    }

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
    diff(remove="flow filter wallslot screw socket channel port notch", keep="grip support")
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
          zrot(360/16)
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

        if (cover_notch.x * cover_notch.y * cover_notch.z > 0) {
          tag("notch")
            down(cover_notch.z/2)
            left(slot_od/2)
              cuboid(cover_notch,
                rounding=cover_notch_rounding, edges=[
                  [1, 1, 1, 1], // yz -- +- -+ ++
                  [1, 0, 1, 0], // xz
                  [1, 0, 1, 0], // xy
                ]);
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
  dh = base_embed_power_bank
    ? base_overhang
    + power_bank_size.z
    + 2*base_power_bank_tunnel_chamfer
    - 2*base_power_bank_tunnel_inset
    + base_power_bank_lift
    : base_height
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
          zcopies(spacing=size.z > base_height
            ? [
              0 - 2*clip_size.z - wrapwall_slot_depth,
              -size.z + 2*clip_size.z
            ]
            : [0 - size.z/2])
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

module plate_xcut_idx(x, i=$idx, parity=0, s=base_od*2.1) {
  if (((i + parity) % filter_count) % 2 == 0) {
    left(base_od/2 - x/4)
    right_half(s=s, x=x)
      children();
  } else {
    right(base_od/2 - x/4)
    left_half(s=s, x=-x)
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

module base_label(h = 1, i = 0, anchor = CENTER, spin = 0, orient = UP) {
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

        down(h/2)
        qrcode("user_guide/v1.qr.png",
          size = [qr_size, qr_size, h/2 + $eps],
          dat_size = qr_res,
          margin = [border, border, h/2],
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
    }

    children();
  }
}

module base_power_bank_tunnel(
  h,
  inset = 1,
  chamfer = 1,
  flare = undef,
  anchor = CENTER, spin = 0, orient = UP) {
  flare_out = default(flare, chamfer);

  size1 = [power_bank_size.x, power_bank_size.z] - scalar_vec2(2*inset);
  size2 = size1 + [2*flare_out, 2*flare_out];

  attachable(anchor, spin, orient, size = scalar_vec3(size1, h), size2 = size2) {

    r = size1/2;
    cdg = sqrt(2)*chamfer;
    profile = apply(fwd(r.y) * left(r.x - chamfer), turtle([
      "repeat", 2, [
        "move", 2*(r.x - chamfer),
        "left", 45, "move", cdg,
        "left", 45, "move", 2*(r.y - chamfer),
        "left", 45, "move", cdg,
        "left", 45]
    ]));

    zrot(90) yrot(-90) path_sweep(profile,
      path = [
        [-h/2, 0],
        [h/2 - flare_out, 0],
        [h/2, 0]
      ],
      tangent = [
        [1, 0, 0],
        [1, 0, 0],
        [1, 0, 0]
      ],
      scale = [
        [1, 1],
        [1, 1],
        v_div(size2, size1)
      ]);

    children();
  }
}

module base(label = true, anchor = CENTER, spin = 0, orient = UP) {
  base_i = $idx;

  sz = base_size();

  power_deets = base_power_port_details();
  power_bounds = struct_val(power_deets, "size");

  pms = power_module_size(power_module_tolerance);
  filter_r = filter_od/2 + filter_tolerance;

  // placed just outside of the filter recess circle
  ytangent = base_od/2 - (power_bounds.y + sqrt(2)*power_channel_chamfer);
  power_port_offset = sqrt(filter_r^2 - ytangent^2);

  join_side = base_i == 0 ? RIGHT : LEFT;

  attachable(
    anchor, spin, orient,
    size = sz,
    anchors = [

      each(base_i == 0 ? let (
        power_mod_offset = struct_val(power_deets, "mod_offset"),
        power_chan_offset = struct_val(power_deets, "chan_offset"),
        power_port_loc = v_mul(FRONT+BOTTOM, sz/2) + UP*pms.z/2 + join_side*power_port_offset + RIGHT*power_channel_size.x/2,
        power_mod_loc = translate(v_mul(BACK+UP, power_bounds/2) + power_mod_offset, power_port_loc),
        power_chan_loc = translate(v_mul(BACK+UP, power_bounds/2) + power_chan_offset, power_port_loc)
      ) [
        named_anchor("power_module", power_mod_loc, FRONT),
        named_anchor("power_channel", power_chan_loc, UP)
      ] : []),

      each(base_embed_power_bank ? let (
        power_bank_loc = v_mul(join_side+BOTTOM, sz/2) + UP*base_power_bank_lift + UP*power_bank_size.z/2
      ) [
        named_anchor("power_bank", power_bank_loc, FRONT)
      ] : [])

    ]
  ) {
    plate_mirror_idx(base_i)
    diff(remove="port label bank", keep="support") base_plate() {

      // USB C port and wire channel
      if (base_i == 0) {
        tag("port")
        up(pms.z/2)
        translate(join_side * power_port_offset)
        position(FRONT+BOTTOM)
          base_power_port(anchor=FRONT+BOTTOM+LEFT, lip_chamfer=2*power_module_tolerance);
      }

      if (label) {
        tag("label")
        attach("filter", BOTTOM, overlap=1)
        plate_mirror_idx(base_i)
          base_label(h = 1 + $eps, i = base_i);
      }

      if (base_embed_power_bank) {
        tolerance = power_module_tolerance;
        tag("bank")
        up(base_power_bank_lift)
        up(power_bank_size.z/2)
        position(RIGHT+BOTTOM) {
          power_bank(blank=true, tolerance=tolerance, anchor=CENTER) {
            tunnel_l = (sz.y - (power_bank_size.y))/2 + 2*$eps;

            support_cube = v_mul(power_bank_size + scalar_vec3(2*tolerance), [0.5, 1, 1]) - [power_bank_rounding, 0, 0];
            left(support_cube.x/2)
              support_walls(support_cube, gap = [ [support_gap, 0], support_every/2, support_gap ]);

            attach(FRONT, BOTTOM, overlap=$eps)
            base_power_bank_tunnel(
              tunnel_l,
              inset = base_power_bank_tunnel_inset,
              chamfer = base_power_bank_tunnel_chamfer) {

                support_cube = [power_bank_size.x/2, tunnel_l, power_bank_size.z]
                  - 2*[base_power_bank_tunnel_inset, 0, base_power_bank_tunnel_inset]
                  - [base_power_bank_tunnel_chamfer, base_power_bank_tunnel_chamfer, 0];
                left(support_cube.x/2) attach(BOTTOM, BACK, overlap=support_cube.y)
                  support_walls(support_cube, gap = [ [0, support_gap], 0, support_gap ]);

              }
          }
        }
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

module wallmock(h, anchor = CENTER, spin = 0, orient = UP) {
  slot_t = (slot_od - slot_id)/2;
  r = (slot_od - slot_t)/2;
  r1 = r + wrapwall_thickness/2;
  r2 = r - wrapwall_thickness/2;

  extra = (base_od - slot_od)/2;
  path = turtle([
    "left", 180,
    "move", r1 + extra,
    "arcright", r1, 180,
    "move", r1 + extra,

    "right", 90, "move", wrapwall_thickness,
    "right", 90,
    "move", r2 + wrapwall_thickness + extra,
    "arcleft", r2, 180,
    "move", r2 + wrapwall_thickness + extra,
    "right", 90, "move", wrapwall_thickness,
  ], state=[r1 + extra/2, -r1]);

  linear_sweep(path, h, anchor=anchor, spin=spin, orient=orient)
    children();
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
  wrapwall_thickness
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
        attach(RIGHT, BOTTOM, overlap=$eps)
        xcopies(l=wall_size.y - wrapwall_dovetail.x, spacing=wrapwall_dovetail.z)
        zrot($idx % 2 == 0 ? 0 : 180)
          dovetail("male",
            h = wrapwall_dovetail.y + $eps,
            width = wrapwall_dovetail.x,
            back_width = wrapwall_dovetail.x - wrapwall_thickness,
            thickness=wall_size.z);

        tag("remove")
        attach(LEFT, TOP, overlap=wrapwall_dovetail.y + wrapwall_dovetail_tolerance)
        xcopies(l=wall_size.y - wrapwall_dovetail.x, spacing=wrapwall_dovetail.z)
        zrot($idx % 2 == 0 ? 0 : 180)
          dovetail("female",
            h = wrapwall_dovetail.y + wrapwall_dovetail_tolerance + $eps,
            width = wrapwall_dovetail.x + 2*wrapwall_dovetail_tolerance,
            back_width = wrapwall_dovetail.x + 2*wrapwall_dovetail_tolerance - wrapwall_thickness,
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

  has_pwm = grill_i == 0 && pwm_ctl_pcb_size.x*pwm_ctl_pcb_size.y*pwm_ctl_pcb_size.z > 0;

  pwm_pot_shaft = [size.x/2, -size.y/2, 0]
    + LEFT*pwm_ctl_inset
    + LEFT*pwm_ctl_pcb_size.x
    + RIGHT*(pwm_ctl_pot_size.x/2 + pwm_ctl_pot_offset);

  attachable(
    anchor, spin, orient,
    size = size,
    anchors = [
      named_anchor("vent_exterior", vent_loc, UP),
      named_anchor("vent_interior", vent_loc + grill_thickness*DOWN, DOWN),
      named_anchor("vent_bottom", vent_loc + size.z*DOWN, DOWN),
      each([
        for (i = idx(screw_hole_tops))
        named_anchor(str("screw_hole_", i), screw_hole_tops[i], UP)]),
      each(has_pwm ? [
        named_anchor("pwm_pot_hole", pwm_pot_shaft, FRONT),
        named_anchor("pwm_pot_hole_interior", pwm_pot_shaft + BACK*grill_thickness, BACK),
        named_anchor("pwm_pot_hole_exterior", pwm_pot_shaft, FRONT)
      ] : [])
    ]
  ) {
    plate_mirror_idx(grill_i)
    grill_block(size=size, remove="screw hollow vent anchor window pwm_ctl") {

      if (grill_ear.x * grill_ear.y > 0) {
        position(TOP + LEFT)
        cyl(d=grill_ear.x, h=grill_ear.y, anchor=TOP+RIGHT) {
          if (grill_ear_hole > 0) {
            cr = (grill_ear.x - grill_ear_hole)/2;
            tag("anchor") {
              right((grill_ear.x - grill_ear_hole) - cr)
              attach(TOP, BOTTOM, overlap=grill_ear.y + $eps)
                cyl(d=grill_ear_hole, h=grill_ear.y + 2*$eps);
              left(cr)
              attach(BOTTOM, TOP)
                cuboid(size=[2*grill_ear_hole, grill_ear_hole, size.z], chamfer=cr, edges="Z");
            }
          }
        }
      }

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

      if (has_pwm) {
        position(RIGHT+FRONT)
        left(pwm_ctl_inset)
        left(pwm_ctl_pcb_size.x)
        right(pwm_ctl_pot_size.x/2 + pwm_ctl_pot_offset)
        back(grill_thickness) {
          back($eps)
          tag("pwm_ctl")
            pwm_controller(anchor="pot_shaft_base", orient=DOWN, tolerance=pwm_ctl_tolerance, cut=grill_thickness);
        }
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
