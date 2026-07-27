#!/bin/sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
project_root=$(CDPATH= cd -- "$script_dir/.." && pwd)
expected_version=${KICAD_EXPECTED_VERSION:-$(tr -d '[:space:]' < "$project_root/.kicad-version")}

if ! command -v kicad-cli >/dev/null 2>&1; then
  echo "error: kicad-cli is not installed" >&2
  exit 1
fi

actual_version=$(kicad-cli --version)
if [ "$actual_version" != "$expected_version" ]; then
  echo "error: KiCad $expected_version is required; found $actual_version" >&2
  exit 1
fi

for required_file in \
  v1sch.kicad_pro \
  v1sch.kicad_sch \
  v1sch.kicad_pcb \
  Control_MCU.kicad_sch \
  Transmitter.kicad_sch \
  filters.kicad_sch \
  receiver.kicad_sch \
  untitled.kicad_sch \
  fp-lib-table \
  sym-lib-table
do
  if [ ! -f "$project_root/$required_file" ]; then
    echo "error: required project file is missing: $required_file" >&2
    exit 1
  fi
done

if grep -En '"/home/|"[A-Za-z]:[\\/]' \
  "$project_root/fp-lib-table" \
  "$project_root/sym-lib-table" \
  "$project_root"/*.kicad_pro \
  "$project_root"/*.kicad_sch \
  "$project_root"/*.kicad_pcb
then
  echo "error: machine-specific absolute path found in project data" >&2
  exit 1
fi

sed -n 's|.*(model "${KIPRJMOD}/\([^"]*\)".*|\1|p' \
  "$project_root/v1sch.kicad_pcb" |
while IFS= read -r model_path
do
  if [ ! -f "$project_root/$model_path" ]; then
    echo "error: project-local 3D model is missing: $model_path" >&2
    exit 1
  fi
done

report_dir="$project_root/build/reports"
mkdir -p "$report_dir"

kicad-cli sch erc \
  --format json \
  --output "$report_dir/erc.json" \
  "$project_root/v1sch.kicad_sch"

kicad-cli pcb drc \
  --format json \
  --output "$report_dir/drc.json" \
  "$project_root/v1sch.kicad_pcb"

echo "Verified chireix_pcb with KiCad $actual_version."
echo "Reports: $report_dir/erc.json and $report_dir/drc.json"
