extends CharacterBody2D

signal died

const TEX := preload("res://assets/sprites/demon.png")
const HEIGHT := 112.0
const OFFSET := Vector2(0, 6)
const SPEED := 70.0
const KING_REACH := 82.0
const ROBOT_REACH := 40.0
const BITE_EVERY := 0.55

var max_hits: int = 8
var hits_left: int = 8
var _slow_until_ms: int = 0
var _bite_cool: float = 0.0
var _motion: SpriteMotion


func _ready() -> void:
	add_to_group("demons")
	var sprite := GameArt.attach(self, TEX, HEIGHT, OFFSET)
	_motion = GameArt.motion(self, sprite, SpriteMotion.Kind.WALKER)
	_motion.bob_height = 9.0
	_motion.step_rate = 12.0
	queue_redraw()


func hit(amount: int = 1) -> void:
	hits_left = maxi(0, hits_left - amount)
	if _motion:
		_motion.punch_recoil(0.8)
	if hits_left <= 0:
		died.emit()
		SaveData.add_coins(SaveData.COINS_PER_DEMON)
		queue_free()


func apply_slow(seconds: float) -> void:
	_slow_until_ms = Time.get_ticks_msec() + int(seconds * 1000.0)


func _physics_process(delta: float) -> void:
	_bite_cool = maxf(0.0, _bite_cool - delta)
	var king := get_tree().get_first_node_in_group("king") as Node2D
	var robot := get_tree().get_first_node_in_group("robot") as Node2D
	if king == null:
		return
	var to_king := king.global_position - global_position
	var speed := SPEED
	if Time.get_ticks_msec() < _slow_until_ms:
		speed *= 0.4
	if to_king.length() <= KING_REACH:
		velocity = Vector2.ZERO
	else:
		velocity = to_king.normalized() * speed
	move_and_slide()
	if _motion:
		_motion.step_rate = 6.5 if Time.get_ticks_msec() < _slow_until_ms else 12.0
		_motion.face_toward(to_king)
		_motion.set_moving(velocity.length() > 8.0, velocity)
	if _bite_cool > 0.0:
		return
	if to_king.length() <= KING_REACH and king.has_method("hit"):
		_bite_cool = BITE_EVERY
		if _motion:
			_motion.punch_lunge(to_king)
		king.hit(1)
		return
	if robot and robot.has_method("hit") and global_position.distance_to(robot.global_position) <= ROBOT_REACH:
		_bite_cool = BITE_EVERY
		if _motion:
			_motion.punch_lunge(robot.global_position - global_position)
		robot.hit(1)


func _draw() -> void:
	var shadow := Color(0.05, 0.07, 0.04, 0.35)
	draw_set_transform(Vector2(0, 46), 0.0, Vector2(1.15, 0.38))
	draw_circle(Vector2.ZERO, 22.0, shadow, true, -1.0, true)
