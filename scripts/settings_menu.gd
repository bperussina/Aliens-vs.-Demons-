extends Control

@onready var _background: ColorRect = $Background
@onready var _title: Label = $Center/Column/Title
@onready var _body: Label = $Center/Column/Body
@onready var _fullscreen: CheckButton = $Center/Column/Fullscreen
@onready var _back: Button = $Center/Column/Back


func _ready() -> void:
	MenuChrome.paint_background(_background)
	MenuChrome.style_title(_title)
	MenuChrome.style_subtitle(_body)
	MenuChrome.style_button(_back)
	_fullscreen.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	_fullscreen.toggled.connect(_on_fullscreen)
	_back.pressed.connect(func() -> void: SceneFlow.go(SceneFlow.MENU))


func _on_fullscreen(pressed: bool) -> void:
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if pressed else DisplayServer.WINDOW_MODE_WINDOWED
	)
