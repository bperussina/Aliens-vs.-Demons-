extends Control

@onready var _background: ColorRect = $Background
@onready var _title: Label = $Center/Column/Title
@onready var _subtitle: Label = $Center/Column/Subtitle
@onready var _single: Button = $Center/Column/SinglePlayer
@onready var _multi: Button = $Center/Column/Multiplayer
@onready var _settings: Button = $Center/Column/Settings
@onready var _quit: Button = $Center/Column/Quit


func _ready() -> void:
	MenuChrome.paint_background(_background)
	MenuChrome.style_title(_title)
	MenuChrome.style_subtitle(_subtitle)
	for button in [_single, _multi, _settings, _quit]:
		MenuChrome.style_button(button)
	_single.pressed.connect(func() -> void: SceneFlow.go(SceneFlow.MATCH))
	_multi.pressed.connect(func() -> void: SceneFlow.go(SceneFlow.MULTIPLAYER))
	_settings.pressed.connect(func() -> void: SceneFlow.go(SceneFlow.SETTINGS))
	_quit.pressed.connect(func() -> void: get_tree().quit())
