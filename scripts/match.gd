extends Node2D

@onready var _king: CharacterBody2D = $King


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		SceneFlow.go(SceneFlow.MENU)
		get_viewport().set_input_as_handled()
		return
	if event is InputEventMouseButton:
		var mouse := event as InputEventMouseButton
		if mouse.pressed and mouse.button_index == MOUSE_BUTTON_LEFT:
			_king.move_to(get_global_mouse_position())
			get_viewport().set_input_as_handled()
