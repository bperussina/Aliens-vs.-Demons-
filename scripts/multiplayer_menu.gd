extends Control

@onready var _background: ColorRect = $Background
@onready var _title: Label = $Center/Column/Title
@onready var _body: Label = $Center/Column/Body
@onready var _back: Button = $Center/Column/Back


func _ready() -> void:
	MenuChrome.paint_background(_background)
	MenuChrome.style_title(_title)
	MenuChrome.style_subtitle(_body)
	MenuChrome.style_button(_back)
	_back.pressed.connect(func() -> void: SceneFlow.go(SceneFlow.MENU))
