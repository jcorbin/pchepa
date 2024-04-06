# PC Fan driven open source HEPA filter -- [PCHEPA](https://github.com/jcorbin/pchepa)

OpenSCAD parametric model to integrate commodity PC Fans and cylindrical HEPA
filter cartridges to create personal and readily portable air filters..

## Status

- [x] v1 build of a dual-filter/fan model done and works well
- [ ] TODO write step by step build guide based on [v1_build.md](v1_build.md)
- [ ] TODO address v1 build pain points, especially rabbit clip tolerance
- [ ] TODO publish models set somewhere (probably thangs)
- [ ] TODO add code level documentation, especially to customizer parameters
- [ ] TODO evolve parameters, with presets for various fan/filter models
- [ ] TODO complete and build a single filter variant
- [ ] TODO support integrating a battery back or USB power bank
- [ ] TODO support arduino based electronics package, including an [air quality sensor wing][aq_wing]
- [ ] TODO a carrying handle part, or option integrated with the grill top

[aq_wing]: https://hackaday.io/project/168492-the-air-quality-wing

## Setup

These models are implemented as [OpenSCAD][openscad] scripts using the [BOSL2][bosl2] library.

After cloning this repository, run `git submoule update --init` to ensure the needed copy of BOSL2 is setup.

[bosl2]: https://github.com/BelfrySCAD/BOSL2
[openscad]: https://openscad.org/

## License

© 2024 by Joshua T Corbin is licensed under [CC BY-SA 4.0][ccbysa4]

[ccbysa4]: http://creativecommons.org/licenses/by-sa/4.0
