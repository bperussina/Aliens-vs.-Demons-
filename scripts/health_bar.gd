extends Node2D

const FILL := Color("e24b4b")
const EMPTY := Color("2a2420")
const EDGE := Color("f4f1ea")


func _draw() -> void:
	var demon := get_parent()
	if demon == null or not ("hits_left" in demon):
		return
	var hits: int = demon.hits_left
	var quarters := 4
	var filled := ceili(float(hits) / 2.0)
	var width := 48.0
	var height := 8.0
	var origin := Vector2(-width * 0.5, -72.0)
	draw_rect(Rect2(origin, Vector2(width, height)), EMPTY, true, -1.0, true)
	var slice := width / float(quarters)
	for i in quarters:
		if i < filled:
			draw_rect(Rect2(origin + Vector2(slice * float(i) + 1.0, 1.0), Vector2(slice - 2.0, height - 2.0)), FILL, true, -1.0, true)
	draw_rect(Rect2(origin, Vector2(width, height)), EDGE, false, 1.5, true)
