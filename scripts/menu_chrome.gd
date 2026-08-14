class_name MenuChrome
extends RefCounted

const GREEN := Color("4f8f45")
const PANEL := Color("2f6b32")
const PANEL_HOVER := Color("3d8540")
const TEXT := Color("f4f7ef")
const TITLE := Color("f7fff0")


static func paint_background(rect: ColorRect) -> void:
	rect.color = GREEN
	rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE


static func style_button(button: Button) -> void:
	button.custom_minimum_size = Vector2(420, 64)
	button.add_theme_font_size_override("font_size", 28)
	button.add_theme_color_override("font_color", TEXT)
	button.add_theme_color_override("font_hover_color", Color.WHITE)
	button.add_theme_stylebox_override("normal", _box(PANEL))
	button.add_theme_stylebox_override("hover", _box(PANEL_HOVER))
	button.add_theme_stylebox_override("pressed", _box(Color("245528")))
	button.add_theme_stylebox_override("focus", _box(PANEL_HOVER))


static func style_title(label: Label) -> void:
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 64)
	label.add_theme_color_override("font_color", TITLE)


static func style_subtitle(label: Label) -> void:
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 22)
	label.add_theme_color_override("font_color", Color("dff5d4"))


static func _box(color: Color) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.set_corner_radius_all(18)
	box.content_margin_left = 28
	box.content_margin_right = 28
	box.content_margin_top = 14
	box.content_margin_bottom = 14
	return box
