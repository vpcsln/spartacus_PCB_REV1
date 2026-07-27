# Project-local libraries

These files are snapshots of the custom libraries and 3D assets used when this
design was created. They are committed so that project library resolution does
not depend on one workstation's home-directory layout.

- `eagle/`: every legacy Eagle library alias referenced by the design
- `symbols/`: all custom KiCad symbol libraries from the project library set
- `footprints/`: all custom KiCad footprint libraries from the project library
  set, including preserved alternate EasyEDA conversions
- `3d/`: all custom WRL and STEP models from the project library set
- `documentation/`: upstream readmes, import notes, and available license files

`footprints.pretty` combines the non-conflicting DSC1003 and PCM1821 Ultra
Librarian footprints because the historical project reused the `footprints`
nickname for both sources. The combined project-local library makes both sets
available without machine-global table ordering.

The source snapshots retain their original upstream licensing terms. Standard
KiCad libraries are not duplicated here; install the standard libraries that
ship with KiCad 10.0.5.
