extends Node2D

const METAL := Color("8aa0b8")
const METAL_DARK := Color("4d5d70")
const VISOR := Color("7ec8e8")
const ACCENT := Color("d4e8f5")


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	draw_circle(Vector2(0, 18), 26.0, METAL_DARK, true, -1.0, true)
	draw_circle(Vector2(0, 4), 30.0, METAL, true, -1.0, true)
	draw_circle(Vector2(0, -10), 22.0, METAL, true, -1.0, true)
	draw_rect(Rect2(-16, -18, 32, 14), VISOR, true, -1.0, true)
	draw_circle(Vector2(0, -34), 6.0, ACCENT, true, -1.0, true)
	draw_line(Vector2(0, -34), Vector2(0, -48), ACCENT, 3.0, true)
	draw_circle(Vector2(0, -50), 4.0, Color("f0c14a"), true, -1.0, true)
