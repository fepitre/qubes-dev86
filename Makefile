VERSION := $(shell cat version)
URL := http://v3.sk/~lkundrak/dev86/Dev86src-$(VERSION).tar.gz
SRC_FILE = $(notdir $(URL))
UNTRUSTED_SUFF := .UNTRUSTED
FETCH_CMD := wget --no-use-server-timestamps -q -O
SHELL := /bin/bash

%: %.sha256
	@$(FETCH_CMD) $@$(UNTRUSTED_SUFF) $(URL)
	@sha256sum --status -c <(printf "$$(cat $<)  -\n") <$@$(UNTRUSTED_SUFF) || \
		{ echo "Wrong SHA256 checksum on $@$(UNTRUSTED_SUFF)!"; exit 1; }
	@mv $@$(UNTRUSTED_SUFF) $@

.PHONY: get-sources
get-sources: $(SRC_FILE)

verify-sources:
	@true
