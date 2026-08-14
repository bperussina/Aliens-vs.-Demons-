extends CharacterBody2D

const SPEED := 280.0
const FIRE_EVERY := 0.45
const BULLET_SPEED := 560.0
const WIRE_BASE := Vector2(0, -34)
const WIRE_TIP := Vector2(0, -56)
const BULLET_SCENE := preload("res://scenes/bullet.tscn")

@onready var _visual: Node2D = $Visual

var _cool: float = 0.0


func _ready() -> void:
	add_to_group("robot")


func _physics_process(_delta: float) -> void:
	var direction := _move_direction()
	velocity = direction * SPEED
	move_and_slide()
	if direction != Vector2.ZERO:
		_visual.rotation = direction.angle() + PI * 0.5


func _process(delta: float) -> void:
	_cool = maxf(0.0, _cool - delta)
	if _cool > 0.0:
		return
	if get_tree().get_nodes_in_group("demons").is_empty():
		return
	_cool = FIRE_EVERY
	_fire_from_wire()


func muzzle_global() -> Vector2:
	var marker := _visual.get_node_or_null("Muzzle") as Node2D
	if marker:
		return marker.global_position
	return _visual.to_global(WIRE_TIP)


func wire_heading() -> Vector2:
	var base := _visual.get_node_or_null("WireBase") as Node2D
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
