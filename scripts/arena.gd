extends Node2D

const SIZE := Vector2(4200, 3200)
const GRASS := Color("6b8f4e")
const GRASS_DARK := Color("547a3c")
const DIRT := Color("c4a574")
const PATH := Color("d7c09a")


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	var origin := -SIZE * 0.5
	draw_rect(Rect2(origin, SIZE), GRASS, true)
	# Soft patches — illustrated field, not a tile grid.
	for i in 18:
		var seed_x := float((i * 73) % 97) / 97.0
		var seed_y := float((i * 41) % 89) / 89.0
		var center := origin + Vector2(seed_x * SIZE.x, seed_y * SIZE.y)
		var radius := 140.0 + float(i % 5) * 40.0
		var color := GRASS_DARK if i % 2 == 0 else DIRT
		color.a = 0.35
		draw_circle(center, radius, color, true, -1.0, true)
	var path_color := PATH
	path_color.a = 0.55
	draw_circle(Vector2.ZERO, 420.0, path_color, true, -1.0, true)
	# Arena edge ring so the camera has a readable world bound.
	draw_rect(Rect2(origin, SIZE), Color("3d5a28"), false, 24.0, true)
