# chireix_pcb

KiCad schematic and PCB project for the Chireix design with global-label
connectivity.

## Open the design

1. Install **KiCad 10.0.5**, including its standard symbol, footprint, and 3D
   model libraries.
2. Clone this repository.
3. Open `v1sch.kicad_pro`.

The custom symbols, footprints, legacy Eagle libraries, and custom 3D models
used by the design are committed below `libraries/`. Both KiCad library tables
use `${KIPRJMOD}` paths, so a clone can live in any directory on Linux, macOS,
or Windows.

## Verify a clone

With KiCad 10.0.5 installed:

```sh
./scripts/verify-project.sh
```

Or use the immutable official KiCad 10.0.4 CLI container:

```sh
make verify-container
```

Reports are written to `build/reports/`. Existing ERC or DRC findings are
reported for engineering review; the verification fails only if the pinned
toolchain is wrong, a required file is missing, a non-portable path is found,
or KiCad cannot load and check the design.

See [REPRODUCIBILITY.md](REPRODUCIBILITY.md) for the reproducibility boundary
and [CONTRIBUTING.md](CONTRIBUTING.md) for the update workflow.
