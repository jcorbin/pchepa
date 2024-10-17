# Build v1.2.1

There are primarily 2 variants:
1. a stationary variant that merely has a USB-C port in its base
  - [Thangs STL models][duo_thangs]
  - [MakerWorld 3MF Slicer Layouts][duo_makerworld]

2. a portable variant that integrates a USB-C battery bank into a thicker base
  - [Thangs STL models][duo_portable_thangs]
  - [MakerWorld 3MF Slicer Layouts][duo_portable_makerworld]

## Suggested Tools

- a 3d printer with enough build volume ( 250mm x 250mm in the XY is the main going concern )
- a soldering iron with heatset insert tips
- wire stripper
- side snips for trimming wire ends and such
- heatgun to help bend wall segments
- a spudger like <https://www.printables.com/model/656983> helps at many points

## Material Cost Estimates

Assuming filament cost of $14.99/kg:
1. stationary costs about $88.53
2. portable costs about $132.28

Breakdown:
- 3d printed parts:
  1. stationary needs 893g of filament and around 25 hours of print time over 12 prints
  2. portable needs 1.16kg of filament and around 33 hours of print time over 12 prints
- commodity parts:
  - fans and filters cost around $58
  - mechanical hardware and electronics cost around $18 per unit
    (pwm controller, usb pd trigger, various wires, metric bolts and heatset inserts)
  - portable costs another $39.31 for a usb battery bank, patch cable, and carrying strap

**NOTE** due to most electronic and mechanical parts coming in kits/packs,
you'll likely spend more up front, and then have a lot of spare parts on hand.

## BOM

| Part Name / Link                                    | Unit Cost | Quantity    | Order Cost | Effective Cost |
| --------------------------------------------------- | --------- | ----------- | ---------- | -------------- |
| Fan: [Noctua NF-P12][amaz_noctua_nf_p12]            | $15.95    | 2           | $31.90     | $31.90         |
| Filter [Nyemo TT-AP006 2-pack][amaz_nyemo]          | $25.99    | 1           | $25.99     | $25.99         |
|                                                     |           |             |            |                |
| Controller: [Taidacent 2510-4P][amaz_taidacent_pwm] |  $9.88    | 1           |  $9.88     |  $9.88         |
| Fan Cabling: [PWM fan splitter][amaz_fan_split_x10] | $24.99    | 1/10        | $24.99     |  $2.50         |
| [M3x35 flat head screws][amaz_m3_bolts]             |  $8.59    | 8/40        |  $8.59     |  $1.72         |
| [M3x4x5 heatset inserts][amaz_m3_heatsets]          |  $7.99    | 8/100       |  $7.99     |  $0.64         |
| [USBC 15v PD Trigger][amaz_15v_pd_trigger]          |  $9.99    | 1/5         |  $9.99     |  $2.00         |
| [JST ZH 2p male/female pair][amaz_jst_zh_2p_10pair] |  $9.99    | 1/10        |  $9.99     |  $1.00         |
|                                                     |           |             |            |                |
| Battery: [USUIE 12V USB-C][amaz_usuie_12v_bank]     | $25.99    | 1           | $25.99     | $25.99         |
| [Shoulder Strap][amaz_shoulder_strap]               |  $9.99    | 1           |  $9.99     |  $9.99         |
| [USB-C 1ft patch cable][amaz_usbc_patch]            |  $9.99    | 1/3         |  $9.99     |  $3.33         |
|                                                     |           |             |            |                |
| Sunlu PLA                                           | $14.99    | 1.157kg/1kg | $14.99     | $17.34         |

## Printed Parts

NOTE: print material and times may vary by printer, print settings, and with minor revisions made to the design; these numbers are provided as a baseline estimate.

| Name           | Amount  | Time | Quantity |
| -------------- | ------- | ---- | -------- |
| Cover A&B      | 127.64g | 3:20 | 2        |
| Grill Box A    |  91.13g | 3:30 | 1        |
| Grill Box B    |  89.75g | 3:24 | 1        |
| Base A         | 154.10g | 4:04 | 1        |
| Base B         | 150.61g | 3:51 | 1        |
| Battery Base A | 281.37g | 7:27 | 1        |
| Battery Base B | 272.28g | 6:58 | 1        |
| Mesh Wall      |  27.39g | 0:47 | 6        |

- Common parts:
  - Cover: 255.28g , 6:40
  - Grill: 180.88g , 6:54
  - Mesh Wall: 164.34g , 4:42
- Stationary Base: 304.71g , 7:55
- Battery Base: 553.65g , 14:25

## Guide

If you're using a reliable printer and all the same BOM parts as cited above, smaller test prints shouldn't be necessary.

However if you're changing out parts, customizing things, or doubt your printer's accuracy there are several ancillary test print models that may be printed first.

All parts are designed to be printed without auto-generated supports; any parts that do require support,
come with breakaway support structures builtin (e.g. every clip socket, and the battery bank tunnel).

All of the recommended slicer settings, build plate layouts, and printer settings for a Bambu printer can be downloaded from MakerWorld:

- [stationary variant][duo_makerworld]
- [portable variant][duo_portable_makerworld]

General suggested slicer settings:
- walls: 3 loops/perimeters
- top/bottom: 3 layers
- sparse infill: 7% tri-hexagon

Most parts come in an A (left) and B (right) side version; the A side is primary, mounting the control module and power modules.

### 1. Print Cover A

Also print 2 joiner clips and 1 port grommet along with each cover plate, placing them inside the filter ring of the cover plate.
**NOTE** joiner clips are best printed as "pure walls": 0 top/bottom layers, and enough wall perimeters so that they're all wall, no infill.

Use a spudger, flathead screw driver, or similar to knock the tiny support fin out of each clip socket.

Once printed add 4 heatset inserts.

### 2. Print Fan Grill A

Print the A side grill box along with its PWM potentiometer knob.

Prepare the PWM pcb by replacing any power leads it came w with a pair JST header wires.

Install the PWM pcb through the hole in the grill front-right face.

Plug the Y-splitter cable into the PWM pcb's header; it should comfortably clear/pass through the front hemi-octagonal cover port.

Mount the grill/fan/cover with 4 M3x35 bolts. The fan's wire should pass through the back hemi-octagonal cover port and its grommet.

The port grommet is meant to be installed flat/thin end up (inside the grill box) with the tapered/thick end down inside the main body cavity.

**NOTE** you can manage most of the fan's wire length by orienting the fan to wrap its wire around itself;
i.e. place the corner where the fan wire exits farthest away from the cover/grill center.

The Y-splitter cable and fan lead can then connect below the cover plate ( what will eventually be interstitial space between both filter cylinders ).

**NOTE** if you have a small zip tie on hand, add one to secure the JST power leads to the Y-splitter cable close to the PWM controller;
this can help relieve any strain that may otherwise rip a wire off the PWM pcb.

### 3. Print Base A

Print the A side of whichever base variant you want ( use the thicker "with battery tunnel" one for a portable filter ).
Also print the corresponding channel plug part.
Also print 2-4 joiner clips along with each base plate ( 2 for the stationary base, 4 for the battery variant ).

**NOTE** if you want the QR code to read, you'll need to do a multi-color print; the easiest way to do this is to import both the `base` STL and corresponding `base_label` STL as simultaneous parts of one assembly.

Prepare the USB-C PD trigger by soldering on a pair of JST header wires of the **opposite gender** as used for the PWM pcb in step 2.

Remove support material:
- as with the cover plate above, each clip socket has a tiny support fin
- the battery bank version has a support framework inside its tunnel; a spudger slid down its interior gap should be able to pop most if out whole

Install the pd trigger into the base port cavity.
Use a small spudger or other non-metal poke/pry tool to press the module forward once it has bottomed out inside the channel.

Insert the channel plug behind the pd trigger.
The pd trigger should slide forward far enough that the plug can fully seat behind it,
preventing the pd trigger from moving when plug/unplugged.

### 4. Print A Side Wall Sections

You'll need 3 wall sections for each A/B side half of the filter.

These rely on a slicer trick: print them with 0 top/bottom layers, and a high level of sparse infill.
You may choose any infill pattern and density that you like the look of.
A good amount seems to be 60% tri-hexagon with a 90° direction.

The basic wall section is flat and simply sits loosely in the plates' perimeter channel ( model file `wall_noft_0.stl` ).
This panel has the advantage of easiest installation and later removal for maintenance.

However if you're building a portable ( battery bank integrated ) variant, a much better option is to use wall sections with a triangular "foot" along their top/bottom edge.
This provides a rigid grip between the cover and base plates, rather than only relying on the plate-filter grip to provide vertical integration.

**NOTE** without rigidity from these wall panels, the portable filter can **rapidly disassemble itself** when being carried around roughly; a moderate amount of physical shock is enough to cause the filter grips to release.

The with-foot wall sections can only be installed by sliding them into the channels of a cover/base plate pair; flexing them into place, or later easy removal of them is not possible.

Finally there is an experimental dovetail option to improve the seam between adjacent wall sections; see section 8 below for details.

### 5. Assemble A Side

Insert the HEPA filter cylinder into the cover plate, using its interior perimeter notch to help flex its ring into place. Then repeat this by inserting the filter cylinder into the base plate to complete the A-side main assembly.

Now you can install wall panels:
- if using the variant(s) with feet, slide them in from the open channel notches on the flat side of the filter
- the `noft` variant(s) can also be slide like this, or you may choose to flex them into place 

Sliding wall panels through the plate channels, especially the with-feet variant, will go better if you walk it along the channel by pressing on its top/bottom edges alternately.

If you have a heatgun, use it to help the wall panels accept their needed curve.
This process can be made easier by printing out a wall bender arch to support the heated panels from the inside while forming;
however these are best printed in higher temperature plastic like ABS.
This will also introduce quite a bit more steps as you'll need:
1. install the panels with the bender
2. form them with heat, wait for cooling
3. uninstall them to remove the bender

### 6. Print and Assemble B Side

Print the B side of the cover, grill, and base plates similarly to the A side ones above.

Assemble the cover/fan/grill similarly to step 2 above, but sans PWM controller.

Print another 3 wall sections and install as above.

### 7. Join A/B Side Assemblies

Install all joiner clips ( be sure to remove the tiny support fin from inside each socket ).

Place the battery bank into its socket in either half.

**NOTE** be sure to connect the JST connector between the A side base and cover.

Join both half by setting them both on the same flat surface: align the clips, make sure the wiring won't be pinched, then press together.

The cover port grommets should by flat end up / tapered end down, and should prevent the fan wiring from being pinched.

### 8. (optional) Dovetailed Seam Variants

**NOTE** dovetails seams to not work well with the rigid foot variants; while it's not impossible to slide a dovetailed "hemi-loop" (3-section run connected by dovetails) into place... doing so without a seam popping apart is very difficult.

To help improve mesh wall seam integrity around the bend, a dovetail "hinge" option is available.
The dovetail shape has a slight Z-taper with alternating up/down direction between adjacent dovetails.
Once assembled, this alternating direction causes the dovetail seam to hold together like a low range of motion hinge.

However assembling each dovetail seam can be tricky:
- do **not** force together dovetails in the Z direction (by laying one on top the other and just pressing)
- instead you'll need to weave together each seam, starting out between a pair of dovetails, and then working one dovetail at a time outwards

The wall section model files come in 4 variations:
- `wall_0.stl` -- no dovetails
- `wall_1.stl` -- left/female dovetail only
- `wall_2.stl` -- right/male dovetail only
- `wall_3.stl` -- both left and right dovetails
- there are 4 similar files named `wall_noft_*.stl`, these are probably the ones you want as dovetail with foot is very difficult to assemble

[amaz_15v_pd_trigger]: https://www.amazon.com/gp/product/B09GVN9RZ3
[amaz_fan_split_x10]: https://www.amazon.com/dp/B0C6XDFRZF
[amaz_jst_zh_2p_10pair]: https://www.amazon.com/dp/B0CNX4CJY4
[amaz_m3_bolts]: https://www.amazon.com/gp/product/B01C3KUMSY
[amaz_m3_heatsets]: https://www.amazon.com/Printing-M3x4x5mm-Threaded-Embedment-Automotive/dp/B0BTYF2MMD
[amaz_noctua_nf_p12]: https://www.amazon.com/gp/product/B07CG2PGY6
[amaz_nyemo]: https://www.amazon.com/gp/product/B08Z32BDJY
[amaz_shoulder_strap]: https://www.amazon.com/dp/B07P3LCZXN
[amaz_taidacent_pwm]: https://www.amazon.com/Taidacent-2510-4P-Manual-Controller-Control/dp/B0BHNC776L
[amaz_usbc_patch]: https://www.amazon.com/dp/B0B6BLQJ8B?psc=1&ref=ppx_yo2ov_dt_b_product_details
[amaz_usuie_12v_bank]: https://www.amazon.com/dp/B0CNGM4V32

[duo_makerworld]: https://makerworld.com/en/models/424917
[duo_thangs]: https://than.gs/m/1050549
[duo_portable_makerworld]: https://makerworld.com/en/models/472194
[duo_portable_thangs]: https://than.gs/m/1065492

[v1_user_guide]: https://github.com/jcorbin/pchepa/blob/main/user_guide/v1.md
