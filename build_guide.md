# Build v1.1

There are primarily 2 variants:
1. a stationary variant that merely has a USB-C port in its baser
2. a portable variant that integrates a USB-C battery bank into a thicker base

## Material Cost Estimates

Assuming filament cost of $14.99/kg:
1. stationary costs about $91.61
2. portable costs about $135.36

Breakdown:
- 3d printed parts:
  1. stationary needs 930g of filament and around 27 hours of print time over 13 prints
  2. portable needs 1.23kg of filament and around 35 hours of print time over 13 prints
- commodity parts:
  - fans and filters cost around $58
  - electronics cost around $18 per unit (pwm controller, usb pd trigger, various wires)
  - mechanical hardware cost $2.36 per unit (M3 bolts and heatset inserts)
  - portable costs another $39.31 for a usb battery bank, patch cable, and carrying strap

NOTE: due to most electronic and mechanical parts coming in kits/packs,
you'll likely spend more up front, and then have a lot of spare parts on hand.

## Suggested Tools

- a 3d printer with enough build volume ( 250mm x 250mm in the XY is the main going concern )
- soldering iron
- soldering iron heatset tips
- wire stripper
- side snips for trimming wire ends and such
- heatgun to help bend wall segments
- a spudger like <https://www.printables.com/model/656983> helps at many points

## BOM

| Part Name / Link                                    | Unit Cost | Quantity    | Order Cost | Effective Cost |
| --------------------------------------------------- | --------- | ----------- | ---------- | -------------- |
| Fan: [Noctua NF-P12][amaz_noctua_nf_p12]            | $15.95    | 2           | $31.90     | $31.90         |
| Filter [Nyemo TT-AP006 2-pack][amaz_nyemo]          | $25.99    | 1           | $25.99     | $25.99         |
| Controller: [Taidacent 2510-4P][amaz_taidacent_pwm] |  $9.88    | 1           |  $9.88     |  $9.88         |
| Fan Cabling: [Noctua NA-SYC1][amaz_noctua_na_syc1]  |  $9.95    | 1/2         |  $9.95     |  $4.98         |
| [USBC 12v PD Trigger][amaz_12_pd_trigger]           | $12.99    | 1/6         | $12.99     |  $2.17         |
| Battery: [USUIE 12V USB-C][amaz_usuie_12v_bank]     | $25.99    | 1           | $25.99     | $25.99         |
| [M3x4x5 heatset inserts][amaz_m3_heatsets]          |  $7.99    | 8/100       |  $7.99     |  $0.64         |
| [M3x35 flat head screws][amaz_m3_bolts]             |  $8.59    | 8/40        |  $8.59     |  $1.72         |
| [JST ZH wire kit][amaz_jst_zh_kit]                  | $17.99    | 6/283       | $17.99     |  $0.39         |
| [Shoulder Strap][amaz_shoulder_strap]               |  $9.99    | 1           |  $9.99     |  $9.99         |
| [USB-C 1ft patch cable][amaz_usbc_patch]            |  $9.99    | 1/3         |  $9.99     |  $3.33         |
| Sunlu PLA                                           | $14.99    | 1.226kg/1kg | $14.99     | $18.38         |

## Printed Parts

| Name           | Amount  | Time | Quantity |
| -------------- | ------- | ---- | -------- |
| Cover A&B      | 123.19g | 3:05 | 2        |
| Grill Box A    |  93.25g | 3:33 | 1        |
| Grill Box B    |  91.84g | 3:27 | 1        |
| Base A         | 168.39g | 4:21 | 1        |
| Base B         | 160.45g | 3:55 | 1        |
| Battery Base A | 317.96g | 8:17 | 1        |
| Battery Base B | 307.83g | 7:52 | 1        |
| Mesh Wall      |  26.76g | 0:46 | 6        |
| Rabbit Clips   |   8.45g | 0:27 | 1        |

- Common parts:
  - Cover: 246.38g , 6:10
  - Grill: 185.09g , 7:00
  - Mesh Wall: 160.56g , 4:36
  - Rabbit Clips: 8.45g , 0:27
- Stationary Base: 328.84g , 8:16
- Battery Base: 625.79g , 16:09

## Guide

If you're using a reliable printer and all the same BOM parts as cited above, smaller test prints shouldn't be necessary.
However if you're changing out parts, customizing things, or doubt your printers accuracy there are several ancillary test print models that may be printed first.

### 1. Print Cover A

The A side is the left/main/primary side ( the one that will have the controller knob in its top and power port inlet in its base ).

Once printed add 4 heatset inserts.

Suggested slicer settings for the cover/grill/base:
- **no support** all parts that need support have it designed into the models already (clip sockets and battery tunnel)
- walls: 3 loops/perimeters
- top/bottom: 3 layers
- sparse infill: 7% tri-hexagon

### 2. Print Grill Box A

Print the A/left side grill box along with it PWM potentiometer knob.

Prepare the PWM pcb by replacing any power leads it included with a pair JST header wires.

Install the PWM pcb through the hole in the grill front-right face.

Plug the Y-splitter cable into the PWM pcb's header; it should comfortable clear/pass through the front hemi-octagonal cover port.

Mount the grill/fan/cover with 4 M3x35 bolts. The fan's wire should pass through the back hemi-octagonal cover port.

NOTE: you can manage most of the fan's wire length by oriented the fan to wrap its wire around itself;
i.e. place the corner where the fan wire exits farthest away from the cover/grill center.

The Y-splitter cable and fan lead can then connect below the cover plate ( what will eventually be interstitial space between both filter cylinders ).

NOTE: if you have a small zip tie on hand, add one to cinch the JST power leads to the Y-splitter cable close to the PWM controller;
this can help relieve any strain, which might otherwise rip a wire off the PWM pcb.

### 3. Print Base A

Print the A/left side of whichever base variant you want ( use the thicker "with battery tunnel" one for a portable filter ).
Also print the corresponding channel plug part.

NOTE: if you want the QR code to read, you'll need to do a multi-color print, assigning something like white to the high surfaces of the QR.

Prepare the USB-C PD trigger by soldering on a pair of JST header wires of the **opposite gender** as used for the PWM pcb in step 2.

Install the pd trigger into the base port cavity.
Use a small spudger or other non-metal poke/pry tool to press the module forward once it's bottomed out inside the channel.

Insert the channel plug behind the pd trigger;
the pd trigger should slide forward far enough that the plug can fully seat behind it,
preventing the pd trigger from moving when plug/unplugged.

### 4. (optional) Test!

At this point you should have half of a working filter, assemble all of the A/left side components around one HEPA filter cylinder.

The fit for the HEPA filter's lip should require flexing its plastic ring to insert/remove;
this is another point where a spudger can help, but you should also be able to make it work simply by manual flexing.

### 5. Print Joiner Clips

You'll need 8-12 joiner clips ( 8 for the stationary version, 4 more for the thicker portable battery base ).

As a reminder, these work best when sliced as "pure walls": 0 top/bottom layers, and enough wall perimeters so that they're all wall, no infill.

### 6. (optional) Print 3 Wall Sections

You may choose to printout 3 wall sections to complete your half-build first, or you may move on to B-side completion before building the wall.

See step 8 below for notes on wall printing.

### 7. Print and Assemble B Side

Print the A/right side of the cover, grill, and base plates.

Assemble the cover/fan/grill similarly to step 2 above, but sans PWM controller.

Join the cover/base plates together using the rabbit clips from step 5.
This will likely go best one plate pair at a time,
rather than trying to join full A/B side assemblies with their filters.

### 8. Print Wall Sections

These rely on a slicer trick: print them with 0 top/bottom layers, and a high level of sparse infill.
You may choose any infill pattern and density that you like the look of.
A good amount seems to be 60% tri-hexagon with a 90° direction.

You'll need 6 wall sections in total; 3 of them should cover one half of the filter, with a seam aligned with the base/cover/grill seam.

Fully assemble the filter with its HEPA filter cylinders; don't forget to connect the JST power connectors.

To install each wall section, first insert it into the base channel, then flex the wall panel to get the top edge into the cover channel.
With a fresh unbent wall panel, this works best along the flat front/back edge.

With some amount of manual persuasion, you can then slide the wall panels along the channel around its bend.

After the panels are in place, a heatgun may be used to help them accept their new shape.

[amaz_12_pd_trigger]: https://www.amazon.com/gp/product/B0953G14Q2
[amaz_jst_zh_kit]: https://www.amazon.com/gp/product/B0C6WY7DZM
[amaz_m3_bolts]: https://www.amazon.com/gp/product/B01C3KUMSY
[amaz_m3_heatsets]: https://www.amazon.com/Printing-M3x4x5mm-Threaded-Embedment-Automotive/dp/B0BTYF2MMD
[amaz_noctua_na_syc1]: https://www.amazon.com/Noctua-NA-SYC1-Y-Cables-Fans-Black/dp/B00KG8K5CY
[amaz_noctua_nf_p12]: https://www.amazon.com/gp/product/B07CG2PGY6
[amaz_nyemo]: https://www.amazon.com/gp/product/B08Z32BDJY
[amaz_shoulder_strap]: https://www.amazon.com/dp/B07P3LCZXN
[amaz_taidacent_pwm]: https://www.amazon.com/Taidacent-2510-4P-Manual-Controller-Control/dp/B0BHNC776L
[amaz_usbc_patch]: https://www.amazon.com/dp/B0B6BLQJ8B?psc=1&ref=ppx_yo2ov_dt_b_product_details
[amaz_usuie_12v_bank]: https://www.amazon.com/dp/B0CNGM4V32
[v1_user_guide]: https://github.com/jcorbin/pchepa/blob/main/user_guide/v1.md
