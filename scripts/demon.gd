extends CharacterBody2D

signal died

const MAX_HITS := 8
const QUARTERS := 4
const SPEED := 70.0
const SKIN := Color("d8b090")
const SHIRT := Color("6a4a3a")
const EYE_METAL := Color("9ad0e8")
const EYE_LENS := Color("2ef0ff")

var hits_left: int = MAX_HITS
var _slow_until_ms: int = 0

@onready var _bar: Node2D = $HealthBar


func _ready() -> void:
	add_to_group("demons")
	queue_redraw()
	_bar.queue_redraw()


func hit(amount: int = 1) -> void:
	hits_left = maxi(0, hits_left - amount)
	_bar.queue_redraw()
	if hits_left <= 0:
		died.emit()
		SaveData.add_coins(SaveData.COINS_PER_DEMON)
		queue_free()


func apply_slow(seconds: float) -> void:
	_slow_until_ms = Time.get_ticks_msec() + int(seconds * 1000.0)


func _physics_process(_delta: float) -> void:
	var pc := get_tree().get_first_node_in_group("pc") as Node2D
	if pc == null:
		return
	var to_pc := pc.global_position - global_position
	if to_pc.length() < 40.0:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	var speed := SPEED
	if Time.get_ticks_msec() < _slow_until_ms:
		speed *= 0.4
	velocity = to_pc.normalized() * speed
	move_and_slide()


func _draw() -> void:
	draw_circle(Vector2(0, 22), 16.0, Color("3a322c"), true, -1.0, true)
	draw_rect(Rect2(-16, -8, 32, 36), SHIRT, true, -1.0, true)
	draw_circle(Vector2(0, -22), 20.0, SKIN, true, -1.0, true)
	draw_circle(Vector2(-8, -24), 7.0, EYE_METAL, true, -1.0, true)
	draw_circle(Vector2(8, -24), 7.0, EYE_METAL, true, -1.0, true)
	draw_circle(Vector2(-8, -24), 3.5, EYE_LENS, true, -1.0, true)
	draw_circle(Vector2(8, -24), 3.5, EYE_LENS, true, -1.0, true)
	draw_rect(Rect2(-11, -6, 8, 22), SKIN, true, -1.0, true)
	draw_rect(Rect2(3, -6, 8, 22), SKIN, true, -1.0, true)
