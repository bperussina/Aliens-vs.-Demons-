class_name SceneFlow
extends Object

const MENU := "res://scenes/main_menu.tscn"
const MATCH := "res://scenes/main.tscn"
const SETTINGS := "res://scenes/settings_menu.tscn"
const MULTIPLAYER := "res://scenes/multiplayer_menu.tscn"


static func go(path: String) -> void:
	var tree := Engine.get_main_loop() as SceneTree
	tree.change_scene_to_file(path)
