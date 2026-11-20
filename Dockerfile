FROM python:3.11-slim

# System deps needed by pyAFQ / dipy / numba
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential git libgomp1 && \
    rm -rf /var/lib/apt/lists/*

# Install MPAT and all its dependencies (pyAFQ, dipy, numba, trx-python, mittens-dmri, ...)
# --pre allows the mittens-dmri 2.0.0a1 pre-release
RUN pip install --no-cache-dir --pre \
    "mpat-tractography @ git+https://github.com/rokemlab/MPAT.git"

WORKDIR /app
