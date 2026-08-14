extends Node2D

const CHAIR := Color("6b3f24")
const CHAIR_DARK := Color("3d2416")
const ROBE := Color("4a1f5c")
const SKIN := Color("c49274")
const EYE := Color("2ef0ff")
const CROWN := Color("e6c35c")


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	draw_rect(Rect2(-70, 40, 140, 28), CHAIR_DARK, true, -1.0, true)
	draw_rect(Rect2(-58, -10, 116, 70), CHAIR, true, -1.0, true)
	draw_rect(Rect2(-58, -90, 116, 86), CHAIR_DARK, true, -1.0, true)
	draw_circle(Vector2(0, 20), 48.0, ROBE, true, -1.0, true)
	draw_circle(Vector2(0, -40), 36.0, SKIN, true, -1.0, true)
	draw_circle(Vector2(-14, -44), 10.0, Color("8aa0b8"), true, -1.0, true)
	draw_circle(Vector2(14, -44), 10.0, Color("8aa0b8"), true, -1.0, true)
	draw_circle(Vector2(-14, -44), 5.0, EYE, true, -1.0, true)
	draw_circle(Vector2(14, -44), 5.0, EYE, true, -1.0, true)
	draw_rect(Rect2(-22, -78, 44, 14), CROWN, true, -1.0, true)
	draw_circle(Vector2(-18, -82), 6.0, CROWN, true, -1.0, true)
	draw_circle(Vector2(0, -86), 8.0, CROWN, true, -1.0, true)
	draw_circle(Vector2(18, -82), 6.0, CROWN, true, -1.0, true)
	draw_circle(Vector2(-70, 10), 10.0, Color("6a4a3a"), true, -1.0, true)
	draw_circle(Vector2(90, 8), 12.0, Color("6a4a3a"), true, -1.0, true)
	draw_circle(Vector2(118, -10), 9.0, Color("6a4a3a"), true, -1.0, true)
