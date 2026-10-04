# odin-gexiv2 cheat sheet

One screen per package: the calls a program makes, in the order it makes them, and the few
rules worth remembering. Every name here is a public declaration in [API.md](API.md), and
`make lint` fails when one is not. For the reasons behind a rule, follow the link to the README.

Conventions that hold everywhere: the library is the `gexiv2` collection
(`-collection:gexiv2=../odin-gexiv2`); the names are gexiv2's without the `gexiv2_` prefix;
GLib comes from `glib:` and is never redeclared ([Use](../README.md#use)); a call that can fail
takes a `^^glib.Error` last and sets it only on failure; flag types are bit sets
([DECISIONS §4](DECISIONS.md#4-flag-enums-are-bit_sets-chosen-by-a-list)).

## gexiv2:gexiv2 — Exif, IPTC and XMP of an image

```odin
import "core:strings"
import gexiv2 "gexiv2:gexiv2"
import glib "glib:glib"

_ = gexiv2.initialize()                             // once per process, before anything else; never two at a time

md := gexiv2.metadata_new()
defer gexiv2.metadata_free(md)                      // not object_unref: gexiv2 has its own
gerr: ^glib.Error                                   // nil on success; free it when set, then nil it
if !gexiv2.metadata_open_path(md, "photo.jpg", &gerr) {   // or metadata_open_buf(md, raw_data(data), c.long(len(data)), &gerr)
	glib.error_free(gerr)                           // gerr.message says why
	return
}

has := gexiv2.metadata_try_has_tag(md, "Exif.Photo.ISOSpeedRatings", &gerr)   // test first, so the getters' error path is for real failures
if gerr != nil { glib.error_free(gerr); gerr = nil }
if bool(has) {
	c := gexiv2.metadata_try_get_tag_interpreted_string(md, "Exif.Photo.Flash", &gerr)   // "Flash did not fire"; _string is the raw value
	if c != nil {
		text := strings.clone(string(c))            // the copy is the program's
		glib.free(rawptr(c))                        // the string from gexiv2 is a g_malloc: glib.free
	}
	if gerr != nil { glib.error_free(gerr); gerr = nil }
}

num, den: i32
ok := gexiv2.metadata_try_get_exif_tag_rational(md, "Exif.Photo.ExposureTime", &num, &den, &gerr)   // 1/250 s, not 0.004
lat, lon: f64
if bool(gexiv2.metadata_try_get_gps_latitude(md, &lat, &gerr)) && bool(gexiv2.metadata_try_get_gps_longitude(md, &lon, &gerr)) { /* degrees, north and east positive */ }

vs := ([^]cstring)(gexiv2.metadata_try_get_tag_multiple(md, "Xmp.dc.subject", &gerr))   // NULL-ended, or nil
if vs != nil { defer glib.strfreev((^cstring)(vs)) }
keys := ([^]cstring)(gexiv2.metadata_get_exif_tags(md))     // also get_iptc_tags, get_xmp_tags; each NULL-ended
if keys != nil { defer glib.strfreev((^cstring)(keys)) }
raw := gexiv2.metadata_try_get_tag_raw(md, "Exif.Photo.UserComment", &gerr)   // ^glib.Bytes
if raw != nil {
	n: glib.size
	p := glib.bytes_get_data(raw, &n)               // ([^]byte)(p)[:n]
	glib.bytes_unref(raw)
}

o := gexiv2.metadata_try_get_orientation(md, &gerr)         // .NORMAL … .ROT_270; .UNSPECIFIED when absent
gexiv2.metadata_try_set_orientation(md, .ROT_90, &gerr)
gexiv2.metadata_try_clear_tag(md, "Exif.Photo.UserComment", &gerr)
if !gexiv2.metadata_save_file(md, "copy.jpg", &gerr) { glib.error_free(gerr) }   // rewrites the file at that path
```

| remember | |
|---|---|
| `initialize` once, and never from two threads | two concurrent calls abort the process in Exiv2's XMP setup (measured in amber-image); run it from a `sync.Once` |
| Exiv2's XMP toolkit is not thread-safe | hold one mutex across every call on any `Metadata`, including `metadata_free` and `save_file` |
| Each `try_` call may set `gerr`; free it and reset it | a `GError` left set is a leak; `try_has_tag` first keeps the getters' error path for real failures |
| What comes back is owned | a string with `glib.free`, a tag list or `try_get_tag_multiple` with `glib.strfreev`, a `Bytes` with `glib.bytes_unref`; only `Metadata` has its own `metadata_free` |
| Tag keys are `Family.Group.Name` | `Exif.Photo.ISOSpeedRatings`, `Iptc.Application2.Copyright`, `Xmp.dc.title`; an XMP language alternative reads `lang="x-default" Title` and the program strips the prefix |
| `save_file` writes at the path it is given | a program that must not damage the original copies the file to a temporary one beside it, saves there, and renames; Exiv2 may replace the file instead of rewriting it, so check the inode |
