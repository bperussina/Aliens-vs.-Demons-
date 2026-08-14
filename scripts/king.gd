extends CharacterBody2D

const SKIN := Color("e8b89a")
const SKIN_SHADOW := Color("c48b6e")
const EYE := Color("2a2420")
const EYE_SHINE := Color("f7f3ee")
const CLAY := Color("c46a4a")
const BOX := Color("f4f1ea")
const BOX_EDGE := Color("d9d2c5")
const PAPER := Color("f2d56b")
const SELECTED := Color("ffe08a")
const WALK_SPEED := 180.0

var selected := false
var _has_target := false
var _target := Vector2.ZERO


func _ready() -> void:
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
		draw_circle(Vector2(0, 58), 78.0, glow, true, -1.0, true)
	var box := Rect2(-48, 8, 96, 100)
	draw_rect(box, BOX, true, -1.0, true)
	draw_rect(box, BOX_EDGE, false, 4.0, true)
	draw_circle(Vector2(0, 58), 16.0, PAPER, true, -1.0, true)
	draw_circle(Vector2(0, 58), 16.0, Color("c9a227"), false, 2.0, true)
	draw_circle(Vector2(-6, -28), 44.0, SKIN_SHADOW, true, -1.0, true)
	draw_circle(Vector2(0, -36), 46.0, SKIN, true, -1.0, true)
	draw_circle(Vector2(-14, -42), 7.0, EYE, true, -1.0, true)
	draw_circle(Vector2(12, -40), 7.0, EYE, true, -1.0, true)
	draw_circle(Vector2(-12, -44), 2.2, EYE_SHINE, true, -1.0, true)
	draw_circle(Vector2(14, -42), 2.2, EYE_SHINE, true, -1.0, true)
	draw_circle(Vector2(2, -18), 11.0, CLAY, true, -1.0, true)
	draw_circle(Vector2(2, -16), 6.0, Color("a35238"), true, -1.0, true)
