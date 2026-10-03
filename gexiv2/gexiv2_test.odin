#+test
package gexiv2

import "core:strings"
import "core:testing"

import glib "glib:glib"

// Version recorded in README.md: "**Bound version:** X.Y.Z".
README :: #load("../README.md", string)

bound_version :: proc() -> (major, minor, micro: int, ok: bool) {
    marker :: "**Bound version:** "
    readme := README
    i := strings.index(readme, marker)
    if i < 0 do return
    rest := readme[i + len(marker):]
    end := strings.index_any(rest, " \n")
    if end < 0 do return
    parts := strings.split(rest[:end], ".", context.temp_allocator)
    if len(parts) != 3 do return
    nums: [3]int
    for p, n in parts {
        v := 0
        if len(p) == 0 do return
        for c in p {
            if c < '0' || c > '9' do return
            v = v * 10 + int(c - '0')
        }
        nums[n] = v
    }
    return nums[0], nums[1], nums[2], true
}

@(test)
test_readme_version_matches_header_macros :: proc(t: ^testing.T) {
    major, minor, micro, ok := bound_version()
    testing.expect(t, ok, "README.md has no '**Bound version:** X.Y.Z'")
    testing.expect_value(t, major, MAJOR_VERSION)
    testing.expect_value(t, minor, MINOR_VERSION)
    testing.expect_value(t, micro, MICRO_VERSION)
}

@(test)
test_loaded_library_matches_the_headers :: proc(t: ^testing.T) {
    // get_version packs the version as major*10000 + minor*100 + micro.
    bound := MAJOR_VERSION * 10000 + MINOR_VERSION * 100 + MICRO_VERSION
    testing.expect(t, int(get_version()) >= bound, "libgexiv2 is older than the bound headers")
}

@(test)
test_metadata_lifecycle_and_log_level :: proc(t: ^testing.T) {
    testing.expect(t, bool(initialize()))

    meta := metadata_new()
    testing.expect(t, meta != nil)
    testing.expect(t, bool(metadata_is_exif_tag("Exif.Image.Orientation")))
    metadata_free(meta)

    old := log_get_level()
    log_set_level(.MUTE)
    testing.expect_value(t, log_get_level(), LogLevel.MUTE)
    log_set_level(old)
}

@(test)
test_opening_a_missing_file_sets_the_error :: proc(t: ^testing.T) {
    meta := metadata_new()
    defer metadata_free(meta)
    err: ^glib.Error
    ok := metadata_open_path(meta, "/nonexistent/odin-gexiv2.jpg", &err)
    testing.expect(t, !bool(ok))
    testing.expect(t, err != nil)
    if err != nil do glib.error_free(err)
}

// Flag enums are bit_sets of the C bits (docs/DECISIONS.md §4): the size is that of the C enum
// (4 bytes) and a member's index is the position of its bit in the header (gexiv2-metadata.h).

bits :: proc(s: $S) -> u32 {
    return transmute(u32)s
}

@(test)
test_flag_sets_are_the_size_of_the_c_enum :: proc(t: ^testing.T) {
    testing.expect_value(t, size_of(XmpFormatFlags), 4)
}

@(test)
test_flag_bits_match_the_header :: proc(t: ^testing.T) {
    testing.expect_value(t, bits(XmpFormatFlags{.OMIT_PACKET_WRAPPER}), 0x10)
    testing.expect_value(t, bits(XmpFormatFlags{.READ_ONLY_PACKET}), 0x20)
    testing.expect_value(t, bits(XmpFormatFlags{.USE_COMPACT_FORMAT}), 0x40)
    testing.expect_value(t, bits(XmpFormatFlags{.INCLUDE_THUMBNAIL_PAD}), 0x100)
    testing.expect_value(t, bits(XmpFormatFlags{.EXACT_PACKET_LENGTH}), 0x200)
    testing.expect_value(t, bits(XmpFormatFlags{.WRITE_ALIAS_COMMENTS}), 0x400)
    testing.expect_value(t, bits(XmpFormatFlags{.OMIT_ALL_FORMATTING}), 0x800)
}
