# SPDX-License-Identifier: BSD-2-Clause

# Copyright (C) 2026 embedded brains GmbH & Co. KG

FROM alpine:3.23
COPY pyproject.toml uv.lock .
RUN <<EOF
apk add --update --no-cache \
    gcc \
    git \
    make \
    musl-dev \
    py3-uv \
    python3 \
    python3-dev \
    texlive \
    texlive-bibtexextra \
    texlive-binextra \
    texlive-fontutils \
    texlive-latexextra \
    texlive-latexrecommended \
    texmf-dist-fontsextra \
    texmf-dist-fontsrecommended
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
uv sync --all-groups --cache-dir=/.cache/uv
EOF
