extends CharacterBody2D

signal died

const OFFSET := Vector2(0, 6)
const KING_REACH := 82.0
const ROBOT_REACH := 40.0

var kind: int = DemonCatalog.Kind.NORMAL
var player_level: int = 1
var max_hits: int = 8
var hits_left: int = 8
var coins_value: int = 10
var bite_damage: int = 1
var _speed: float = 70.0
var _bite_every: float = 0.55
var _slow_until_ms: int = 0
var _bite_cool: float = 0.0
var _motion: SpriteMotion


func setup(p_kind: int, p_level: int) -> void:
	kind = p_kind
	player_level = p_level


func _ready() -> void:
	add_to_group("demons")
	max_hits = DemonCatalog.hits(kind, player_level)
	hits_left = max_hits
	coins_value = DemonCatalog.coins(kind)
	bite_damage = DemonCatalog.bite(kind)
	_speed = DemonCatalog.speed(kind, player_level)
	_bite_every = DemonCatalog.bite_every(kind)
	var world_height := DemonCatalog.height(kind)
	var sprite := GameArt.attach(self, DemonCatalog.texture(kind), world_height, OFFSET)
	_motion = GameArt.motion(self, sprite, SpriteMotion.Kind.WALKER)
	_motion.floaty = DemonCatalog.floaty(kind)
	_motion.bob_height = 13.0 if _motion.floaty else 9.0
	_motion.step_rate = 8.0 if _motion.floaty else 12.0
	var shape_node := get_node_or_null("CollisionShape2D") as CollisionShape2D
	if shape_node and shape_node.shape is CircleShape2D:
		var circle := (shape_node.shape as CircleShape2D).duplicate() as CircleShape2D
		circle.radius = DemonCatalog.collision_radius(kind)
		shape_node.shape = circle
	var bar := get_node_or_null("HealthBar") as Node2D
	if bar:
		bar.position = Vector2(0.0, DemonCatalog.bar_y(kind))
	queue_redraw()


func hit(amount: int = 1) -> void:
	hits_left = maxi(0, hits_left - amount)
	if _motion:
		_motion.punch_recoil(0.8)
	if hits_left <= 0:
		died.emit()
		SaveData.add_coins(coins_value)
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
	var speed := _speed
	if Time.get_ticks_msec() < _slow_until_ms:
		speed *= 0.4
	if to_king.length() <= KING_REACH:
		velocity = Vector2.ZERO
	else:
		velocity = to_king.normalized() * speed
	move_and_slide()
	if _motion:
		_motion.step_rate = (4.5 if _motion.floaty else 6.5) if Time.get_ticks_msec() < _slow_until_ms else (8.0 if _motion.floaty else 12.0)
		_motion.face_toward(to_king)
		_motion.set_moving(velocity.length() > 8.0, velocity)
	if _bite_cool > 0.0:
		return
	if to_king.length() <= KING_REACH and king.has_method("hit"):
		_bite_cool = _bite_every
		if _motion:
			_motion.punch_lunge(to_king)
		king.hit(bite_damage)
		return
	if robot and robot.has_method("hit") and global_position.distance_to(robot.global_position) <= ROBOT_REACH:
		_bite_cool = _bite_every
		if _motion:
			_motion.punch_lunge(robot.global_position - global_position)
		robot.hit(bite_damage)


func _draw() -> void:
	var shadow := Color(0.05, 0.07, 0.04, 0.35)
	var flatten := 1.15 if kind == DemonCatalog.Kind.NORMAL else 1.35
	draw_set_transform(Vector2(0, 46), 0.0, Vector2(flatten, 0.38))
	draw_circle(Vector2.ZERO, 22.0 if kind == DemonCatalog.Kind.NORMAL else 28.0, shadow, true, -1.0, true)
