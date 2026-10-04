#!/usr/bin/env bash
# Regenerate every package: runic over rune.yml, then the post-processing rules.
# RUNIC is the runic binary; make generate passes it.
set -euo pipefail

runic=${RUNIC:?RUNIC is not set}
cd "$(dirname "$0")/.."
mkdir -p build
ln -sfn / build/sys   # the rune files reach the system headers through build/sys/usr/include
mkdir -p build/inc
ln -sfn /usr/include/gexiv2 build/inc/gexiv2   # the rune file reaches <gexiv2/...> through build/inc

# SC2043: one package today; the loop is the shape every sibling repo has.
# shellcheck disable=SC2043
for p in gexiv2; do
    echo "== generate $p =="
    rm -f "$p/$p.odin"
    (cd "$p" && env -u DISPLAY -u WAYLAND_DISPLAY "$runic" rune.yml)
    scripts/postprocess.sh "$p"
done
