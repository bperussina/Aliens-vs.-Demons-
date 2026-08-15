extends Node2D

const TEX := preload("res://assets/sprites/robot.png")
const HEIGHT := 124.0
const OFFSET := Vector2(0, 10)

var motion: SpriteMotion


func _ready() -> void:
	var sprite := GameArt.attach(self, TEX, HEIGHT, OFFSET)
	motion = GameArt.motion(self, sprite, SpriteMotion.Kind.WALKER)
	motion.bob_height = 7.0
	motion.step_rate = 11.0
	var muzzle := Marker2D.new()
	muzzle.name = "Muzzle"
	muzzle.position = GameArt.muzzle_offset(HEIGHT, Vector2.ZERO)
	sprite.add_child(muzzle)
	var base := Marker2D.new()
	base.name = "WireBase"
	base.position = Vector2(0.0, -HEIGHT * 0.22)
	sprite.add_child(base)
	queue_redraw()


func _draw() -> void:
	var shadow := Color(0.05, 0.07, 0.04, 0.35)
	draw_set_transform(Vector2(0, 42), 0.0, Vector2(1.35, 0.42))
	draw_circle(Vector2.ZERO, 28.0, shadow, true, -1.0, true)
