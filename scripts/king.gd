extends CharacterBody2D

const TEX := preload("res://assets/sprites/king.png")
const HEIGHT := 168.0
const OFFSET := Vector2(0, 8)
const SELECTED := Color("ffe08a")
const WALK_SPEED := 180.0
const I_FRAMES_MS := 450

signal died

var selected := false
var max_hits: int = 24
var hits_left: int = 24
var _has_target := false
var _target := Vector2.ZERO
var _hurt_until_ms: int = 0


func _ready() -> void:
	add_to_group("king")
	GameArt.attach(self, TEX, HEIGHT, OFFSET)
	_add_health_bar()
	queue_redraw()


func hit(amount: int = 1) -> void:
	if hits_left <= 0:
		return
	if Time.get_ticks_msec() < _hurt_until_ms:
		return
	_hurt_until_ms = Time.get_ticks_msec() + I_FRAMES_MS
	hits_left = maxi(0, hits_left - amount)
	modulate = Color(1.0, 0.72, 0.72)
	get_tree().create_timer(0.12).timeout.connect(func() -> void: modulate = Color.WHITE)
	if hits_left <= 0:
		died.emit()


func set_selected(value: bool) -> void:
	selected = value
	if not selected:
		_has_target = false
		velocity = Vector2.ZERO
	queue_redraw()


func toggle_selected() -> void:
	set_selected(not selected)


func move_to(world_pos: Vector2) -> void:
	if not selected or hits_left <= 0:
		return
	_target = world_pos
	_has_target = true


func _physics_process(_delta: float) -> void:
	if hits_left <= 0:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	if not _has_target:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	var offset := _target - global_position
	if offset.length() <= 10.0:
		_has_target = false
		velocity = Vector2.ZERO
		move_and_slide()
		return
	velocity = offset.normalized() * WALK_SPEED
	move_and_slide()


func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse := event as InputEventMouseButton
		if mouse.pressed and mouse.button_index == MOUSE_BUTTON_LEFT:
			toggle_selected()
			get_viewport().set_input_as_handled()


func _add_health_bar() -> void:
	var bar := Node2D.new()
	bar.name = "HealthBar"
	bar.set_script(preload("res://scripts/health_bar.gd"))
	bar.position = Vector2(0, -102)
	bar.z_index = 8
	add_child(bar)


func _draw() -> void:
	var shadow := Color(0.05, 0.07, 0.04, 0.38)
	draw_set_transform(Vector2(0, 62), 0.0, Vector2(1.7, 0.45))
	draw_circle(Vector2.ZERO, 48.0, shadow, true, -1.0, true)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)
	if selected:
		var glow := SELECTED
		glow.a = 0.32
		draw_circle(Vector2(0, 20), 118.0, glow, true, -1.0, true)
