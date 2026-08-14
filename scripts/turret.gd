extends Node2D

const FIRE_EVERY := 0.55
const BULLET_SCENE := preload("res://scenes/bullet.tscn")

var _cool: float = 0.0


func _process(delta: float) -> void:
	_cool = maxf(0.0, _cool - delta)
	if _cool > 0.0:
		return
	var target := _nearest_demon()
	if target == null:
		return
	_cool = FIRE_EVERY
	var bullet: Area2D = BULLET_SCENE.instantiate()
	bullet.global_position = global_position + Vector2(0, -36)
	var heading := (target.global_position - bullet.global_position).normalized()
	bullet.velocity = heading * 520.0
	bullet.damage = 1
	bullet.tint = Color("ffe08a")
	get_tree().current_scene.add_child(bullet)
	queue_redraw()


func _nearest_demon() -> Node2D:
	var best: Node2D = null
	var best_d := INF
	for node in get_tree().get_nodes_in_group("demons"):
		var demon := node as Node2D
		if demon == null:
			continue
		var d := global_position.distance_to(demon.global_position)
		if d < best_d:
			best_d = d
			best = demon
	return best


func _draw() -> void:
	draw_rect(Rect2(-8, -44, 16, 22), Color("6a7180"), true, -1.0, true)
	draw_circle(Vector2(0, -48), 7.0, Color("d4e8f5"), true, -1.0, true)
