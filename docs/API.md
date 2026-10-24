# odin-gexiv2 API

Every public declaration of every package, generated from the source by `make api`; do not
edit. The reference is the [README](../README.md); the short form is the
[cheat sheet](CHEATSHEET.md).

## gexiv2:gexiv2

```text
package gexiv2
	constants
		MAJOR_VERSION :: 0
		MICRO_VERSION :: 2
		MINOR_VERSION :: 14

	procedures
		TYPE_METADATA :: proc() -> gobj.Type {...}
		TYPE_PREVIEW_IMAGE :: proc() -> gobj.Type {...}
		TYPE_PREVIEW_PROPERTIES :: proc() -> gobj.Type {...}
		get_version :: proc() -> glib.int_ ---
		initialize :: proc() -> glib.boolean ---
		log_get_default_handler :: proc() -> LogHandler ---
		log_get_handler :: proc() -> LogHandler ---
		log_get_level :: proc() -> LogLevel ---
		log_set_handler :: proc(handler: LogHandler) ---
		log_set_level :: proc(level: LogLevel) ---
		log_use_glib_logging :: proc() ---
		metadata_clear :: proc(self: ^Metadata) ---
		metadata_clear_comment :: proc(self: ^Metadata) ---
		metadata_clear_exif :: proc(self: ^Metadata) ---
		metadata_clear_iptc :: proc(self: ^Metadata) ---
		metadata_clear_tag :: proc(self: ^Metadata, tag: cstring) -> glib.boolean ---
		metadata_clear_xmp :: proc(self: ^Metadata) ---
		metadata_delete_gps_info :: proc(self: ^Metadata) ---
		metadata_erase_exif_thumbnail :: proc(self: ^Metadata) ---
		metadata_free :: proc(self: ^Metadata) ---
		metadata_from_app1_segment :: proc(self: ^Metadata, data: ^glib.uint8, n_data: glib.long, error: ^^glib.Error) -> glib.boolean ---
		metadata_from_stream :: proc(self: ^Metadata, stream: ^gio.InputStream, error: ^^glib.Error) -> glib.boolean ---
		metadata_generate_xmp_packet :: proc(self: ^Metadata, xmp_format_flags: XmpFormatFlags, padding: glib.uint32) -> cstring ---
		metadata_get_comment :: proc(self: ^Metadata) -> cstring ---
		metadata_get_exif_data :: proc(self: ^Metadata, byte_order: ByteOrder, error: ^^glib.Error) -> ^glib.Bytes ---
		metadata_get_exif_tag_rational :: proc(self: ^Metadata, tag: cstring, nom: ^glib.int_, den: ^glib.int_) -> glib.boolean ---
		metadata_get_exif_tags :: proc(self: ^Metadata) -> ^cstring ---
		metadata_get_exif_thumbnail :: proc(self: ^Metadata, buffer: ^^glib.uint8, size_p: ^glib.int_) -> glib.boolean ---
		metadata_get_exposure_time :: proc(self: ^Metadata, nom: ^glib.int_, den: ^glib.int_) -> glib.boolean ---
		metadata_get_fnumber :: proc(self: ^Metadata) -> glib.double ---
		metadata_get_focal_length :: proc(self: ^Metadata) -> glib.double ---
		metadata_get_gps_altitude :: proc(self: ^Metadata, altitude: ^glib.double) -> glib.boolean ---
		metadata_get_gps_info :: proc(self: ^Metadata, longitude: ^glib.double, latitude: ^glib.double, altitude: ^glib.double) -> glib.boolean ---
		metadata_get_gps_latitude :: proc(self: ^Metadata, latitude: ^glib.double) -> glib.boolean ---
		metadata_get_gps_longitude :: proc(self: ^Metadata, longitude: ^glib.double) -> glib.boolean ---
		metadata_get_iptc_tags :: proc(self: ^Metadata) -> ^cstring ---
		metadata_get_iso_speed :: proc(self: ^Metadata) -> glib.int_ ---
		metadata_get_metadata_pixel_height :: proc(self: ^Metadata) -> glib.int_ ---
		metadata_get_metadata_pixel_width :: proc(self: ^Metadata) -> glib.int_ ---
		metadata_get_mime_type :: proc(self: ^Metadata) -> cstring ---
		metadata_get_orientation :: proc(self: ^Metadata) -> Orientation ---
		metadata_get_pixel_height :: proc(self: ^Metadata) -> glib.int_ ---
		metadata_get_pixel_width :: proc(self: ^Metadata) -> glib.int_ ---
		metadata_get_preview_image :: proc(self: ^Metadata, props: ^PreviewProperties) -> ^PreviewImage ---
		metadata_get_preview_properties :: proc(self: ^Metadata) -> ^^PreviewProperties ---
		metadata_get_supports_exif :: proc(self: ^Metadata) -> glib.boolean ---
		metadata_get_supports_iptc :: proc(self: ^Metadata) -> glib.boolean ---
		metadata_get_supports_xmp :: proc(self: ^Metadata) -> glib.boolean ---
		metadata_get_tag_description :: proc(tag: cstring) -> cstring ---
		metadata_get_tag_interpreted_string :: proc(self: ^Metadata, tag: cstring) -> cstring ---
		metadata_get_tag_label :: proc(tag: cstring) -> cstring ---
		metadata_get_tag_long :: proc(self: ^Metadata, tag: cstring) -> glib.long ---
		metadata_get_tag_multiple :: proc(self: ^Metadata, tag: cstring) -> ^cstring ---
		metadata_get_tag_raw :: proc(self: ^Metadata, tag: cstring) -> ^glib.Bytes ---
		metadata_get_tag_string :: proc(self: ^Metadata, tag: cstring) -> cstring ---
		metadata_get_tag_type :: proc(tag: cstring) -> cstring ---
		metadata_get_type :: proc() -> gobj.Type ---
		metadata_get_xmp_namespace_for_tag :: proc(tag: cstring) -> cstring ---
		metadata_get_xmp_packet :: proc(self: ^Metadata) -> cstring ---
		metadata_get_xmp_tags :: proc(self: ^Metadata) -> ^cstring ---
		metadata_has_exif :: proc(self: ^Metadata) -> glib.boolean ---
		metadata_has_iptc :: proc(self: ^Metadata) -> glib.boolean ---
		metadata_has_tag :: proc(self: ^Metadata, tag: cstring) -> glib.boolean ---
		metadata_has_xmp :: proc(self: ^Metadata) -> glib.boolean ---
		metadata_is_exif_tag :: proc(tag: cstring) -> glib.boolean ---
		metadata_is_iptc_tag :: proc(tag: cstring) -> glib.boolean ---
		metadata_is_xmp_tag :: proc(tag: cstring) -> glib.boolean ---
		metadata_new :: proc() -> ^Metadata ---
		metadata_open_buf :: proc(self: ^Metadata, data: ^glib.uint8, n_data: glib.long, error: ^^glib.Error) -> glib.boolean ---
		metadata_open_path :: proc(self: ^Metadata, path: cstring, error: ^^glib.Error) -> glib.boolean ---
		metadata_open_stream :: proc(self: ^Metadata, cb: ^ManagedStreamCallbacks, error: ^^glib.Error) -> glib.boolean ---
		metadata_register_xmp_namespace :: proc(name: cstring, prefix: cstring) -> glib.boolean ---
		metadata_save_external :: proc(self: ^Metadata, path: cstring, error: ^^glib.Error) -> glib.boolean ---
		metadata_save_file :: proc(self: ^Metadata, path: cstring, error: ^^glib.Error) -> glib.boolean ---
		metadata_save_stream :: proc(self: ^Metadata, cb: ^ManagedStreamCallbacks, error: ^^glib.Error) -> glib.boolean ---
		metadata_set_comment :: proc(self: ^Metadata, comment: cstring) ---
		metadata_set_exif_tag_rational :: proc(self: ^Metadata, tag: cstring, nom: glib.int_, den: glib.int_) -> glib.boolean ---
		metadata_set_exif_thumbnail_from_buffer :: proc(self: ^Metadata, buffer: ^glib.uint8, size_p: glib.int_) ---
		metadata_set_exif_thumbnail_from_file :: proc(self: ^Metadata, path: cstring, error: ^^glib.Error) -> glib.boolean ---
		metadata_set_gps_info :: proc(self: ^Metadata, longitude: glib.double, latitude: glib.double, altitude: glib.double) -> glib.boolean ---
		metadata_set_metadata_pixel_height :: proc(self: ^Metadata, height: glib.int_) ---
		metadata_set_metadata_pixel_width :: proc(self: ^Metadata, width: glib.int_) ---
		metadata_set_orientation :: proc(self: ^Metadata, orientation: Orientation) ---
		metadata_set_tag_long :: proc(self: ^Metadata, tag: cstring, value: glib.long) -> glib.boolean ---
		metadata_set_tag_multiple :: proc(self: ^Metadata, tag: cstring, values: [^]cstring) -> glib.boolean ---
		metadata_set_tag_string :: proc(self: ^Metadata, tag: cstring, value: cstring) -> glib.boolean ---
		metadata_set_xmp_tag_struct :: proc(self: ^Metadata, tag: cstring, type: StructureType) -> glib.boolean ---
		metadata_try_clear_tag :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_delete_gps_info :: proc(self: ^Metadata, error: ^^glib.Error) ---
		metadata_try_erase_exif_thumbnail :: proc(self: ^Metadata, error: ^^glib.Error) ---
		metadata_try_generate_xmp_packet :: proc(self: ^Metadata, xmp_format_flags: XmpFormatFlags, padding: glib.uint32, error: ^^glib.Error) -> cstring ---
		metadata_try_get_comment :: proc(self: ^Metadata, error: ^^glib.Error) -> cstring ---
		metadata_try_get_exif_tag_rational :: proc(self: ^Metadata, tag: cstring, nom: ^glib.int_, den: ^glib.int_, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_get_exposure_time :: proc(self: ^Metadata, nom: ^glib.int_, den: ^glib.int_, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_get_fnumber :: proc(self: ^Metadata, error: ^^glib.Error) -> glib.double ---
		metadata_try_get_focal_length :: proc(self: ^Metadata, error: ^^glib.Error) -> glib.double ---
		metadata_try_get_gps_altitude :: proc(self: ^Metadata, altitude: ^glib.double, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_get_gps_info :: proc(self: ^Metadata, longitude: ^glib.double, latitude: ^glib.double, altitude: ^glib.double, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_get_gps_latitude :: proc(self: ^Metadata, latitude: ^glib.double, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_get_gps_longitude :: proc(self: ^Metadata, longitude: ^glib.double, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_get_iso_speed :: proc(self: ^Metadata, error: ^^glib.Error) -> glib.int_ ---
		metadata_try_get_metadata_pixel_height :: proc(self: ^Metadata, error: ^^glib.Error) -> glib.int_ ---
		metadata_try_get_metadata_pixel_width :: proc(self: ^Metadata, error: ^^glib.Error) -> glib.int_ ---
		metadata_try_get_orientation :: proc(self: ^Metadata, error: ^^glib.Error) -> Orientation ---
		metadata_try_get_preview_image :: proc(self: ^Metadata, props: ^PreviewProperties, error: ^^glib.Error) -> ^PreviewImage ---
		metadata_try_get_tag_description :: proc(tag: cstring, error: ^^glib.Error) -> cstring ---
		metadata_try_get_tag_interpreted_string :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> cstring ---
		metadata_try_get_tag_label :: proc(tag: cstring, error: ^^glib.Error) -> cstring ---
		metadata_try_get_tag_long :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> glib.long ---
		metadata_try_get_tag_multiple :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> ^cstring ---
		metadata_try_get_tag_raw :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> ^glib.Bytes ---
		metadata_try_get_tag_string :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> cstring ---
		metadata_try_get_tag_type :: proc(tag: cstring, error: ^^glib.Error) -> cstring ---
		metadata_try_get_xmp_namespace_for_tag :: proc(tag: cstring, error: ^^glib.Error) -> cstring ---
		metadata_try_get_xmp_packet :: proc(self: ^Metadata, error: ^^glib.Error) -> cstring ---
		metadata_try_has_tag :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_register_xmp_namespace :: proc(name: cstring, prefix: cstring, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_set_comment :: proc(self: ^Metadata, comment: cstring, error: ^^glib.Error) ---
		metadata_try_set_exif_tag_rational :: proc(self: ^Metadata, tag: cstring, nom: glib.int_, den: glib.int_, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_set_exif_thumbnail_from_buffer :: proc(self: ^Metadata, buffer: ^glib.uint8, size_p: glib.int_, error: ^^glib.Error) ---
		metadata_try_set_gps_info :: proc(self: ^Metadata, longitude: glib.double, latitude: glib.double, altitude: glib.double, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_set_metadata_pixel_height :: proc(self: ^Metadata, height: glib.int_, error: ^^glib.Error) ---
		metadata_try_set_metadata_pixel_width :: proc(self: ^Metadata, width: glib.int_, error: ^^glib.Error) ---
		metadata_try_set_orientation :: proc(self: ^Metadata, orientation: Orientation, error: ^^glib.Error) ---
		metadata_try_set_tag_long :: proc(self: ^Metadata, tag: cstring, value: glib.long, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_set_tag_multiple :: proc(self: ^Metadata, tag: cstring, values: [^]cstring, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_set_tag_string :: proc(self: ^Metadata, tag: cstring, value: cstring, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_set_xmp_tag_struct :: proc(self: ^Metadata, tag: cstring, type: StructureType, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_tag_supports_multiple_values :: proc(self: ^Metadata, tag: cstring, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_unregister_all_xmp_namespaces :: proc(error: ^^glib.Error) ---
		metadata_try_unregister_xmp_namespace :: proc(name: cstring, error: ^^glib.Error) -> glib.boolean ---
		metadata_try_update_gps_info :: proc(self: ^Metadata, longitude: glib.double, latitude: glib.double, altitude: glib.double, error: ^^glib.Error) -> glib.boolean ---
		metadata_unregister_all_xmp_namespaces :: proc() ---
		metadata_unregister_xmp_namespace :: proc(name: cstring) -> glib.boolean ---
		metadata_update_gps_info :: proc(self: ^Metadata, longitude: glib.double, latitude: glib.double, altitude: glib.double) -> glib.boolean ---
		preview_image_free :: proc(self: ^PreviewImage) ---
		preview_image_get_data :: proc(self: ^PreviewImage, size_p: ^glib.uint32) -> ^glib.uint8 ---
		preview_image_get_extension :: proc(self: ^PreviewImage) -> cstring ---
		preview_image_get_height :: proc(self: ^PreviewImage) -> glib.uint32 ---
		preview_image_get_mime_type :: proc(self: ^PreviewImage) -> cstring ---
		preview_image_get_type :: proc() -> gobj.Type ---
		preview_image_get_width :: proc(self: ^PreviewImage) -> glib.uint32 ---
		preview_image_try_write_file :: proc(self: ^PreviewImage, path: cstring, error: ^^glib.Error) -> glib.long ---
		preview_image_write_file :: proc(self: ^PreviewImage, path: cstring) -> glib.long ---
		preview_properties_get_extension :: proc(self: ^PreviewProperties) -> cstring ---
		preview_properties_get_height :: proc(self: ^PreviewProperties) -> glib.uint32 ---
		preview_properties_get_mime_type :: proc(self: ^PreviewProperties) -> cstring ---
		preview_properties_get_size :: proc(self: ^PreviewProperties) -> glib.uint32 ---
		preview_properties_get_type :: proc() -> gobj.Type ---
		preview_properties_get_width :: proc(self: ^PreviewProperties) -> glib.uint32 ---

	types
		ByteOrder :: enum u32 {LITTLE = 0, BIG = 1}
		LogHandler :: #type proc(level: LogLevel, msg: cstring)
		LogLevel :: enum u32 {DEBUG = 0, INFO = 1, WARN = 2, ERROR = 3, MUTE = 4}
		ManagedStreamCallbacks :: _ManagedStreamCallbacks
		Metadata :: struct {parent_instance: gobj.Object, priv: ^MetadataPrivate}
		MetadataClass :: struct {parent_class: gobj.ObjectClass}
		MetadataPrivate :: struct #packed {}
		Orientation :: enum u32 {MIN = 0, UNSPECIFIED = 0, NORMAL = 1, HFLIP = 2, ROT_180 = 3, VFLIP = 4, ROT_90_HFLIP = 5, ROT_90 = 6, ROT_90_VFLIP = 7, ROT_270 = 8, MAX = 8}
		PreviewImage :: struct {parent_instance: gobj.Object, priv: ^PreviewImagePrivate}
		PreviewImageClass :: struct {parent_class: gobj.ObjectClass}
		PreviewImagePrivate :: struct #packed {}
		PreviewProperties :: struct {parent_instance: gobj.Object, priv: ^PreviewPropertiesPrivate}
		PreviewPropertiesClass :: struct {parent_class: gobj.ObjectClass}
		PreviewPropertiesPrivate :: struct #packed {}
		Stream_CanRead :: #type proc(handle: rawptr) -> glib.boolean
		Stream_CanSeek :: #type proc(handle: rawptr) -> glib.boolean
		Stream_CanWrite :: #type proc(handle: rawptr) -> glib.boolean
		Stream_Flush :: #type proc(handle: rawptr)
		Stream_Length :: #type proc(handle: rawptr) -> glib.int64
		Stream_Position :: #type proc(handle: rawptr) -> glib.int64
		Stream_Read :: #type proc(handle: rawptr, buffer: rawptr, offset: glib.int32, count: glib.int32) -> glib.int32
		Stream_Seek :: #type proc(handle: rawptr, offset: glib.int64, origin: WrapperSeekOrigin)
		Stream_Write :: #type proc(handle: rawptr, buffer: rawptr, offset: glib.int32, count: glib.int32)
		StructureType :: enum u32 {STRUCTURE_XA_NONE = 0, STRUCTURE_XA_ALT = 20, STRUCTURE_XA_BAG = 21, STRUCTURE_XA_SEQ = 22, STRUCTURE_XA_LANG = 23}
		WrapperSeekOrigin :: enum u32 {Begin = 0, Current = 1, End = 2}
		XmpFormatFlags :: bit_set[XmpFormatFlagsBit]
		XmpFormatFlagsBit :: enum u32 {OMIT_PACKET_WRAPPER = 4, READ_ONLY_PACKET = 5, USE_COMPACT_FORMAT = 6, INCLUDE_THUMBNAIL_PAD = 8, EXACT_PACKET_LENGTH = 9, WRITE_ALIAS_COMMENTS = 10, OMIT_ALL_FORMATTING = 11}
		_ManagedStreamCallbacks :: struct {handle: rawptr, CanSeek: Stream_CanSeek, CanRead: Stream_CanRead, CanWrite: Stream_CanWrite, Length: Stream_Length, Position: Stream_Position, Read: Stream_Read, Write: Stream_Write, Seek: Stream_Seek, Flush: Stream_Flush}

	files:
		gexiv2.odin
		patched.odin
```
