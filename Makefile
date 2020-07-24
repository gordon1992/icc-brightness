# Copyright 2017 - 2019, Udi Fuchs
# SPDX-License-Identifier: MIT

CFLAGS := -W -Wall -O2 ${CFLAGS}
LDFLAGS := -l lcms2 ${LDFLAGS}

PREFIX ?= /usr/local
BIN_DIR ?= ${PREFIX}/bin/
AUTO_START_DIR=/etc/xdg/autostart/

all: icc-brightness-gen

icc-brightness-gen: icc-brightness-gen.c
	$(CC) $(CFLAGS) $^ $(LDFLAGS) -o $@

clean:
	rm -f icc-brightness-gen

install: all
	install -Dm755 -t $(DESTDIR)$(BIN_DIR) icc-brightness icc-brightness-gen
	install -Dm644 -t $(DESTDIR)$(AUTO_START_DIR) icc-brightness.desktop

uninstall:
	rm -f $(DESTDIR)$(BIN_DIR)icc-brightness-gen
	rm -f $(DESTDIR)$(BIN_DIR)icc-brightness
	rm -f $(DESTDIR)$(AUTO_START_DIR)icc-brightness.desktop

local-install: BIN_DIR=~/.local/bin/
local-install: AUTO_START_DIR=~/.config/autostart/
local-install: install

local-uninstall: BIN_DIR=~/.local/bin/
local-uninstall: AUTO_START_DIR=~/.config/autostart/
local-uninstall: uninstall
