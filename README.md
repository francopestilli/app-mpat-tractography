# app-mpat-tractography

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
