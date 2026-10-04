package gexiv2

import gio "glib:gio"
import glib "glib:glib"
import gobj "glib:gobject"

TYPE_PREVIEW_PROPERTIES :: #force_inline proc "c" () -> gobj.Type { return preview_properties_get_type() }
TYPE_PREVIEW_IMAGE :: #force_inline proc "c" () -> gobj.Type { return preview_image_get_type() }
TYPE_METADATA :: #force_inline proc "c" () -> gobj.Type { return metadata_get_type() }
MAJOR_VERSION :: 0
MINOR_VERSION :: 14
MICRO_VERSION :: 2

WrapperSeekOrigin :: enum u32 {Begin = 0, Current = 1, End = 2 }
Stream_CanSeek :: #type proc "c" (handle: rawptr) -> glib.boolean
Stream_CanRead :: #type proc "c" (handle: rawptr) -> glib.boolean
Stream_CanWrite :: #type proc "c" (handle: rawptr) -> glib.boolean
Stream_Length :: #type proc "c" (handle: rawptr) -> glib.int64
Stream_Position :: #type proc "c" (handle: rawptr) -> glib.int64
Stream_Read :: #type proc "c" (handle: rawptr, buffer: rawptr, offset: glib.int32, count: glib.int32) -> glib.int32
Stream_Write :: #type proc "c" (handle: rawptr, buffer: rawptr, offset: glib.int32, count: glib.int32)
Stream_Seek :: #type proc "c" (handle: rawptr, offset: glib.int64, origin: WrapperSeekOrigin)
Stream_Flush :: #type proc "c" (handle: rawptr)
_ManagedStreamCallbacks :: struct {
    handle: rawptr,
    CanSeek: Stream_CanSeek,
    CanRead: Stream_CanRead,
    CanWrite: Stream_CanWrite,
    Length: Stream_Length,
    Position: Stream_Position,
    Read: Stream_Read,
    Write: Stream_Write,
    Seek: Stream_Seek,
    Flush: Stream_Flush,
}
ManagedStreamCallbacks :: _ManagedStreamCallbacks
PreviewPropertiesPrivate :: struct #packed {}

PreviewProperties :: struct {
    parent_instance: gobj.Object,
    priv: ^PreviewPropertiesPrivate,
}

PreviewPropertiesClass :: struct {
    parent_class: gobj.ObjectClass,
}

PreviewImagePrivate :: struct #packed {}

PreviewImage :: struct {
    parent_instance: gobj.Object,
    priv: ^PreviewImagePrivate,
}

PreviewImageClass :: struct {
    parent_class: gobj.ObjectClass,
}

Orientation :: enum u32 {MIN = 0, UNSPECIFIED = 0, NORMAL = 1, HFLIP = 2, ROT_180 = 3, VFLIP = 4, ROT_90_HFLIP = 5, ROT_90 = 6, ROT_90_VFLIP = 7, ROT_270 = 8, MAX = 8 }
StructureType :: enum u32 {STRUCTURE_XA_NONE = 0, STRUCTURE_XA_ALT = 20, STRUCTURE_XA_BAG = 21, STRUCTURE_XA_SEQ = 22, STRUCTURE_XA_LANG = 23 }
XmpFormatFlagsBit :: enum u32 {OMIT_PACKET_WRAPPER = 4, READ_ONLY_PACKET = 5, USE_COMPACT_FORMAT = 6, INCLUDE_THUMBNAIL_PAD = 8, EXACT_PACKET_LENGTH = 9, WRITE_ALIAS_COMMENTS = 10, OMIT_ALL_FORMATTING = 11}
XmpFormatFlags :: bit_set[XmpFormatFlagsBit; u32]
ByteOrder :: enum u32 {LITTLE = 0, BIG = 1 }
MetadataPrivate :: struct #packed {}

Metadata :: struct {
    parent_instance: gobj.Object,
    priv: ^MetadataPrivate,
}

MetadataClass :: struct {
    parent_class: gobj.ObjectClass,
}

LogLevel :: enum u32 {DEBUG = 0, INFO = 1, WARN = 2, ERROR = 3, MUTE = 4 }
LogHandler :: #type proc "c" (level: LogLevel, msg: cstring)

@(default_calling_convention = "c")
foreign gexiv2_runic {
    @(link_name = "gexiv2_preview_properties_get_type")
    preview_properties_get_type :: proc() -> gobj.Type ---

    @(link_name = "gexiv2_preview_properties_get_mime_type")
    preview_properties_get_mime_type :: proc(self: ^PreviewProperties) -> cstring ---

    @(link_name = "gexiv2_preview_properties_get_extension")
    preview_properties_get_extension :: proc(self: ^PreviewProperties) -> cstring ---

    @(link_name = "gexiv2_preview_properties_get_size")
    preview_properties_get_size :: proc(self: ^PreviewProperties) -> glib.uint32 ---

    @(link_name = "gexiv2_preview_properties_get_width")
    preview_properties_get_width :: proc(self: ^PreviewProperties) -> glib.uint32 ---

    @(link_name = "gexiv2_preview_properties_get_height")
    preview_properties_get_height :: proc(self: ^PreviewProperties) -> glib.uint32 ---

    @(link_name = "gexiv2_preview_image_get_type")
    preview_image_get_type :: proc() -> gobj.Type ---

    @(link_name = "gexiv2_preview_image_free")
    preview_image_free :: proc(self: ^PreviewImage) ---

    @(link_name = "gexiv2_preview_image_get_data")
    preview_image_get_data :: proc(self: ^PreviewImage, size_p: ^glib.uint32) -> ^glib.uint8 ---

    @(link_name = "gexiv2_preview_image_get_mime_type")
    preview_image_get_mime_type :: proc(self: ^PreviewImage) -> cstring ---

    @(link_name = "gexiv2_preview_image_get_extension")
    preview_image_get_extension :: proc(self: ^PreviewImage) -> cstring ---

    @(link_name = "gexiv2_preview_image_get_width")
    preview_image_get_width :: proc(self: ^PreviewImage) -> glib.uint32 ---

    @(link_name = "gexiv2_preview_image_get_height")
    preview_image_get_height :: proc(self: ^PreviewImage) -> glib.uint32 ---

    @(link_name = "gexiv2_preview_image_write_file")
    preview_image_write_file :: proc(self: ^PreviewImage, path: cstring) -> glib.long ---

    @(link_name = "gexiv2_preview_image_try_write_file")
    preview_image_try_write_file :: proc(self: ^PreviewImage, path: cstring, error: ^^glib.Error) -> glib.long ---

    @(link_name = "gexiv2_metadata_get_type")
    metadata_get_type :: proc() -> gobj.Type ---

    @(link_name = "gexiv2_metadata_new")
    metadata_new :: proc() -> ^Metadata ---

    @(link_name = "gexiv2_metadata_free")
    metadata_free :: proc(self: ^Metadata) ---

    @(link_name = "gexiv2_metadata_open_path")
    metadata_open_path :: proc(self: ^Metadata, path: cstring, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_open_buf")
    metadata_open_buf :: proc(self: ^Metadata, data: ^glib.uint8, n_data: glib.long, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_open_stream")
    metadata_open_stream :: proc(self: ^Metadata, cb: ^ManagedStreamCallbacks, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_from_stream")
    metadata_from_stream :: proc(self: ^Metadata, stream: ^gio.InputStream, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_from_app1_segment")
    metadata_from_app1_segment :: proc(self: ^Metadata, data: ^glib.uint8, n_data: glib.long, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_save_external")
    metadata_save_external :: proc(self: ^Metadata, path: cstring, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_save_file")
    metadata_save_file :: proc(self: ^Metadata, path: cstring, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_save_stream")
    metadata_save_stream :: proc(self: ^Metadata, cb: ^ManagedStreamCallbacks, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_has_tag")
    metadata_has_tag :: proc(self: ^Metadata, tag: cstring) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_has_tag")
    metadata_try_has_tag :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_clear_tag")
    metadata_clear_tag :: proc(self: ^Metadata, tag: cstring) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_clear_tag")
    metadata_try_clear_tag :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_clear")
    metadata_clear :: proc(self: ^Metadata) ---

    @(link_name = "gexiv2_metadata_is_exif_tag")
    metadata_is_exif_tag :: proc(tag: cstring) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_is_iptc_tag")
    metadata_is_iptc_tag :: proc(tag: cstring) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_is_xmp_tag")
    metadata_is_xmp_tag :: proc(tag: cstring) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_get_tag_label")
    metadata_try_get_tag_label :: proc(tag: cstring, error: ^^glib.Error) -> cstring ---

    @(link_name = "gexiv2_metadata_get_tag_label")
    metadata_get_tag_label :: proc(tag: cstring) -> cstring ---

    @(link_name = "gexiv2_metadata_try_get_tag_description")
    metadata_try_get_tag_description :: proc(tag: cstring, error: ^^glib.Error) -> cstring ---

    @(link_name = "gexiv2_metadata_get_tag_description")
    metadata_get_tag_description :: proc(tag: cstring) -> cstring ---

    @(link_name = "gexiv2_metadata_try_get_tag_type")
    metadata_try_get_tag_type :: proc(tag: cstring, error: ^^glib.Error) -> cstring ---

    @(link_name = "gexiv2_metadata_get_tag_type")
    metadata_get_tag_type :: proc(tag: cstring) -> cstring ---

    @(link_name = "gexiv2_metadata_try_tag_supports_multiple_values")
    metadata_try_tag_supports_multiple_values :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_supports_exif")
    metadata_get_supports_exif :: proc(self: ^Metadata) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_supports_iptc")
    metadata_get_supports_iptc :: proc(self: ^Metadata) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_supports_xmp")
    metadata_get_supports_xmp :: proc(self: ^Metadata) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_mime_type")
    metadata_get_mime_type :: proc(self: ^Metadata) -> cstring ---

    @(link_name = "gexiv2_metadata_get_pixel_width")
    metadata_get_pixel_width :: proc(self: ^Metadata) -> glib.int_ ---

    @(link_name = "gexiv2_metadata_get_pixel_height")
    metadata_get_pixel_height :: proc(self: ^Metadata) -> glib.int_ ---

    @(link_name = "gexiv2_metadata_try_get_tag_string")
    metadata_try_get_tag_string :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> cstring ---

    @(link_name = "gexiv2_metadata_try_set_tag_string")
    metadata_try_set_tag_string :: proc(self: ^Metadata, tag: cstring, value: cstring, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_tag_string")
    metadata_get_tag_string :: proc(self: ^Metadata, tag: cstring) -> cstring ---

    @(link_name = "gexiv2_metadata_set_tag_string")
    metadata_set_tag_string :: proc(self: ^Metadata, tag: cstring, value: cstring) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_set_xmp_tag_struct")
    metadata_try_set_xmp_tag_struct :: proc(self: ^Metadata, tag: cstring, type: StructureType, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_set_xmp_tag_struct")
    metadata_set_xmp_tag_struct :: proc(self: ^Metadata, tag: cstring, type: StructureType) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_get_tag_interpreted_string")
    metadata_try_get_tag_interpreted_string :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> cstring ---

    @(link_name = "gexiv2_metadata_get_tag_interpreted_string")
    metadata_get_tag_interpreted_string :: proc(self: ^Metadata, tag: cstring) -> cstring ---

    @(link_name = "gexiv2_metadata_try_get_tag_long")
    metadata_try_get_tag_long :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> glib.long ---

    @(link_name = "gexiv2_metadata_get_tag_long")
    metadata_get_tag_long :: proc(self: ^Metadata, tag: cstring) -> glib.long ---

    @(link_name = "gexiv2_metadata_try_set_tag_long")
    metadata_try_set_tag_long :: proc(self: ^Metadata, tag: cstring, value: glib.long, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_set_tag_long")
    metadata_set_tag_long :: proc(self: ^Metadata, tag: cstring, value: glib.long) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_get_tag_multiple")
    metadata_try_get_tag_multiple :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> ^cstring ---

    @(link_name = "gexiv2_metadata_try_set_tag_multiple")
    metadata_try_set_tag_multiple :: proc(self: ^Metadata, tag: cstring, values: [^]cstring, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_tag_multiple")
    metadata_get_tag_multiple :: proc(self: ^Metadata, tag: cstring) -> ^cstring ---

    @(link_name = "gexiv2_metadata_set_tag_multiple")
    metadata_set_tag_multiple :: proc(self: ^Metadata, tag: cstring, values: [^]cstring) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_get_tag_raw")
    metadata_try_get_tag_raw :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> ^glib.Bytes ---

    @(link_name = "gexiv2_metadata_get_tag_raw")
    metadata_get_tag_raw :: proc(self: ^Metadata, tag: cstring) -> ^glib.Bytes ---

    @(link_name = "gexiv2_metadata_has_exif")
    metadata_has_exif :: proc(self: ^Metadata) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_clear_exif")
    metadata_clear_exif :: proc(self: ^Metadata) ---

    @(link_name = "gexiv2_metadata_get_exif_tags")
    metadata_get_exif_tags :: proc(self: ^Metadata) -> ^cstring ---

    @(link_name = "gexiv2_metadata_try_get_exif_tag_rational")
    metadata_try_get_exif_tag_rational :: proc(self: ^Metadata, tag: cstring, nom: ^glib.int_, den: ^glib.int_, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_set_exif_tag_rational")
    metadata_try_set_exif_tag_rational :: proc(self: ^Metadata, tag: cstring, nom: glib.int_, den: glib.int_, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_exif_tag_rational")
    metadata_get_exif_tag_rational :: proc(self: ^Metadata, tag: cstring, nom: ^glib.int_, den: ^glib.int_) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_set_exif_tag_rational")
    metadata_set_exif_tag_rational :: proc(self: ^Metadata, tag: cstring, nom: glib.int_, den: glib.int_) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_exif_thumbnail")
    metadata_get_exif_thumbnail :: proc(self: ^Metadata, buffer: ^^glib.uint8, size_p: ^glib.int_) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_set_exif_thumbnail_from_file")
    metadata_set_exif_thumbnail_from_file :: proc(self: ^Metadata, path: cstring, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_set_exif_thumbnail_from_buffer")
    metadata_set_exif_thumbnail_from_buffer :: proc(self: ^Metadata, buffer: ^glib.uint8, size_p: glib.int_) ---

    @(link_name = "gexiv2_metadata_try_set_exif_thumbnail_from_buffer")
    metadata_try_set_exif_thumbnail_from_buffer :: proc(self: ^Metadata, buffer: ^glib.uint8, size_p: glib.int_, error: ^^glib.Error) ---

    @(link_name = "gexiv2_metadata_erase_exif_thumbnail")
    metadata_erase_exif_thumbnail :: proc(self: ^Metadata) ---

    @(link_name = "gexiv2_metadata_try_erase_exif_thumbnail")
    metadata_try_erase_exif_thumbnail :: proc(self: ^Metadata, error: ^^glib.Error) ---

    @(link_name = "gexiv2_metadata_get_exif_data")
    metadata_get_exif_data :: proc(self: ^Metadata, byte_order: ByteOrder, error: ^^glib.Error) -> ^glib.Bytes ---

    @(link_name = "gexiv2_metadata_has_xmp")
    metadata_has_xmp :: proc(self: ^Metadata) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_clear_xmp")
    metadata_clear_xmp :: proc(self: ^Metadata) ---

    @(link_name = "gexiv2_metadata_try_generate_xmp_packet")
    metadata_try_generate_xmp_packet :: proc(self: ^Metadata, xmp_format_flags: XmpFormatFlags, padding: glib.uint32, error: ^^glib.Error) -> cstring ---

    @(link_name = "gexiv2_metadata_generate_xmp_packet")
    metadata_generate_xmp_packet :: proc(self: ^Metadata, xmp_format_flags: XmpFormatFlags, padding: glib.uint32) -> cstring ---

    @(link_name = "gexiv2_metadata_try_get_xmp_packet")
    metadata_try_get_xmp_packet :: proc(self: ^Metadata, error: ^^glib.Error) -> cstring ---

    @(link_name = "gexiv2_metadata_get_xmp_packet")
    metadata_get_xmp_packet :: proc(self: ^Metadata) -> cstring ---

    @(link_name = "gexiv2_metadata_get_xmp_tags")
    metadata_get_xmp_tags :: proc(self: ^Metadata) -> ^cstring ---

    @(link_name = "gexiv2_metadata_register_xmp_namespace")
    metadata_register_xmp_namespace :: proc(name: cstring, prefix: cstring) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_register_xmp_namespace")
    metadata_try_register_xmp_namespace :: proc(name: cstring, prefix: cstring, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_unregister_xmp_namespace")
    metadata_unregister_xmp_namespace :: proc(name: cstring) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_unregister_xmp_namespace")
    metadata_try_unregister_xmp_namespace :: proc(name: cstring, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_unregister_all_xmp_namespaces")
    metadata_unregister_all_xmp_namespaces :: proc() ---

    @(link_name = "gexiv2_metadata_try_unregister_all_xmp_namespaces")
    metadata_try_unregister_all_xmp_namespaces :: proc(error: ^^glib.Error) ---

    @(link_name = "gexiv2_metadata_get_xmp_namespace_for_tag")
    metadata_get_xmp_namespace_for_tag :: proc(tag: cstring) -> cstring ---

    @(link_name = "gexiv2_metadata_try_get_xmp_namespace_for_tag")
    metadata_try_get_xmp_namespace_for_tag :: proc(tag: cstring, error: ^^glib.Error) -> cstring ---

    @(link_name = "gexiv2_metadata_has_iptc")
    metadata_has_iptc :: proc(self: ^Metadata) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_clear_iptc")
    metadata_clear_iptc :: proc(self: ^Metadata) ---

    @(link_name = "gexiv2_metadata_get_iptc_tags")
    metadata_get_iptc_tags :: proc(self: ^Metadata) -> ^cstring ---

    @(link_name = "gexiv2_metadata_get_orientation")
    metadata_get_orientation :: proc(self: ^Metadata) -> Orientation ---

    @(link_name = "gexiv2_metadata_try_get_orientation")
    metadata_try_get_orientation :: proc(self: ^Metadata, error: ^^glib.Error) -> Orientation ---

    @(link_name = "gexiv2_metadata_set_orientation")
    metadata_set_orientation :: proc(self: ^Metadata, orientation: Orientation) ---

    @(link_name = "gexiv2_metadata_try_set_orientation")
    metadata_try_set_orientation :: proc(self: ^Metadata, orientation: Orientation, error: ^^glib.Error) ---

    @(link_name = "gexiv2_metadata_get_metadata_pixel_width")
    metadata_get_metadata_pixel_width :: proc(self: ^Metadata) -> glib.int_ ---

    @(link_name = "gexiv2_metadata_try_get_metadata_pixel_width")
    metadata_try_get_metadata_pixel_width :: proc(self: ^Metadata, error: ^^glib.Error) -> glib.int_ ---

    @(link_name = "gexiv2_metadata_get_metadata_pixel_height")
    metadata_get_metadata_pixel_height :: proc(self: ^Metadata) -> glib.int_ ---

    @(link_name = "gexiv2_metadata_try_get_metadata_pixel_height")
    metadata_try_get_metadata_pixel_height :: proc(self: ^Metadata, error: ^^glib.Error) -> glib.int_ ---

    @(link_name = "gexiv2_metadata_set_metadata_pixel_width")
    metadata_set_metadata_pixel_width :: proc(self: ^Metadata, width: glib.int_) ---

    @(link_name = "gexiv2_metadata_try_set_metadata_pixel_width")
    metadata_try_set_metadata_pixel_width :: proc(self: ^Metadata, width: glib.int_, error: ^^glib.Error) ---

    @(link_name = "gexiv2_metadata_set_metadata_pixel_height")
    metadata_set_metadata_pixel_height :: proc(self: ^Metadata, height: glib.int_) ---

    @(link_name = "gexiv2_metadata_try_set_metadata_pixel_height")
    metadata_try_set_metadata_pixel_height :: proc(self: ^Metadata, height: glib.int_, error: ^^glib.Error) ---

    @(link_name = "gexiv2_metadata_get_comment")
    metadata_get_comment :: proc(self: ^Metadata) -> cstring ---

    @(link_name = "gexiv2_metadata_try_get_comment")
    metadata_try_get_comment :: proc(self: ^Metadata, error: ^^glib.Error) -> cstring ---

    @(link_name = "gexiv2_metadata_set_comment")
    metadata_set_comment :: proc(self: ^Metadata, comment: cstring) ---

    @(link_name = "gexiv2_metadata_try_set_comment")
    metadata_try_set_comment :: proc(self: ^Metadata, comment: cstring, error: ^^glib.Error) ---

    @(link_name = "gexiv2_metadata_clear_comment")
    metadata_clear_comment :: proc(self: ^Metadata) ---

    @(link_name = "gexiv2_metadata_get_exposure_time")
    metadata_get_exposure_time :: proc(self: ^Metadata, nom: ^glib.int_, den: ^glib.int_) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_get_exposure_time")
    metadata_try_get_exposure_time :: proc(self: ^Metadata, nom: ^glib.int_, den: ^glib.int_, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_fnumber")
    metadata_get_fnumber :: proc(self: ^Metadata) -> glib.double ---

    @(link_name = "gexiv2_metadata_try_get_fnumber")
    metadata_try_get_fnumber :: proc(self: ^Metadata, error: ^^glib.Error) -> glib.double ---

    @(link_name = "gexiv2_metadata_get_focal_length")
    metadata_get_focal_length :: proc(self: ^Metadata) -> glib.double ---

    @(link_name = "gexiv2_metadata_try_get_focal_length")
    metadata_try_get_focal_length :: proc(self: ^Metadata, error: ^^glib.Error) -> glib.double ---

    @(link_name = "gexiv2_metadata_get_iso_speed")
    metadata_get_iso_speed :: proc(self: ^Metadata) -> glib.int_ ---

    @(link_name = "gexiv2_metadata_try_get_iso_speed")
    metadata_try_get_iso_speed :: proc(self: ^Metadata, error: ^^glib.Error) -> glib.int_ ---

    @(link_name = "gexiv2_metadata_try_get_gps_longitude")
    metadata_try_get_gps_longitude :: proc(self: ^Metadata, longitude: ^glib.double, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_get_gps_latitude")
    metadata_try_get_gps_latitude :: proc(self: ^Metadata, latitude: ^glib.double, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_get_gps_altitude")
    metadata_try_get_gps_altitude :: proc(self: ^Metadata, altitude: ^glib.double, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_gps_longitude")
    metadata_get_gps_longitude :: proc(self: ^Metadata, longitude: ^glib.double) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_gps_latitude")
    metadata_get_gps_latitude :: proc(self: ^Metadata, latitude: ^glib.double) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_gps_altitude")
    metadata_get_gps_altitude :: proc(self: ^Metadata, altitude: ^glib.double) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_get_gps_info")
    metadata_try_get_gps_info :: proc(self: ^Metadata, longitude: ^glib.double, latitude: ^glib.double, altitude: ^glib.double, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_get_gps_info")
    metadata_get_gps_info :: proc(self: ^Metadata, longitude: ^glib.double, latitude: ^glib.double, altitude: ^glib.double) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_set_gps_info")
    metadata_try_set_gps_info :: proc(self: ^Metadata, longitude: glib.double, latitude: glib.double, altitude: glib.double, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_set_gps_info")
    metadata_set_gps_info :: proc(self: ^Metadata, longitude: glib.double, latitude: glib.double, altitude: glib.double) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_update_gps_info")
    metadata_try_update_gps_info :: proc(self: ^Metadata, longitude: glib.double, latitude: glib.double, altitude: glib.double, error: ^^glib.Error) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_update_gps_info")
    metadata_update_gps_info :: proc(self: ^Metadata, longitude: glib.double, latitude: glib.double, altitude: glib.double) -> glib.boolean ---

    @(link_name = "gexiv2_metadata_try_delete_gps_info")
    metadata_try_delete_gps_info :: proc(self: ^Metadata, error: ^^glib.Error) ---

    @(link_name = "gexiv2_metadata_delete_gps_info")
    metadata_delete_gps_info :: proc(self: ^Metadata) ---

    @(link_name = "gexiv2_metadata_get_preview_properties")
    metadata_get_preview_properties :: proc(self: ^Metadata) -> ^^PreviewProperties ---

    @(link_name = "gexiv2_metadata_get_preview_image")
    metadata_get_preview_image :: proc(self: ^Metadata, props: ^PreviewProperties) -> ^PreviewImage ---

    @(link_name = "gexiv2_metadata_try_get_preview_image")
    metadata_try_get_preview_image :: proc(self: ^Metadata, props: ^PreviewProperties, error: ^^glib.Error) -> ^PreviewImage ---

    @(link_name = "gexiv2_log_get_level")
    log_get_level :: proc() -> LogLevel ---

    @(link_name = "gexiv2_log_set_level")
    log_set_level :: proc(level: LogLevel) ---

    @(link_name = "gexiv2_log_get_handler")
    log_get_handler :: proc() -> LogHandler ---

    @(link_name = "gexiv2_log_get_default_handler")
    log_get_default_handler :: proc() -> LogHandler ---

    @(link_name = "gexiv2_log_set_handler")
    log_set_handler :: proc(handler: LogHandler) ---

    @(link_name = "gexiv2_log_use_glib_logging")
    log_use_glib_logging :: proc() ---

    @(link_name = "gexiv2_initialize")
    initialize :: proc() -> glib.boolean ---

    @(link_name = "gexiv2_get_version")
    get_version :: proc() -> glib.int_ ---

}

foreign import gexiv2_runic "system:gexiv2"

