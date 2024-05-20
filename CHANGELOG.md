# Errata

- not yet happy with the mesh wall integrity under bend/strain, experimenting with different joinery for next

# v1.0.5

- revamped assembly preview, including parts explosion and animation
- remade wallslot geometry to be a direct path extrusion,
  should reduce any boundary artifacts similar to the plate remake in v1.0.2
- many minor code improvements on the way to v1.1
- dropped part kit model, slicing user can just add parts as needed

# v1.0.4

- revamped base label text to fit just inside the filter inner diameter;
  this is not just aesthetic, as cut text underneath the filter's rubber seal could potentially cause unintended air ingress
- increased joiner clip compression now that we've got better socket tolerance and print quality
- made the preview assembly easy to recolor
- several minor code level improvements while working towards v1.1

# v1.0.3

- added project and filter notes inside base plate
- added a user guide stub document with link embedded in QR code within base plate
- renamed most duo model files to follow an A (left) and B (right) side convention
- renamed the power channel plug model file
- many internal code cleanups and improvements while working on upcoming new features

# v1.0.2

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

- [rc] easier access to remove filter cover plate / mesh wall
- [rc] support integrating a USB power bank into a thicker base plate
- [rc] thicker / stronger / better mesh wall section joints
- [rc] carrying ears and anchor points for a shoulder strap
- [rc] support for simpler/cheaper pwm control modules
- [ ] TODO inter-filter structure for duo to support additional electronics inside the mesh wall
- [ ] TODO support N-fan stacks, primarily for dual-fan stacks (4-fans 2-filters) for higher airflow
- [ ] TODO complete and build a single filter variant
- [ ] TODO evolve parameters, with presets for various fan/filter models
- [ ] TODO support arduino based electronics package, including an [air quality sensor wing][aq_wing]

[aq_wing]: https://hackaday.io/project/168492-the-air-quality-wing

[rc]: https://github.com/jcorbin/pchepa/tree/rc
[testing]: https://github.com/jcorbin/pchepa/tree/testing
[dev]: https://github.com/jcorbin/pchepa/tree/dev
