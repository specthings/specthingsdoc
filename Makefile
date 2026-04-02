# SPDX-License-Identifier: BSD-2-Clause

# Copyright (C) 2026 embedded brains GmbH & Co. KG

PACKAGE_NAME = docs

PACKAGE_VERSION = $(shell uv run specyamlquery /package-version config/$(PACKAGE_NAME)/pkg/component.yml)

BUILD = build

ARTIFACTS_PREFIX ?= artifacts

GIT_OPTIONS ?=

LOG_OPTIONS ?= --log-level=DEBUG

VENV ?= .venv

VENV_MARKER = $(VENV)/venv-marker

all: documentation-clean documentation

documentation: | prepare
	uv run specbuild $(GIT_OPTIONS) $(LOG_OPTIONS) \
	  spec \
	  config/$(PACKAGE_NAME)

documentation-move-artifacts: | prepare
	mkdir -p $(ARTIFACTS_PREFIX)/delivery $(ARTIFACTS_PREFIX)/internal
	mv $(BUILD)/*/*.pdf $(ARTIFACTS_PREFIX)/delivery

documentation-clean: | prepare
	if test -d $(BUILD) ; then cd $(BUILD) && git clean -xdf . && git co . ; fi

documentation-remove: | prepare
	rm -rf $(BUILD)

prepare: $(VENV_MARKER)

$(VENV_MARKER): uv.lock
	uv sync --all-groups
	touch $@

ifndef CI
uv.lock: pyproject.toml
	uv lock
	touch $@
endif
