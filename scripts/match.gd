extends Node2D

const DEMON_SCENE := preload("res://scenes/demon.tscn")
const COUNTDOWN_SECONDS := 10.0
const CUTSCENE_SECONDS := 4.5
const FINAL_WAVE := 50

enum Phase { COUNTDOWN, CUTSCENE, WAVE, WON }

@onready var _king: CharacterBody2D = $King
@onready var _hud: CanvasLayer = $Hud

var _phase: Phase = Phase.COUNTDOWN
var _clock: float = COUNTDOWN_SECONDS
var _wave: int = 1
var _alive: int = 0


func _ready() -> void:
	_hud.set_level(SaveData.level)
	_hud.set_status("Combat starting in 10 seconds")
	_hud.show_cutscene(false)


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


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		SceneFlow.go(SceneFlow.MENU)
		get_viewport().set_input_as_handled()
		return
	if event is InputEventMouseButton:
		var mouse := event as InputEventMouseButton
		if mouse.pressed and mouse.button_index == MOUSE_BUTTON_LEFT:
			_king.move_to(get_global_mouse_position())
			get_viewport().set_input_as_handled()


func _start_wave(wave: int) -> void:
	_phase = Phase.WAVE
	_wave = wave
	_hud.set_status("Wave %d" % _wave)
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
	if _wave >= FINAL_WAVE:
		_win_round()
		return
	_start_wave(_wave + 1)


func _win_round() -> void:
	_phase = Phase.WON
	SaveData.level_up()
	_hud.set_level(SaveData.level)
	_hud.set_status("You win the round! Level %d  —  Esc: menu" % SaveData.level)
