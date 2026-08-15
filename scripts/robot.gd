extends CharacterBody2D

const SPEED := 280.0
const FIRE_EVERY := 0.45
const BULLET_SPEED := 560.0
const WIRE_BASE := Vector2(0, -34)
const WIRE_TIP := Vector2(0, -56)
const I_FRAMES_MS := 550
const BULLET_SCENE := preload("res://scenes/bullet.tscn")

signal died

@onready var _visual: Node2D = $Visual

var max_hits: int = 8
var hits_left: int = 8
var _cool: float = 0.0
var _hurt_until_ms: int = 0
var _aim := Vector2.UP


func _ready() -> void:
	add_to_group("robot")
	_add_health_bar()


func hit(amount: int = 1) -> void:
	if hits_left <= 0:
		return
	if Time.get_ticks_msec() < _hurt_until_ms:
		return
	_hurt_until_ms = Time.get_ticks_msec() + I_FRAMES_MS
	hits_left = maxi(0, hits_left - amount)
	modulate = Color(1.0, 0.7, 0.7)
	get_tree().create_timer(0.12).timeout.connect(func() -> void: modulate = Color.WHITE)
	if _visual.motion:
		_visual.motion.punch_recoil(1.0)
	if hits_left <= 0:
		died.emit()


func _physics_process(_delta: float) -> void:
	if hits_left <= 0:
		velocity = Vector2.ZERO
		move_and_slide()
		if _visual.motion:
			_visual.motion.set_moving(false)
		return
	var direction := _move_direction()
	velocity = direction * SPEED
	move_and_slide()
	if direction != Vector2.ZERO:
		_aim = direction
	if _visual.motion:
		_visual.motion.set_moving(direction != Vector2.ZERO, direction)


func _process(delta: float) -> void:
	if hits_left <= 0:
		return
	_cool = maxf(0.0, _cool - delta)
	if _cool > 0.0:
		return
	if get_tree().get_nodes_in_group("demons").is_empty():
		return
	_cool = FIRE_EVERY
	_fire_from_wire()
	if _visual.motion:
		_visual.motion.punch_recoil(0.85)


func muzzle_global() -> Vector2:
	var marker := _visual.get_node_or_null("Art/Muzzle") as Node2D
	if marker:
		return marker.global_position
	return _visual.to_global(WIRE_TIP)


func wire_heading() -> Vector2:
	if _aim.length() > 0.1:
		return _aim.normalized()
	var base := _visual.get_node_or_null("Art/WireBase") as Node2D
	var from := base.global_position if base else _visual.to_global(WIRE_BASE)
	return (muzzle_global() - from).normalized()


func _fire_from_wire() -> void:
	var tip := muzzle_global()
	var heading := wire_heading()
	if heading.length() < 0.1:
		return
	var bullet: Area2D = BULLET_SCENE.instantiate()
	bullet.global_position = tip
	bullet.velocity = heading * BULLET_SPEED
	bullet.damage = 1
	bullet.tint = Color("ffe08a")
	get_tree().current_scene.add_child(bullet)


func _move_direction() -> Vector2:
	var x := int(_pressed(KEY_D) or _pressed(KEY_RIGHT)) - int(_pressed(KEY_A) or _pressed(KEY_LEFT))
	var y := int(_pressed(KEY_S) or _pressed(KEY_DOWN)) - int(_pressed(KEY_W) or _pressed(KEY_UP))
	return Vector2(x, y).normalized()


func _pressed(keycode: Key) -> bool:
	return Input.is_physical_key_pressed(keycode)


func _add_health_bar() -> void:
	var bar := Node2D.new()
	bar.name = "HealthBar"
	bar.set_script(preload("res://scripts/health_bar.gd"))
	bar.position = Vector2(0, -78)
	bar.z_index = 8
	add_child(bar)
