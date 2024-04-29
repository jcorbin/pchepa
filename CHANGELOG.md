# Errata

- not yet happy with the mesh wall integrity under bend/strain, experimenting with different joinery for next

# v1.0.x

- improved duo plate geometry, especially where half-circle transitions to a straight line;
  this should reduce facet-seam artifacts in the printed parts
- improved power socket internal fit, by chamfering the interior corner of the lip;
  this should make socket installation easier, preventing the usb-c socket from
  getting stuck on the lip when sliding forward into position
- added designed support inside clip socket; addressed slight roof droop/stringing, which was affecting clip tolerance

# v1.0.1

- switched to an even number of wrap wall sections, to avoid placing a join seam at the point of most strain
- made the power channel plug fit tighter, and also made its removal notch larger to ease removal with pliers
- improved base plate power socket geometry where it comes near to the mesh wall slot
- added a clip/socket fit test, and used it to make it tune socket size, allowing much easier assembly
- dropped unused fan wire channel option from the cover plate
- added textual guide and parts list based on prototype build
- expanded project level documentation including design notes, slicer setting recommendations, etc
- cleaned up and documented customizable parameters

# v1.0.0

- first dual filter prototype version completed

# Dev Status and TODOs

- [rc] moderate code improvements, and fixed plate curve discontinuity
- [testing] easier access to remove filter cover plate / mesh wall
- [testing] thicker / stronger / better mesh wall section joints
- [dev] support integrating a USB power bank into a thicker base plate
- [ ] TODO a carrying handle part, should strap attachment, or other option integrated with the cover or grill top
- [ ] TODO support for simpler/cheaper pwm control modules
- [ ] TODO inter-filter structure for duo to support additional electronics inside the mesh wall
- [ ] TODO complete and build a single filter variant
- [ ] TODO evolve parameters, with presets for various fan/filter models
- [ ] TODO support arduino based electronics package, including an [air quality sensor wing][aq_wing]

[aq_wing]: https://hackaday.io/project/168492-the-air-quality-wing

[rc]: https://github.com/jcorbin/pchepa/tree/rc
[testing]: https://github.com/jcorbin/pchepa/tree/testing
[dev]: https://github.com/jcorbin/pchepa/tree/dev
