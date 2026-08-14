extends Node2D

const SKIN := Color("e8b89a")
const SKIN_SHADOW := Color("c48b6e")
const EYE := Color("2a2420")
const EYE_SHINE := Color("f7f3ee")
const CLAY := Color("c46a4a")
const BOX := Color("f4f1ea")
const BOX_EDGE := Color("d9d2c5")
const PAPER := Color("f2d56b")
const SELECTED := Color("ffe08a")

var selected := false


func _ready() -> void:
	queue_redraw()


func set_selected(value: bool) -> void:
	selected = value
	queue_redraw()


func _draw() -> void:
	if selected:
		var glow := SELECTED
		glow.a = 0.35
		draw_circle(Vector2(0, 58), 78.0, glow, true, -1.0, true)
	# Cardboard box body
	var box := Rect2(-48, 8, 96, 100)
	draw_rect(box, BOX, true, -1.0, true)
	draw_rect(box, BOX_EDGE, false, 4.0, true)
	# Hole with yellow paper
	draw_circle(Vector2(0, 58), 16.0, PAPER, true, -1.0, true)
	draw_circle(Vector2(0, 58), 16.0, Color("c9a227"), false, 2.0, true)
	# Skin-blob head
	draw_circle(Vector2(-6, -28), 44.0, SKIN_SHADOW, true, -1.0, true)
	draw_circle(Vector2(0, -36), 46.0, SKIN, true, -1.0, true)
	# Eyes
	draw_circle(Vector2(-14, -42), 7.0, EYE, true, -1.0, true)
	draw_circle(Vector2(12, -40), 7.0, EYE, true, -1.0, true)
	draw_circle(Vector2(-12, -44), 2.2, EYE_SHINE, true, -1.0, true)
	draw_circle(Vector2(14, -42), 2.2, EYE_SHINE, true, -1.0, true)
	# Clay mouth
	draw_circle(Vector2(2, -18), 11.0, CLAY, true, -1.0, true)
	draw_circle(Vector2(2, -16), 6.0, Color("a35238"), true, -1.0, true)
