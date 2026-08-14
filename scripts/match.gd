extends Node2D

const DEMON_SCENE := preload("res://scenes/demon.tscn")
const TURRET_SCENE := preload("res://scenes/turret.tscn")
const COUNTDOWN_SECONDS := 10.0
const CUTSCENE_SECONDS := 4.5
const TURNS := 10
const MIN_KING_GAP := 110.0
const MIN_TURRET_GAP := 72.0

enum Phase { COUNTDOWN, CUTSCENE, WAVE, WON, LOST }

@onready var _king: CharacterBody2D = $King
@onready var _robot: CharacterBody2D = $Robot
@onready var _hud: CanvasLayer = $Hud
@onready var _arena: Node2D = $Arena

var _phase: Phase = Phase.COUNTDOWN
var _clock: float = COUNTDOWN_SECONDS
var _wave: int = 1
var _alive: int = 0
var _ghost: Node2D


func _ready() -> void:
	_hud.set_level(SaveData.level)
	_hud.set_status("Combat starting in 10 seconds")
	_hud.show_cutscene(false)
	if _king.has_signal("died"):
		_king.died.connect(_on_king_died)
	if _robot.has_signal("died"):
		_robot.died.connect(_on_robot_died)
	_ghost = TURRET_SCENE.instantiate()
	_ghost.preview = true
	_ghost.z_index = 20
	add_child(_ghost)


func _process(delta: float) -> void:
	match _phase:
		Phase.COUNTDOWN:
			_clock -= delta
			var left := maxi(0, ceili(_clock))
			_hud.set_status("Combat starting in %d seconds" % left)
			if _clock <= 0.0:
				_phase = Phase.CUTSCENE
				_clock = CUTSCENE_SECONDS
				_hud.show_cutscene(true)
				_hud.set_status("")
		Phase.CUTSCENE:
			_clock -= delta
			if _clock <= 0.0:
				_hud.show_cutscene(false)
				_start_wave(1)
		Phase.WAVE:
			pass
		Phase.WON:
			pass
		Phase.LOST:
			pass
	_update_ghost()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if _hud.shop_open:
			_hud.set_shop_open(false)
			get_viewport().set_input_as_handled()
			return
		SceneFlow.go(SceneFlow.MENU)
		get_viewport().set_input_as_handled()
		return
	if event is InputEventMouseButton:
		var mouse := event as InputEventMouseButton
		if mouse.pressed and mouse.button_index == MOUSE_BUTTON_LEFT:
			_on_map_click(get_global_mouse_position())
			get_viewport().set_input_as_handled()


func _on_map_click(world_pos: Vector2) -> void:
	if _hud.shop_open:
		_hud.set_shop_open(false)
		return
	if _king.selected:
		_king.move_to(world_pos)
		return
	if not _can_place():
		return
	if not _spot_ok(world_pos):
		return
	if not SaveData.consume_turret():
		return
	var turret: Node2D = TURRET_SCENE.instantiate()
	turret.global_position = world_pos
	add_child(turret)


func _can_place() -> bool:
	return (
		SaveData.turrets > 0
		and _phase != Phase.CUTSCENE
		and _phase != Phase.LOST
		and not _hud.shop_open
		and not _king.selected
	)


func _spot_ok(world_pos: Vector2) -> bool:
	var half: Vector2 = _arena.SIZE * 0.5
	if absf(world_pos.x) > half.x - 40.0 or absf(world_pos.y) > half.y - 40.0:
		return false
	if world_pos.distance_to(_king.global_position) < MIN_KING_GAP:
		return false
	for node in get_tree().get_nodes_in_group("turrets"):
		var placed := node as Node2D
		if placed and world_pos.distance_to(placed.global_position) < MIN_TURRET_GAP:
			return false
	return true


func _update_ghost() -> void:
	if _ghost == null:
		return
	var show := _can_place()
	_ghost.visible = show
	if not show:
		return
	var pos := get_global_mouse_position()
	_ghost.global_position = pos
	_ghost.preview_ok = _spot_ok(pos)


func _start_wave(wave: int) -> void:
	if _phase == Phase.LOST or _phase == Phase.WON:
		return
	_phase = Phase.WAVE
	_wave = wave
	_hud.set_status("Turn %d / %d" % [_wave, TURNS])
	var count := mini(_wave, 10)
	_alive = count
	for i in count:
		_spawn_demon(i, count)


func _spawn_demon(index: int, total: int) -> void:
	var demon: CharacterBody2D = DEMON_SCENE.instantiate()
	var angle := TAU * float(index) / float(maxi(total, 1)) + randf() * 0.2
	demon.global_position = Vector2(cos(angle), sin(angle)) * 780.0
	demon.died.connect(_on_demon_died)
	add_child(demon)


func _on_demon_died() -> void:
	_alive = maxi(0, _alive - 1)
	if _alive > 0 or _phase != Phase.WAVE:
		return
	if _wave >= TURNS:
		_win_round()
		return
	_start_wave(_wave + 1)


func _on_king_died() -> void:
	_lose("The computer is out of health.")


func _on_robot_died() -> void:
	_lose("You are out of health.")


func _lose(reason: String) -> void:
	if _phase == Phase.LOST or _phase == Phase.WON:
		return
	_phase = Phase.LOST
	_hud.set_shop_open(false)
	_hud.set_status("%s  Esc: menu" % reason)
	for node in get_tree().get_nodes_in_group("demons"):
		node.queue_free()


func _win_round() -> void:
	_phase = Phase.WON
	SaveData.level_up()
	_hud.set_level(SaveData.level)
	_hud.set_status("You held for 10 turns! Level %d  —  Esc: menu" % SaveData.level)
