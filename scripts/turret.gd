extends Node2D

const TEX := preload("res://assets/sprites/turret.png")
const HEIGHT := 96.0
const FIRE_EVERY := 0.5
const BULLET_SPEED := 520.0
const RANGE := 520.0
const BULLET_SCENE := preload("res://scenes/bullet.tscn")
const GHOST_OK := Color(1, 1, 1, 0.62)
const GHOST_BAD := Color(1, 0.38, 0.32, 0.5)

var preview := false
var preview_ok := true

var _cool: float = 0.0
var _barrel := -PI * 0.5
var _acquire: int = 0
var _target: Node2D = null
var _motion: SpriteMotion


func _ready() -> void:
	if not preview:
		add_to_group("turrets")
	var sprite := GameArt.attach(self, TEX, HEIGHT, Vector2.ZERO)
	_motion = GameArt.motion(self, sprite, SpriteMotion.Kind.TURRET)
	_motion.allow_flip = false
	queue_redraw()


func _process(delta: float) -> void:
	if preview:
		modulate = GHOST_OK if preview_ok else GHOST_BAD
		rotation = 0.0
		queue_redraw()
		return
	_cool = maxf(0.0, _cool - delta)
	_acquire -= 1
	if _acquire <= 0:
		_target = _nearest_demon()
		_acquire = 6
	rotation = 0.0
	if _target != null and is_instance_valid(_target):
		var to_target := _target.global_position - global_position
		_barrel = to_target.angle()
		if _motion:
			_motion.set_aim_lean(clampf(to_target.x / 420.0, -1.0, 1.0) * 0.16)
		if _cool <= 0.0:
			_cool = FIRE_EVERY
			_fire()
	else:
		_target = null
		if _motion:
			_motion.set_aim_lean(0.0)


func _fire() -> void:
	var heading := Vector2.from_angle(_barrel)
	var bullet: Area2D = BULLET_SCENE.instantiate()
	bullet.global_position = global_position + heading * 42.0
	bullet.velocity = heading * BULLET_SPEED
	bullet.damage = 1
	bullet.tint = Color("ffd36a")
	get_tree().current_scene.add_child(bullet)
	if _motion:
		_motion.punch_recoil(1.0)


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
	var shadow := Color(0.05, 0.07, 0.04, 0.34)
	draw_set_transform(Vector2(0, 28), 0.0, Vector2(1.2, 0.4))
	draw_circle(Vector2.ZERO, 26.0, shadow, true, -1.0, true)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	if preview:
		var ring := Color("ffe08a")
		ring.a = 0.22 if preview_ok else 0.12
		draw_circle(Vector2.ZERO, RANGE, ring, false, 2.0, true)
