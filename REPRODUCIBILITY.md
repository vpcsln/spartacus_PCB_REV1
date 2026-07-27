# Reproducibility

## Pinned environment

- KiCad application and CLI: **10.0.5**
- KiCad file-format generator: **10.0**
- Container image: `kicad/kicad:10.0.5`
- Repository line endings: LF for all KiCad and library text formats

The full patch version matters. Opening and saving with another KiCad release
can rewrite project files even when the visible design has not changed.

## Committed inputs

The repository contains:

- the root schematic and all hierarchical sheets;
- the PCB and project settings;
- project-local symbol and footprint tables;
- every custom library referenced by the current design;
- custom WRL and STEP 3D assets; and
- the current BOM CSV.

KiCad embeds the instantiated symbol and footprint definitions in schematic
and PCB files. The project-local copies additionally keep library browsing,
symbol replacement, footprint assignment, and future edits working after a
clone.

Standard KiCad symbols, footprints, and 3D models are supplied by the pinned
KiCad 10.0.5 installation. The official `kicad/kicad:10.0.5` image provides a
repeatable CLI environment for checks and exports. Desktop rendering can still
vary slightly with operating-system fonts and GPU drivers; the electrical and
geometric source data remains identical.

## Deliberately untracked files

KiCad lock files, per-user view state (`*.kicad_prl`), autosaves, automatic
backup ZIP files, and generated manufacturing/check outputs are ignored. They
are not design inputs.

## Clean-room check

From a fresh clone:

```sh
make verify-container
git status --short
```

The first command must complete with KiCad 10.0.5 and the second command should
show no tracked changes. ERC and DRC reports are retained under
`build/reports/` and are intentionally ignored by Git.
