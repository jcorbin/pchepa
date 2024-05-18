# Errata

- the mesh wall is currently in a state of tradeoff:
  1. the alternating dovetail option is stronger, but nearly impossible to assemble
  2. the thicker version alone (sans dovetail) does an okay job, certainly better than v1.0 thin walls
- the chosen battery bank option works okay, but the disingenuous capacity rating on it leave a bad taste;
  other battery options would be welcome
- FIXME: what happened to base plate wallslots

# v1.1.0-rc2

- added power bank cavity and access tunnel inside of a thicker base plate variant
- moved power port location as far left as possible; corner of power channel now comes close to base filter retention ring
- added optional grill box ears with anchor holes for a shoulder strap
- added cutout notch to cover underside, allowing easier removal of mesh wall and filter
- added positive base label models for easy multi color prints;
  this also makes the up-surface of the base plates smooth (when doing a multi-color print)
- changed PWM controller module to a more minimal pcb mounted thru the front of left fan grill box; removed grill window
- improved mesh wall stability:
  - now thicker so that it's both stronger, and so that sections cannot overlap each other as easily when slotted
  - tapered the dovetails alternating directions so that they hold together like a hinge
  - but not using dovetail by default/recommendation due to how difficult they are to assemble and manage
  - also added a bending arch to help form smooth wall bends with a heat gun
- improved strength of base and cover plate filter grips
  - release candidate testing, noticed a minor layer separation break near A side cover notch
  - increased thickness of the wall between the filter recess cavity and the mesh wall channel
  - further trimmed base plate geometry to reduce extra added interstitial space a little
  - **NOTE**: this change will slightly invalidate fit with prior base and cover plates,
    but the overall quality / strength makes it a worthy reprint

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

- [ ] TODO try a hemi-loop mesh wall dovetail assembly
- [ ] TODO support N-filter stacks with a joiner plate
- [ ] TODO support N-fan stacks, but also take care, and support inter-fan spacing
- [ ] TODO support scaling down to single-stack assembly
- [ ] TODO support N-assembly: an un-curved plate mode to allow horizontal scale
- [ ] TODO inter-filter structure for duo to support additional electronics inside the mesh wall
- [ ] TODO evolve parameters, with presets for various fan/filter models
- [ ] TODO support arduino based electronics package, including an [air quality sensor wing][aq_wing]

[aq_wing]: https://hackaday.io/project/168492-the-air-quality-wing

[rc]: https://github.com/jcorbin/pchepa/tree/rc
[testing]: https://github.com/jcorbin/pchepa/tree/testing
[dev]: https://github.com/jcorbin/pchepa/tree/dev
