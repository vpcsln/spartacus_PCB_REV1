# Updating the design

Start each change from the latest `main` branch:

```sh
git switch main
git pull --ff-only
git switch -c change/short-description
```

Edit the project with KiCad 10.0.5, then verify and review the exact changes:

```sh
./scripts/verify-project.sh
git status --short
git diff --stat
git diff
```

Commit only intentional design and library changes:

```sh
git add --all
git commit -m "Describe the design change"
git push -u origin HEAD
```

Open a GitLab merge request for review. Do not commit KiCad lock files,
per-user view state, autosaves, backup archives, or generated manufacturing
outputs. If the KiCad version is intentionally upgraded, update
`.kicad-version`, the container tag in `Makefile` and `.gitlab-ci.yml`, and the
version notes in `REPRODUCIBILITY.md` in the same merge request.
