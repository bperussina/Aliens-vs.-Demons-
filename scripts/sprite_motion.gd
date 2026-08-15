class_name SpriteMotion
extends Node

enum Kind { WALKER, TURRET, PORTRAIT }

var kind: Kind = Kind.WALKER
var bob_height := 8.0
var step_rate := 10.0
var allow_flip := true

var _sprite: Sprite2D
var _base_pos := Vector2.ZERO
var _base_scale := Vector2.ONE
var _phase := 0.0
var _moving := false
var _recoil := 0.0
var _nudge := Vector2.ZERO
var _walk_lean := 0.0
var _aim_lean := 0.0


func setup(sprite: Sprite2D, motion_kind: Kind = Kind.WALKER) -> void:
	_sprite = sprite
	kind = motion_kind
	_base_pos = sprite.position
	_base_scale = sprite.scale
	_phase = randf() * TAU


func set_moving(on: bool, velocity: Vector2 = Vector2.ZERO) -> void:
	_moving = on
	_walk_lean = clampf(velocity.x * 0.00035, -0.14, 0.14) if on else 0.0
	if _sprite == null:
		return
	if allow_flip and absf(velocity.x) > 6.0:
		_sprite.flip_h = velocity.x < 0.0


func face_toward(world_delta: Vector2) -> void:
	if _sprite == null or not allow_flip:
		return
	if absf(world_delta.x) > 4.0:
		_sprite.flip_h = world_delta.x < 0.0


func set_aim_lean(radians: float) -> void:
	_aim_lean = radians


func punch_recoil(amount: float = 1.0) -> void:
	_recoil = maxf(_recoil, amount)


func punch_lunge(toward: Vector2) -> void:
	if toward.length() < 0.01:
		return
	_nudge = toward.normalized() * 10.0
	_recoil = 0.7


func _process(delta: float) -> void:
	if _sprite == null or not is_instance_valid(_sprite):
		return
	_recoil = move_toward(_recoil, 0.0, delta * 7.0)
	_nudge = _nudge.lerp(Vector2.ZERO, clampf(delta * 12.0, 0.0, 1.0))
	var speed := step_rate if _moving else 2.4
	if kind == Kind.PORTRAIT:
		speed = 1.8
	elif kind == Kind.TURRET:
		speed = 2.0
	_phase += delta * speed
	var wave := sin(_phase)
	var bob := 0.0
	var squash := Vector2.ONE
	var tilt := 0.0
	match kind:
		Kind.WALKER:
			if _moving:
				bob = absf(wave) * bob_height
				var land := 1.0 - absf(wave)
				squash = Vector2(1.0 + land * 0.1, 1.0 - land * 0.1)
				tilt = wave * 0.11
			else:
				bob = wave * 2.2
				var breath := sin(_phase * 0.5)
				squash = Vector2(1.0 + breath * 0.025, 1.0 - breath * 0.02)
				tilt = breath * 0.03
			squash *= Vector2(1.0 + _recoil * 0.12, 1.0 - _recoil * 0.14)
		Kind.TURRET:
			bob = wave * 1.4
			squash = Vector2(1.0 + _recoil * 0.16, 1.0 - _recoil * 0.18)
			var hum := sin(_phase * 0.5) * 0.02
			squash *= Vector2(1.0 + hum, 1.0 - hum)
		Kind.PORTRAIT:
			bob = wave * 5.0
			tilt = sin(_phase * 0.65) * 0.04
			var breath := sin(_phase * 0.45)
			squash = Vector2(1.0 + breath * 0.02, 1.0 - breath * 0.015)
	var sway := wave * 2.8 if kind == Kind.WALKER and _moving else 0.0
	_sprite.position = _base_pos + _nudge + Vector2(sway, -bob)
	_sprite.scale = _base_scale * squash
	_sprite.rotation = tilt + _walk_lean + _aim_lean
