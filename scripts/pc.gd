extends Node2D

const CASE := Color("3a3f46")
const CASE_LIGHT := Color("5b616a")
const SCREEN := Color("8fd7ff")
const SCREEN_DARK := Color("1b3a4a")
const KEY := Color("cfd6de")
const LOGO := Color("7ec8e8")


func _ready() -> void:
	add_to_group("pc")
	queue_redraw()


func _draw() -> void:
	# Tower
	draw_rect(Rect2(-70, -10, 48, 96), CASE, true, -1.0, true)
	draw_rect(Rect2(-70, -10, 48, 96), CASE_LIGHT, false, 3.0, true)
	draw_circle(Vector2(-46, 70), 5.0, Color("4ad67a"), true, -1.0, true)
	draw_rect(Rect2(-62, 8, 32, 10), Color("2a2e34"), true, -1.0, true)
	# Monitor
	draw_rect(Rect2(-18, -54, 110, 78), CASE, true, -1.0, true)
	draw_rect(Rect2(-10, -46, 94, 54), SCREEN_DARK, true, -1.0, true)
	draw_rect(Rect2(-6, -42, 86, 46), SCREEN, true, -1.0, true)
	draw_circle(Vector2(37, -19), 10.0, LOGO, true, -1.0, true)
	# Stand and keyboard
	draw_rect(Rect2(28, 24, 16, 18), CASE_LIGHT, true, -1.0, true)
	draw_rect(Rect2(-8, 42, 92, 14), KEY, true, -1.0, true)
	draw_rect(Rect2(-8, 42, 92, 14), CASE, false, 2.0, true)
