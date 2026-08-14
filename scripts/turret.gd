extends Node2D

const FIRE_EVERY := 0.5
const BULLET_SPEED := 520.0
const RANGE := 520.0
const BULLET_SCENE := preload("res://scenes/bullet.tscn")

const BASE := Color("4a5564")
const BASE_RIM := Color("6d7c8e")
const PAD := Color("2f3640")
const BARREL := Color("c5d2e0")
const TIP := Color("ffe08a")
const GHOST_OK := Color(1, 1, 1, 0.55)
const GHOST_BAD := Color(1, 0.35, 0.3, 0.45)

var preview := false
var preview_ok := true

var _cool: float = 0.0
var _barrel := -PI * 0.5
var _acquire: int = 0
var _target: Node2D = null


func _ready() -> void:
	if not preview:
		add_to_group("turrets")
	queue_redraw()


func _process(delta: float) -> void:
	if preview:
		modulate = GHOST_OK if preview_ok else GHOST_BAD
		queue_redraw()
		return
	_cool = maxf(0.0, _cool - delta)
	_acquire -= 1
	if _acquire <= 0:
		_target = _nearest_demon()
		_acquire = 6
	if _target != null and is_instance_valid(_target):
		_barrel = (_target.global_position - global_position).angle()
		queue_redraw()
		if _cool <= 0.0:
			_cool = FIRE_EVERY
			_fire()
	else:
		_target = null


func _fire() -> void:
	var heading := Vector2.from_angle(_barrel)
	var bullet: Area2D = BULLET_SCENE.instantiate()
	bullet.global_position = global_position + heading * 34.0
	bullet.velocity = heading * BULLET_SPEED
	bullet.damage = 1
	bullet.tint = Color("ffd36a")
	get_tree().current_scene.add_child(bullet)


func _nearest_demon() -> Node2D:
	var best: Node2D = null
	var best_d := RANGE
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
	draw_circle(Vector2.ZERO, 28.0, PAD, true, -1.0, true)
	draw_circle(Vector2.ZERO, 22.0, BASE, true, -1.0, true)
	draw_circle(Vector2.ZERO, 22.0, BASE_RIM, false, 3.0, true)
	draw_circle(Vector2.ZERO, 8.0, Color("1c222a"), true, -1.0, true)
	var nose := Vector2.from_angle(_barrel)
	draw_line(nose * 8.0, nose * 36.0, BARREL, 10.0, true)
	draw_circle(nose * 36.0, 6.0, TIP, true, -1.0, true)
	if preview:
		var ring := Color("ffe08a")
		ring.a = 0.22 if preview_ok else 0.12
		draw_circle(Vector2.ZERO, RANGE, ring, false, 2.0, true)
