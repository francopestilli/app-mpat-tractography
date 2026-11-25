# app-mpat-tractography

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Reconstructs AFQ white matter bundles from DWI and a T1w with MPAT (Markov probabilistic absorbing tractography), computing bundles as expectations over infinitely many streamlines, and outputs per-bundle tractometry metrics and maps.**

Runs the mpat command (absorbing Markov chain formulation of probabilistic tractography) on the DWI with its bvals and bvecs and the T1w, optionally limited to a list of AFQ bundles, and returns per-bundle density, AFD, length, volume and cross-sectional area with per-bundle maps. Use it to obtain bundle-level tractometry without generating streamlines. Only the first metrics table produced by MPAT is copied to the datatype's csv.csv; the full MPAT output folder is included alongside.

| | |
|---|---|
| 📥 **Inputs** | `neuro/dwi` · `neuro/anat/t1w` |
| 📤 **Outputs** | `neuro/tractmeasures` |
| 🐳 **Container** | `gamorosino/mpat-tractography:1.0` |
| ⚙️ **Resources** | 4 GB memory · 1 h walltime |
| 🔗 **Run it** | [doi.org/10.25663/brainlife.app.1000](https://doi.org/10.25663/brainlife.app.1000) |

#### 📥 Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `dwi` | `neuro/dwi` | yes | DWI with bvals and bvecs. |
| `t1w` | `neuro/anat/t1w` | yes | T1-weighted image of the same subject. |

#### 📤 Outputs

| Output | Datatype | Description |
|---|---|---|
| `tractmeasures` | `neuro/tractmeasures` | Per-bundle tractometry metrics (density, AFD, length, volume, cross-sectional area) and per-bundle maps produced by MPAT. |

<details>
<summary><b>⚙️ Parameters</b> (3)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `n_proc` | number | `4` | Number of parallel processors to use |
| `max_mem` | number | `16` | Maximum memory in GB |
| `bundles` | string |  | Comma-separated list of AFQ bundle names to run (empty = all bundles) |

</details>

<!-- brainlife-app:end -->

MPAT: Markov probabilistic absorbing tractography – computes white-matter bundles as exact expectations over infinitely many streamlines using an absorbing Markov chain formulation on top of pyAFQ.

## Inputs

- `dwi` (neuro/dwi)
- `t1w` (neuro/anat/t1w)

## Outputs

- `tractmeasures` (neuro/tractmeasures) -- Per-bundle tractometry metrics (density, AFD, length, volume, cross-sectional area) and per-bundle maps produced by MPAT.

## Usage

Brainlife.io: run via `faber-app-run`/`faber-app-pipeline` (once registered
with `faber-app-create`), or the web UI.

Locally (outside brainlife): copy `config.json.example` to `config.json`,
fill in real file paths, then run `./main` from this directory. `main` pulls
its own container (`singularity exec docker://...`) -- no local install of
the underlying tool needed, only Singularity itself.

Entrypoint: `run_mpat.py`

## Authors

- Gabriele Amorosino <gabriele.amorosino@utexas.edu>

#### MIT Copyright (c) 2026 Gabriele Amorosino
