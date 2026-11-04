#!/usr/bin/env bash
# Regenerate every package: runic over rune.yml, then the post-processing rules.
# RUNIC is the runic binary; make generate passes it.
set -euo pipefail

runic=${RUNIC:?RUNIC is not set}
cd "$(dirname "$0")/.."
mkdir -p build
# build/sys holds links to the system header folders the rune files name, and nothing more: a
# link to / would lead every tool that follows links (an indexer, rg -L) through the whole disk.
# rm removes build/sys itself when it is a link, never what the link points to.
rm -rf build/sys
sys_dirs=(usr/include usr/lib/x86_64-linux-gnu/glib-2.0/include
	usr/lib/x86_64-linux-gnu/graphene-1.0/include)
for d in "${sys_dirs[@]}"; do
	mkdir -p "build/sys/${d%/*}"
	ln -s "/$d" "build/sys/$d"
done
mkdir -p build/inc
ln -sfn /usr/include/gexiv2 build/inc/gexiv2 # the rune file reaches <gexiv2/...> through build/inc

# SC2043: one package today; the loop is the shape every sibling repo has.
# shellcheck disable=SC2043
for p in gexiv2; do
	echo "== generate $p =="
	rm -f "$p/$p.odin"
	(cd "$p" && env -u DISPLAY -u WAYLAND_DISPLAY "$runic" rune.yml)
	scripts/postprocess.sh "$p"
done
