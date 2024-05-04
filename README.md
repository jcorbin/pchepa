# PC fan driven HEPA filter -- [PCHEPA](https://github.com/jcorbin/pchepa)

[Build Guide](v1_build.md) / [STLs on Thangs][duo_thangs] / [Bambu 3mf on MakerWorld][duo_makerworld]

![Duo Assembled With Top Open](duo/topdown_open.jpg)

Primary inspiration is the [Exhalaron][exhalaron] by cleanairkits.com, but there's also a strong similarity to other
"integrate a commodity HEPA filter and PC fan" makes before such as by [bigclive][bigclive_diy_hepa] and [greymanx][greymanx_diy_hepa].

- Follow the [v1 build notes](v1_build.md) to make your own
- Download [STL models on Thangs][duo_thangs]
- Read [CHANGELOG](CHANGELOG.md) for development status and release notes

## Design

The design is based around integrating readily available PC case fans and cylindrical HEPA filter cartridges.
So the build mainly involves 6 parts:
- purchased cylindrical HEPA filter cartridges
- purchased PC case fans
- purchased PWM fan control module
- printed base plates under the filters
- printed cover plates between the filters and fans
- printed grill enclosure over/around the fans

Secondarily there can be a flexible mesh wall wrapped around the HEPA filter to
protect it from impact. This wall can be printed in sections, or a suitable
pre-existing product may be used and cut to fit.

Additionally there are various small supporting parts:
- a USB-C 12v Power Delivery trigger module
- electronics wiring kit to integrate the power module, fan control module, and fans
- M3 machine screws to mount fans to cover plates, ideally using heatset inserts
- printed rabbit clips to join base/cover plate pairs
- printed channel plug to fix the USB-C power module in place

Currently the design only supports a 2-filter 2-fan layout and uses the same Nyemo H12 / TT-AP006 replacement filters as the exhalaron kit.
However the most readily changed model parameters should be the filter specifics if alternate an alternate filter needs to be sourced.

Any 120mm PC Fan may be used, and the model can easily adapt for larger 140mm PC fans
if needed (likely only makes sense if larger filter are also used).
A good choice would be something like Noctua NF-P12 fans because:
- high static pressure fans like these should be better than airflow optimized fans for this application
- low noise rating should mean that most of the sound created will be by air passing through the filter itself, with little added fan noise
- no unnecessary RGB lighting ; while this point is mostly an aesthetic choice, it also minimizes power waste when running on battery

An easy way to control/drive the fans is by using a commodity PWM fan controller, like the Noctua FC1.
This plus a splitter cable and 12v power source suffice to get things spinning.
The design could be adapted to support a DC barrel jack instead of USB-C if desired.

Optionally a thicker base plate that integrate a battery bank can be used for portable power.

Eventually this project would like to support more involved control boards,
such as an Arduino with additionally added air quality sensor and display.

![Duo Render](duo/render.png)

## Setup

This model is implemented in [OpenSCAD][openscad] using the [BOSL2][bosl2] library.

After cloning this repository, run `git submoule update --init` to ensure the needed copy of BOSL2 is setup.

## Printing

To generate STL models either:
- run `make all` to use default ( to go faster, run something like `make -j4 all` to build models in parallel, e.g. 4 at a time )
- or interactively export models from OpenSCAD by paging through each `mode` value under the `Part Selection` customizer tab

All models are already oriented as intended to print.

General recommended slicer settings:
- layer height: 0.2
- 4 walls
- sparse infill: 15% tri-hexagon
- 4 top/bottom layers
- concentric top surface pattern
- no support material

The flexible mesh wall section should instead be printed with:
- 0 top/bottom layers
- sparse infill: 60% tri-hexagon
- infill direction: 90°

### Fit Testing

There are several cut-down fit test models that can be used to verify assembly fitment.
Adjust model tolerance parameters, part metrics, and print slicer settings as needed to get a good fit before printing the full parts.

Power Module Fit Test
- a cut-down section of the primary base plate, focusing on just the power module socket, and its fixating channel plug
- makefile creates `test/power_module.stl`

Wall Fit Test
- a cut-down section of the base and cover plates, plus 2 reduced-length mesh wall sections
- useful to check plate-filter grip and mesh wall height
- may also be used to check power module fit, since it an instance of the power module socket
- makefile creates `test/wall.stl`

Cover Hole Test
- a cut-down section of the cover plate with 1 fan mounting hole
- primarily useful to verify heatset insert tolerance or direct threading of M3 screws
- may also be used to evaluate side handle affordance and filter-top grip
- makefile creates `test/cover_hole.stl`

Joiner Clip Tolerance Test
- clip sockets of varying tolerance size, set into minimal cubes with a label stamped into their top
- primarily useful to verify socket tolerance vs printer accuracy
- secondarily may also check printer ability to bridge, since these are meant to be printed without support
- makefile creates `test/joiner_clip.stl`

## License

© 2024 by Joshua T Corbin licensed under [CC BY-SA 4.0][ccbysa4]

[duo_makerworld]: https://makerworld.com/en/models/424917
[duo_thangs]: https://than.gs/m/1050549

[bigclive_diy_hepa]: https://www.youtube.com/watch?v=6Vmh2Ip2Vxg
[exhalaron]: https://www.cleanairkits.com/products/exhalaron
[greymanx_diy_hepa]: https://www.printables.com/model/386124

[bosl2]: https://github.com/BelfrySCAD/BOSL2
[ccbysa4]: http://creativecommons.org/licenses/by-sa/4.0
[openscad]: https://openscad.org/
