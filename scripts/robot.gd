extends CharacterBody2D

const SPEED := 280.0

@onready var _visual: Node2D = $Visual


func _ready() -> void:
	add_to_group("robot")


func _physics_process(_delta: float) -> void:
	var direction := _move_direction()
	velocity = direction * SPEED
	move_and_slide()
	if direction != Vector2.ZERO:
		_visual.rotation = direction.angle() + PI * 0.5


func _move_direction() -> Vector2:
	var x := int(_pressed(KEY_D) or _pressed(KEY_RIGHT)) - int(_pressed(KEY_A) or _pressed(KEY_LEFT))
	var y := int(_pressed(KEY_S) or _pressed(KEY_DOWN)) - int(_pressed(KEY_W) or _pressed(KEY_UP))
	return Vector2(x, y).normalized()


func _pressed(keycode: Key) -> bool:
	return Input.is_physical_key_pressed(keycode)
