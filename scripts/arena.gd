extends Node2D

const GRASS := preload("res://assets/textures/grass.png")
const PLAZA := preload("res://assets/textures/plaza.png")
const SIZE := Vector2(4200, 3200)


func _ready() -> void:
	z_index = -10
	queue_redraw()


func _draw() -> void:
	var origin := -SIZE * 0.5
	draw_texture_rect(GRASS, Rect2(origin, SIZE), false)
	draw_texture_rect(PLAZA, Rect2(-520, -520, 1040, 1040), false)
	draw_rect(Rect2(origin, SIZE), Color("2a3f1c"), false, 28.0, true)
