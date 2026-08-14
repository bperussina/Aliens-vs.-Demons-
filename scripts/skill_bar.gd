extends Node

const BULLET_SCENE := preload("res://scenes/bullet.tscn")

var _ready_at: Array[int] = [0, 0, 0, 0, 0, 0, 0, 0]

const NAMES: PackedStringArray = [
	"1 Fire",
	"2 Magic",
	"3 Acid",
	"4 Frost",
	"5 Spark",
	"6 Void",
	"7 Gum",
	"8 Quake",
]


func _unhandled_input(event: InputEvent) -> void:
	if not event is InputEventKey or not event.pressed or event.echo:
		return
	var key := event as InputEventKey
	var slot := _slot_for(key.physical_keycode)
	if slot < 0:
		return
	if not _can_cast(slot):
		return
	_cast(slot)
	get_viewport().set_input_as_handled()


func labels() -> PackedStringArray:
	var now := Time.get_ticks_msec()
	var out: PackedStringArray = []
	for i in 8:
		if now < _ready_at[i]:
			var left := ceili(float(_ready_at[i] - now) / 1000.0)
			out.append("%s (%ds)" % [NAMES[i], left])
		else:
			out.append(NAMES[i])
	return out


func _slot_for(code: Key) -> int:
	match code:
		KEY_1: return 0
		KEY_2: return 1
		KEY_3: return 2
		KEY_4: return 3
		KEY_5: return 4
		KEY_6: return 5
		KEY_7: return 6
		KEY_8: return 7
		_: return -1


func _can_cast(slot: int) -> bool:
	return Time.get_ticks_msec() >= _ready_at[slot]


func _cast(slot: int) -> void:
	var cool: Array[int] = [3500, 2500, 4000, 4000, 5000, 3000, 3500, 6000]
	_ready_at[slot] = Time.get_ticks_msec() + cool[slot]
	var origin := _muzzle()
	var target := _nearest(origin)
	match slot:
		0:
			_burst(origin, target, Color("ff6a2a"), 3, 220.0)
		1:
			_shot(origin, target, Color("b07cff"), 2)
		2:
			_burst(origin, target, Color("8fd94a"), 3, 160.0)
		3:
			_shot(origin, target, Color("9ad8ff"), 1)
			if target:
				target.apply_slow(2.5)
		4:
			_shot(origin, target, Color("ffe566"), 4)
		5:
			_shot(origin, target, Color("5a2a8a"), 2)
		6:
			_burst(origin, target, Color("ff8ad4"), 2, 140.0)
		7:
			_quake(origin)


func _muzzle() -> Vector2:
	var robot := get_tree().get_first_node_in_group("robot") as Node2D
	if robot:
		return robot.global_position
	return Vector2.ZERO


func _nearest(from: Vector2) -> Node:
	var best: Node = null
	var best_d := INF
	for node in get_tree().get_nodes_in_group("demons"):
		var demon := node as Node2D
		if demon == null:
			continue
		var d := from.distance_to(demon.global_position)
		if d < best_d:
			best_d = d
			best = node
	return best


func _shot(from: Vector2, target: Node, tint: Color, damage: int) -> void:
	if target == null:
		return
	var bullet: Area2D = BULLET_SCENE.instantiate()
	bullet.global_position = from
	bullet.velocity = ((target as Node2D).global_position - from).normalized() * 640.0
	bullet.damage = damage
	bullet.tint = tint
	get_tree().current_scene.add_child(bullet)


func _burst(_from: Vector2, target: Node, _tint: Color, damage: int, radius: float) -> void:
	if target == null:
		return
	var center := (target as Node2D).global_position
	for node in get_tree().get_nodes_in_group("demons"):
		var demon := node as Node2D
		if demon and center.distance_to(demon.global_position) <= radius and demon.has_method("hit"):
			demon.hit(damage)


func _quake(from: Vector2) -> void:
	for node in get_tree().get_nodes_in_group("demons"):
		var demon := node as Node2D
		if demon and from.distance_to(demon.global_position) <= 260.0 and demon.has_method("hit"):
			demon.hit(2)
