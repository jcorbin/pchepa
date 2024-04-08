# Build v1

- 28h15m total print time over 12 prints
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

| Name              | Filament        | Amount  | Time     | Quantity |
| ----------------- | --------------- | ------- | -------- | -------- |
| Cover Plate       | Sunlu PLA Green | 166.96g | 3h56m    | 2        |
| Fan Grill Box     | Sunlu PLA Green |  96.02g | 3h36m    | 2        |
| Base Plate Main   | Sunlu PLA Grey  | 217.81g | 4h51m    | 1        |
| Base Plate Second | Sunlu PLA Grey  | 216.34g | 4h46m    | 1        |
| Mesh Wall         | Sunlu PLA Grey  |  16.83g |   36m24s | 5        |
| Small Parts       | Sunlu PLA Grey  |   7.66g |   31m45s | 1        |

| Filament        | Amount  |
| --------------- | ------- |
| Sunlu PLA Green | 525.96g |
| Sunlu PLA Grey  | 525.96g |

28h15m

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
[sunlu_pla_green]: https://www.sunlu.com/collections/pla-filament
[sunlu_pla_grey]: https://www.sunlu.com/collections/pla-filament
