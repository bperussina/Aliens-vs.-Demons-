extends Area2D

const SPEED := 520.0

var damage: int = 1
var velocity: Vector2 = Vector2.ZERO
var tint := Color("ffe08a")


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	queue_redraw()


func _physics_process(delta: float) -> void:
	global_position += velocity * delta
	if global_position.length() > 4000.0:
		queue_free()


func _draw() -> void:
	draw_circle(Vector2.ZERO, 6.0, tint, true, -1.0, true)
	draw_circle(Vector2.ZERO, 3.0, Color.WHITE, true, -1.0, true)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("demons") and body.has_method("hit"):
		body.hit(damage)
		queue_free()
