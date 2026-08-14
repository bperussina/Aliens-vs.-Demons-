extends Node2D

const FILL := Color("e24b4b")
const EMPTY := Color("2a2420")
const EDGE := Color("f4f1ea")

@export var width := 56.0
@export var height := 9.0


func _process(_delta: float) -> void:
	queue_redraw()


func _draw() -> void:
	var host := get_parent()
	if host == null or not ("hits_left" in host) or not ("max_hits" in host):
		return
	var hits: int = host.hits_left
	var max_hits: int = maxi(1, int(host.max_hits))
	var quarters := 4
	var filled := clampi(ceili(float(hits) / float(max_hits) * float(quarters)), 0, quarters)
	var origin := Vector2(-width * 0.5, 0.0)
	draw_rect(Rect2(origin, Vector2(width, height)), EMPTY, true, -1.0, true)
	var slice := width / float(quarters)
	for i in quarters:
		if i < filled:
			draw_rect(Rect2(origin + Vector2(slice * float(i) + 1.0, 1.0), Vector2(slice - 2.0, height - 2.0)), FILL, true, -1.0, true)
	draw_rect(Rect2(origin, Vector2(width, height)), EDGE, false, 1.5, true)
