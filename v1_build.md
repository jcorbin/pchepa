# Build v1

- 28h15m total print time over 12 prints
  - not counting fit test prints, or failed printes when I neglected to do enough fit testing beforehand...
- total effective material cost is $112.73
- however due to quantity packaging, you'll likely spend around $182.45 plus some
  shipping/handling, and will end up with a lot of spare parts on hand
- tools used
  - 3d printer: bambu x1c
  - soldering iron: weller wlc100
  - soldering iron heatset tips
  - wire stripper
  - side snips
  - spudger <https://www.printables.com/model/656983>
  - mallet <https://www.printables.com/model/85382>

## BOM

| Part Name / Link                                   | Unit Cost | Quantity    | Order Cost | Effective Cost |
| -------------------------------------------------- | --------- | ----------- | ---------- | -------------- |
| Fan: [Noctua NF-P12][amaz_noctua_nf_p12]           | $15.95    | 2           | $31.90     | $31.90         |
| Filter [Nyemo TT-AP006 2-pack][amaz_nyemo]         | $25.99    | 1           | $25.99     | $25.99         |
| Controller: [Noctua NA-FC1][amaz_noctua_nafc1]     | $24.08    | 1           | $24.08     | $24.08         |
| Fan Cabling: [Noctua NA-SEC1][amaz_noctua_na_sec1] |  $9.95    | 1           |  $9.95     |  $9.95         |
| [USBC 12v PD Trigger][amaz_12_pd_trigger]          | $12.99    | 1/6         | $12.99     |  $2.17         |
| [M3x4x5 heatset inserts][amaz_m3_heatsets]         |  $7.99    | 8/100       |  $7.99     |  $0.64         |
| [M3x35 flat head screws][amaz_m3_bolts]            |  $8.59    | 8/40        |  $8.59     |  $1.72         |
| [JST ZH wire kit][amaz_jst_zh_kit]                 | $17.99    | 6/283       | $17.99     |  $0.39         |
| [PE Foam Tape][amaz_pe_foam_tape]                  | $12.99    | 40mm/16.4ft | $12.99     |  $0.11         |
| [Sunlu PLA Green][sunlu_pla_green]                 | $14.99    | 525.96g/1kg | $14.99     |  $7.89         |
| [Sunlu PLA Grey][sunlu_pla_grey]                   | $14.99    | 525.96g/1kg | $14.99     |  $7.89         |

## Printed Parts

| Name          | Filament        | Amount  | Time     | Quantity |
| ------------- | --------------- | ------- | -------- | -------- |
| Cover Plate   | Sunlu PLA Green | 166.96g | 3h56m    | 2        |
| Fan Grill Box | Sunlu PLA Green |  96.02g | 3h36m    | 2        |
| Base Plate A  | Sunlu PLA Grey  | 217.81g | 4h51m    | 1        |
| Base Plate B  | Sunlu PLA Grey  | 216.34g | 4h46m    | 1        |
| Mesh Wall     | Sunlu PLA Grey  |  16.83g |   36m24s | 5        |
| Small Parts   | Sunlu PLA Grey  |   7.66g |   31m45s | 1        |

| Filament        | Amount  |
| --------------- | ------- |
| Sunlu PLA Green | 525.96g |
| Sunlu PLA Grey  | 525.96g |

## Guide

Here's a rough step list made in retrospect:

### 1. print Cover Hole Test

- verify heatset insert (or plastic threading if you're customizing for that)
- verify filter lip grip:
  - the pre-fab plastic rim of the filter should fit above the few teardrop bumps
  - without being compressed by them
  - but also with a minimal amount of slop/rattle
- verify that the diameter fit of the cover piece to the filter od looks reasonable

### 2. print Power Module Fit Test

- verify that the power module pcb can be inserted easily
- verify that the power module pcb can be removed again if needed
- verify that the channel plug fits well and holds the pcb in place
  - **do not** insert the channel plug all the way yet, or it may be very difficult to remove
- maybe also attach wires to the pcb, and verify that they can easily pass thru the plugged channel
- optional: also print out a joiner clip
  - verify the clip socket included in the power module test object
  - if this goes well, you can skip the more involved joiner clip test

### 3. print Joiner Clip Tolerance Test

- skip this step if the power module clip socket tested well
- will need to have at least one clip on hand for testing
  - maybe add one to this fit test print
  - maybe print a batch of them out ahead of time
  - maybe have some on hand from the previous step
- verify that the joiner clip can be inserted into the socket without too much drama
- but it should still hold firmly, and may even be difficult to remove non-destructively

### 4. print Wall Fit Test

- only really necessary if customizing for a different / novel filter
- verify that both pieces grip the top/bottom of the filter well
  - remember that the filter itself is **the key vertical structural support**, so if the lip grip is insufficient, the assembly may fall apart when picked up
- verify that the wall segment(s) are sufficient tall to cover the filter, while resting in the base and cover plate channels
- verify that the wall segment dovetails mesh well

### 5. print a cover plate

- the cover plate uses slightly less material than the base, so start with it as a first part / final fit test
- add 4 heatset inserts after printing (if using them)
- verify that filter can be inserted and holds well:
  - this **should require** flexing filter's plastic ring, so that it snaps firmly into place
  - it should not be possible to remove the filter without flexing it's plastic ring a little
  - some kind of plastic prying tool (like a spudger) may be useful here
- mount a fan to verify spacing, but without a grill cover, may have extra bolt length leftover at this point
- check clip insertion into clip socket, printing out more clips as needed

### 6. print the main base plate (the one with the power module socket)

- verify filter insertion as above for the cover plate
- snap the cover plate onto the filter still in the base plate
  - if you have a test wall section on hand, verify its height fit one last time
- wire up and install the power module into its socket 
  - if using JST connectors, modify a fan cable into a corresponding JST wire pair
- once the power module and its wires are installed, insert the channel plug into the wiring channel

### 7. print out a wall section

- should slide into the channels of the base and cover plates without easily falling out
- alternatively, may install by inserting into one of the plates, then flexing the wall to snap into the other plate

### 8. print out a fan grill box

- install it over the fan
- if not using heatset inserts, maybe wait until this step to avoid rethreading into plastic too much

### 9. disassemble and insert joiner clips

- print out joiner clips as needed
- various clip patterns may be useful: all in one plate vs half in each plate of a meeting pair
- having a plastic mallet is very useful for this and especially for later final join

### 10. print 2nd cover plate, 2nd grill box, and other base plate

- using the alternate base plate model that does not include a power module socket

### 11. do final joinery of the 2 base plates and 2 cover plates

- may be useful to place on a smooth flat surface to keep alignment
- may need to use some sort of a mallet and/or block to aid with impact persuasion

### 12. wire everything up

- if fan cabling came with a lot of bulky extra insulation / sheathing, may end up needing to strip it off to reduce internal wiring bulk
- once the cover plate pair is joined, mounting the control module is possible
- apply a strip of PE foam tape to the back of the control module
- use a grill box (or both) to inform control module placement: accessible through the grill box window
- now start managing wires: from the fans, to/from the y-splitter, to the control module, from the power module
  - the wire pass through ports in the joined cover plate can be used to stuff spare wire down into interior space

### 13. print final wall section, and install them

- the dovetail joints can be quite tricky, especially around the curved ends

## Better Next Time

Probably should have used [Noctua NA-SYC1][amaz_noctua_na_syc1] instead of the NA-SEC1 kit,
while unit cost is same, it's actually a 2-pack of 2-way Y-splitters, so effective cost of $4.98.
The NA-SEC1 is actually a 3-way splitter plus extension cable kit, so redundant and unnecessary spare parts.

Another option would be to just splice JST connectors into all of the fan wiring,
and then to just DIY our own Y split by soldering a few wires together.

Improve mesh wall section integration:
- thicken the wall so that it has more grip surface
- maybe make the dovetails a little wider and deeper
- taper the dovetails so that they resist coming apart around curves

## v1.1 Power Bank Option

For portable power, there's an option to print a baseplate that can accommodate a battery bank cost increase is around $40-$50 depending on how you amortize things:

| Part Name / Link                                   | Unit Cost | Quantity    | Order Cost | Effective Cost |
| -------------------------------------------------- | --------- | ----------- | ---------- | -------------- |
| [USUIE 12V DC Power Bank][amaz_usuie_12v_bank]     | $25.99    | 1           | $25.99     | $25.99         |
| [USB-C 1ft patch cable][amaz_usbc_patch]           |  $9.99    | 1/3         |  $9.99     |  $3.33         |
| [Sunlu PLA Grey][sunlu_pla_grey]                   | $14.99    | 943.89g/1kg | $14.99     | $14.15         |

| Name          | Filament        | Amount  | Time     | Quantity |
| ------------- | --------------- | ------- | -------- | -------- |
| Base Bank A   | Sunlu PLA Grey  | 477.41g | 10h55m   | 1        |
| Base Bank B   | Sunlu PLA Grey  | 466.48g | 10h19m   | 1        |

NOTE: while this particular battery bank markets itself as 10000mAh, its packaging actually claims
only a 5500mAh rating; however my testing of it has only gotten about 2600mAh out from a full charge
cycle. Fortunately that's still enough to run a duo pchepa for a bit over 10 hours at full tilt.

[amaz_12_pd_trigger]: https://www.amazon.com/gp/product/B0953G14Q2
[amaz_jst_zh_kit]: https://www.amazon.com/gp/product/B0C6WY7DZM
[amaz_m3_bolts]: https://www.amazon.com/gp/product/B01C3KUMSY
[amaz_m3_heatsets]: https://www.amazon.com/Printing-M3x4x5mm-Threaded-Embedment-Automotive/dp/B0BTYF2MMD
[amaz_noctua_na_sec1]: https://www.amazon.com/gp/product/B00KG3K9AM
[amaz_noctua_na_syc1]: https://www.amazon.com/Noctua-NA-SYC1-Y-Cables-Fans-Black/dp/B00KG8K5CY
[amaz_noctua_nafc1]: https://www.amazon.com/gp/product/B072M2HKSN
[amaz_noctua_nf_p12]: https://www.amazon.com/gp/product/B07CG2PGY6
[amaz_nyemo]: https://www.amazon.com/gp/product/B08Z32BDJY
[amaz_pe_foam_tape]: https://www.amazon.com/Double-16-4ft-Mounting-Picture-Hanging/dp/B0CPSF8PML
[amaz_usbc_patch]: https://www.amazon.com/dp/B0B6BLQJ8B?psc=1&ref=ppx_yo2ov_dt_b_product_details
[amaz_usuie_12v_bank]: https://www.amazon.com/dp/B0CNGM4V32
[sunlu_pla_green]: https://www.sunlu.com/collections/pla-filament
[sunlu_pla_grey]: https://www.sunlu.com/collections/pla-filament
