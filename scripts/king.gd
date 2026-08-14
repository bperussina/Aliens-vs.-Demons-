extends CharacterBody2D

const CASE := Color("3a3f46")
const CASE_LIGHT := Color("5b616a")
const SCREEN := Color("8fd7ff")
const SCREEN_DARK := Color("1b3a4a")
const KEY := Color("cfd6de")
const LOGO := Color("7ec8e8")
const SELECTED := Color("ffe08a")
const WALK_SPEED := 180.0

var selected := false
var _has_target := false
var _target := Vector2.ZERO


func _ready() -> void:
	add_to_group("king")
	queue_redraw()


func set_selected(value: bool) -> void:
	selected = value
	if not selected:
		_has_target = false
		velocity = Vector2.ZERO
	queue_redraw()


func toggle_selected() -> void:
	set_selected(not selected)


func move_to(world_pos: Vector2) -> void:
	if not selected:
		return
	_target = world_pos
	_has_target = true


func _physics_process(_delta: float) -> void:
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


func _draw() -> void:
	if selected:
		var glow := SELECTED
		glow.a = 0.35
		draw_circle(Vector2(20, 20), 110.0, glow, true, -1.0, true)
	# The king is the computer.
	draw_rect(Rect2(-70, -10, 48, 96), CASE, true, -1.0, true)
	draw_rect(Rect2(-70, -10, 48, 96), CASE_LIGHT, false, 3.0, true)
	draw_circle(Vector2(-46, 70), 5.0, Color("4ad67a"), true, -1.0, true)
	draw_rect(Rect2(-62, 8, 32, 10), Color("2a2e34"), true, -1.0, true)
	draw_rect(Rect2(-18, -54, 110, 78), CASE, true, -1.0, true)
	draw_rect(Rect2(-10, -46, 94, 54), SCREEN_DARK, true, -1.0, true)
	draw_rect(Rect2(-6, -42, 86, 46), SCREEN, true, -1.0, true)
	draw_circle(Vector2(37, -19), 10.0, LOGO, true, -1.0, true)
	draw_rect(Rect2(28, 24, 16, 18), CASE_LIGHT, true, -1.0, true)
	draw_rect(Rect2(-8, 42, 92, 14), KEY, true, -1.0, true)
	draw_rect(Rect2(-8, 42, 92, 14), CASE, false, 2.0, true)
