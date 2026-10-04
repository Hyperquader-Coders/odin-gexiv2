# Decisions — odin-gexiv2

Settled choices. An entry that stops being true is rewritten, not appended to.

## 1. Generated, not hand-written

The bindings are generated with runic from the headers Amber ships, so a library bump is a
regeneration. Hand fixes are the exception and are tracked in [PATCHED.md](PATCHED.md).

## 2. Licence: GPL-3.0-or-later

gexiv2 is GPL-2.0-or-later: every installed header carries `SPDX-License-Identifier:
GPL-2.0-or-later` and the package's copyright file says `GPL-2+`. The one exception is
`gexiv2-managed-stream.h`, copied from Moonlight under LGPL-2.1 or MIT, which GPL permits.
The binding is released under GPL-3.0-or-later, which version 2-or-later permits. A program
that links it is GPL when distributed.

## 3. One package, `gexiv2`

gexiv2's headers are one library with one umbrella header, so there is one package and one
`rune.yml`. GLib, GObject and GIO types come from the `glib:` collection (odin-glib), never
from a copy here.

## 4. Flag enums are bit_sets, chosen by a list

C flag types are `bit_set[FooBit; u32]`, so callers write `{.OMIT_PACKET_WRAPPER,
.USE_COMPACT_FORMAT}`. `postprocess.sh` rewrites the enums runic emits; the members of `FooBit`
are bit indices, and the type keeps the C size (4 bytes) and bits, so procedures take and return
it by value unchanged. The list is the one `<bitfield>` entry of GExiv2-0.10.gir, `XmpFormatFlags`
(bits 4 to 11, with no zero member). A new GFlags type in a header bump is added to the list by
hand; generation fails if a listed enum is missing, negative or has no single-bit member. A value
rule cannot tell them from plain enums: `Orientation` runs 0 to 8 and is not a flag.

## 5. Parameters are single objects unless declared

runic 0.8 writes `[^]T` for a pointer parameter whose C name ends in `s` (`settings`, `lines`),
however many elements it holds, which lets a caller index past one element, and drops a trailing
`va_list`, binding the procedure as `#c_vararg ..any`. Amber's runic fork (branch `amber-patched`)
has `parameters: declared`: with it every procedure parameter is `^T` (`T **` is `^^T`) unless
`arrays:` in the package's `rune.yml` lists it, chosen against the C headers, and a va_list
procedure is skipped. Struct members, variables and typedefs keep runic's name guess, and the
parameters of function-pointer types are plain `^T`: a limit of the fork, true in every binding.
Where a binding needs it, the `param_rules` table in `postprocess.sh` restores the `[^]` for
those parameters' real arrays, rewrites single-object struct members and corrects `T ***` outs;
a row that matches nothing fails the build. Rejected: rewriting the output in `postprocess.sh`,
which had to be told each parameter, matched `va_list` procedures by name pattern (it deleted
`list_store_insert_with_values` for containing `_va`) and was a second place to keep in step
with the headers. `scripts/check-generated.sh` stays as the guard that any regeneration, with
any runic, keeps the listed parameters right.
