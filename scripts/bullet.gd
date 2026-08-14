extends Area2D

const TEX := preload("res://assets/sprites/bullet.png")
const SPEED := 520.0

var damage: int = 1
var velocity: Vector2 = Vector2.ZERO
var tint := Color("ffe08a")


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	var sprite := Sprite2D.new()
	sprite.texture = TEX
	sprite.scale = Vector2(0.55, 0.55)
	sprite.modulate = tint
	add_child(sprite)


func _physics_process(delta: float) -> void:
	global_position += velocity * delta
	rotation = velocity.angle()
	if global_position.length() > 4000.0:
		queue_free()


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("demons") and body.has_method("hit"):
		body.hit(damage)
		queue_free()
