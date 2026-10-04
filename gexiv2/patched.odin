package gexiv2

import gobj "glib:gobject"

// One typed pin per post-processing rule (docs/PATCHED.md). A regeneration that drops or
// changes a rewritten signature fails to compile here.

// `gchar *` is `cstring`, not `^glib.char`.
@(private)
patched_cstring_return: proc "c" (self: ^Metadata) -> cstring = metadata_get_mime_type
@(private)
patched_cstring_parameter: proc "c" (self: ^Metadata, tag: cstring) -> cstring = metadata_get_tag_string
@(private)
patched_cstring_callback: LogHandler = proc "c" (level: LogLevel, msg: cstring) {}

// `GExiv2Metadata` is `Metadata`, with no `_GExiv2Metadata` beside it.
@(private)
patched_struct_name: proc "c" () -> ^Metadata = metadata_new

// `GEXIV2_TYPE_*` call `*_get_type`.
@(private)
patched_type_macro: proc "c" () -> gobj.Type = TYPE_METADATA

// One `GExiv2PreviewProperties *`: `^PreviewProperties`, not runic's `[^]PreviewProperties`.
@(private)
patched_metadata_get_preview_image: proc "c" (_: ^Metadata, _: ^PreviewProperties) -> ^PreviewImage = metadata_get_preview_image
