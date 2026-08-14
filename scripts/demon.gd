extends CharacterBody2D

signal died

const TEX := preload("res://assets/sprites/demon.png")
const HEIGHT := 112.0
const OFFSET := Vector2(0, 6)
const MAX_HITS := 8
const SPEED := 70.0

var hits_left: int = MAX_HITS
var _slow_until_ms: int = 0

@onready var _bar: Node2D = $HealthBar


func _ready() -> void:
	add_to_group("demons")
	GameArt.attach(self, TEX, HEIGHT, OFFSET)
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
	var king := get_tree().get_first_node_in_group("king") as Node2D
	if king == null:
		return
	var to_king := king.global_position - global_position
	if to_king.length() < 70.0:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	var speed := SPEED
	if Time.get_ticks_msec() < _slow_until_ms:
		speed *= 0.4
	velocity = to_king.normalized() * speed
	move_and_slide()


func _draw() -> void:
	var shadow := Color(0.05, 0.07, 0.04, 0.35)
	draw_set_transform(Vector2(0, 46), 0.0, Vector2(1.15, 0.38))
	draw_circle(Vector2.ZERO, 22.0, shadow, true, -1.0, true)
