#!/usr/bin/env python3
# Brainlife.io entrypoint for MPAT (Markov probabilistic absorbing tractography).
# Reads brainlife's flat config.json, calls the `mpat` CLI, then reorganises
# the output so the brainlife orchestrator can archive it.

import json
import shutil
import subprocess
import sys
from pathlib import Path

with open("config.json") as f:
    config = json.load(f)

staging = Path("./mpat_staging")
staging.mkdir(exist_ok=True)
out = Path("./tractmeasures")
out.mkdir(exist_ok=True)

cmd = [
    "mpat",
    config["dwi"],
    config["bvals"],
    config["bvecs"],
    config["t1"],
    str(staging),
    "--n-proc", str(int(config.get("n_proc", 4))),
    "--max-mem", str(int(config.get("max_mem", 16))),
]
if config.get("bundles"):
    cmd += ["--bundles", config["bundles"]]

print("+ " + " ".join(cmd))
result = subprocess.run(cmd)
if result.returncode != 0:
    sys.exit(result.returncode)

# Reorganise for brainlife: neuro/tractmeasures expects a file named csv.csv.
# Copy the first metrics TSV/CSV from MPAT's output, plus preserve the full tree.
mpat_out = staging / "mpat"
for f in sorted(mpat_out.glob("*.tsv")) + sorted(mpat_out.glob("*.csv")):
    shutil.copy(f, out / "csv.csv")
    break  # only the first one needed for the declared datatype file

# Keep the full per-bundle maps and HTML viewer alongside
if mpat_out.exists():
    shutil.copytree(mpat_out, out / "mpat", dirs_exist_ok=True)
