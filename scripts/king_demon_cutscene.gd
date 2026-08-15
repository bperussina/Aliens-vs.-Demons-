extends Node2D

const TEX := preload("res://assets/sprites/king_demon.png")
const HEIGHT := 420.0


func _ready() -> void:
	var sprite := GameArt.attach(self, TEX, HEIGHT, Vector2(0, 20))
	GameArt.motion(self, sprite, SpriteMotion.Kind.PORTRAIT)
