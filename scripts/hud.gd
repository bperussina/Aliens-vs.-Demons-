extends CanvasLayer

@onready var _level: Label = $Top/Level
@onready var _status: Label = $Top/Status
@onready var _coins: Label = $Top/Coins
@onready var _skills: Label = $Skills
@onready var _cutscene: Control = $Cutscene
@onready var _cutscene_line: Label = $Cutscene/Column/Line

@onready var _skill_node: Node = $"../Skills"


func _process(_delta: float) -> void:
	_coins.text = "$%d" % SaveData.coins
	if _skill_node and _skill_node.has_method("labels"):
		_skills.text = "  ".join(_skill_node.labels())


func set_level(level: int) -> void:
	_level.text = "Level %d" % level


func set_status(text: String) -> void:
	_status.text = text


func show_cutscene(on: bool) -> void:
	_cutscene.visible = on
	if on:
		_cutscene_line.text = "The King Demon stays in his chair.\nHe sends normal demons to fight."
