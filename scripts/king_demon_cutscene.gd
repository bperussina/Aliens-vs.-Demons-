extends Node2D

const TEX := preload("res://assets/sprites/king_demon.png")
const HEIGHT := 420.0


func _ready() -> void:
	GameArt.attach(self, TEX, HEIGHT, Vector2(0, 20))
