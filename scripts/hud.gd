extends CanvasLayer

var shop_open := false

@onready var _level: Label = $Top/Level
@onready var _status: Label = $Top/Status
@onready var _coins: Label = $Top/Coins
@onready var _top: HBoxContainer = $Top
@onready var _skills: Label = $Bottom/Skills
@onready var _turrets: Label = $Bottom/Turrets
@onready var _you: Label = $Vitals/You
@onready var _computer: Label = $Vitals/Computer
@onready var _cutscene: Control = $Cutscene
@onready var _cutscene_line: Label = $Cutscene/Column/Line
@onready var _skill_node: Node = $"../Skills"

var _shop_button: Button
var _shop_panel: PanelContainer
var _buy_button: Button
var _pack_button: Button
var _shop_hint: Label


func _ready() -> void:
	_build_shop()


func _process(_delta: float) -> void:
	_coins.text = "$%d" % SaveData.coins
	var on_map := get_tree().get_nodes_in_group("turrets").size()
	_turrets.text = "Turrets: %d   Map: %d/%d" % [SaveData.turrets, on_map, SaveData.MAX_PLACED]
	_refresh_vitals()
	if _skill_node and _skill_node.has_method("labels"):
		_skills.text = "  ".join(_skill_node.labels())
	if _buy_button:
		_buy_button.disabled = not SaveData.can_buy_turret()
		_buy_button.text = "Buy  $%d" % SaveData.TURRET_PRICE
	if _pack_button:
		if SaveData.unlimited_turrets:
			_pack_button.text = "Unlimited stock  owned"
			_pack_button.disabled = true
		else:
			_pack_button.text = "Unlimited stock  $%d" % SaveData.UNLIMITED_PRICE
			_pack_button.disabled = SaveData.coins < SaveData.UNLIMITED_PRICE
	if _shop_hint:
		_shop_hint.text = _hint_text(on_map)


func set_level(level: int) -> void:
	_level.text = "Level %d" % level


func set_status(text: String) -> void:
	_status.text = text


func _refresh_vitals() -> void:
	var robot := get_tree().get_first_node_in_group("robot")
	var king := get_tree().get_first_node_in_group("king")
	if _you and robot and "hits_left" in robot and "max_hits" in robot:
		_you.text = "You  %s" % _pips(int(robot.hits_left), int(robot.max_hits))
	if _computer and king and "hits_left" in king and "max_hits" in king:
		_computer.text = "Computer  %s" % _pips(int(king.hits_left), int(king.max_hits))


func _pips(hits: int, max_hits: int) -> String:
	var quarters := 4
	var filled := clampi(ceili(float(hits) / float(maxi(max_hits, 1)) * float(quarters)), 0, quarters)
	return "[" + "#".repeat(filled) + "-".repeat(quarters - filled) + "]"


func show_cutscene(on: bool) -> void:
	_cutscene.visible = on
	if on:
		set_shop_open(false)
		_cutscene_line.text = "The King Demon stays in his chair.\nHe sends normal demons to fight."


func set_shop_open(on: bool) -> void:
	shop_open = on
	if _shop_panel:
		_shop_panel.visible = on
	if _shop_button:
		_shop_button.text = "Close" if on else "Shop"


func _toggle_shop() -> void:
	set_shop_open(not shop_open)


func _buy_turret() -> void:
	if SaveData.try_buy_turret():
		_shop_hint.text = "Turret ready. Only %d can be on the map at a time." % SaveData.MAX_PLACED
	elif not SaveData.unlimited_turrets and SaveData.turrets >= SaveData.MAX_STOCK:
		_shop_hint.text = "Max %d in stock. Spend $%d for unlimited stock." % [SaveData.MAX_STOCK, SaveData.UNLIMITED_PRICE]
	else:
		_shop_hint.text = "Need $%d to buy a turret." % SaveData.TURRET_PRICE


func _buy_unlimited() -> void:
	if SaveData.try_buy_unlimited():
		_shop_hint.text = "Unlimited stock unlocked. Still only %d turrets on the map at a time." % SaveData.MAX_PLACED
	else:
		_shop_hint.text = "Need $%d for unlimited stock." % SaveData.UNLIMITED_PRICE


func _hint_text(on_map: int) -> String:
	if on_map >= SaveData.MAX_PLACED:
		return "Only %d turrets on the map at a time." % SaveData.MAX_PLACED
	if not SaveData.unlimited_turrets and SaveData.turrets >= SaveData.MAX_STOCK:
		return "Max %d in stock. Spend $%d to buy as many as you want." % [SaveData.MAX_STOCK, SaveData.UNLIMITED_PRICE]
	if SaveData.turrets <= 0:
		return "Buy a turret, then click the map to place it."
	return "Click the map to place a turret. Max %d on the map." % SaveData.MAX_PLACED


func _build_shop() -> void:
	_shop_button = Button.new()
	_shop_button.text = "Shop"
	_shop_button.custom_minimum_size = Vector2(128, 48)
	_shop_button.focus_mode = Control.FOCUS_NONE
	_style_hud_button(_shop_button)
	_shop_button.pressed.connect(_toggle_shop)
	_top.add_child(_shop_button)

	_shop_panel = PanelContainer.new()
	_shop_panel.visible = false
	_shop_panel.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	_shop_panel.offset_left = -440.0
	_shop_panel.offset_top = 84.0
	_shop_panel.offset_right = -24.0
	_shop_panel.offset_bottom = 430.0
	_shop_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	var panel_box := StyleBoxFlat.new()
	panel_box.bg_color = Color("1e2a22")
	panel_box.set_corner_radius_all(16)
	panel_box.content_margin_left = 22
	panel_box.content_margin_right = 22
	panel_box.content_margin_top = 18
	panel_box.content_margin_bottom = 18
	panel_box.border_width_left = 2
	panel_box.border_width_top = 2
	panel_box.border_width_right = 2
	panel_box.border_width_bottom = 2
	panel_box.border_color = Color("7ec86a")
	_shop_panel.add_theme_stylebox_override("panel", panel_box)

	var column := VBoxContainer.new()
	column.add_theme_constant_override("separation", 10)
	_shop_panel.add_child(column)

	var title := Label.new()
	title.text = "Shop"
	title.add_theme_font_size_override("font_size", 28)
	title.add_theme_color_override("font_color", Color("f7fff0"))
	column.add_child(title)

	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 16)
	column.add_child(row)

	var icon := TextureRect.new()
	icon.custom_minimum_size = Vector2(56, 56)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon.texture = preload("res://assets/sprites/turret.png")
	row.add_child(icon)

	var info := VBoxContainer.new()
	info.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(info)

	var name_label := Label.new()
	name_label.text = "Turret"
	name_label.add_theme_font_size_override("font_size", 22)
	name_label.add_theme_color_override("font_color", Color("f4f7ef"))
	info.add_child(name_label)

	var price := Label.new()
	price.text = "$%d" % SaveData.TURRET_PRICE
	price.add_theme_font_size_override("font_size", 20)
	price.add_theme_color_override("font_color", Color("ffe08a"))
	info.add_child(price)

	_buy_button = Button.new()
	_buy_button.text = "Buy  $%d" % SaveData.TURRET_PRICE
	_buy_button.focus_mode = Control.FOCUS_NONE
	_buy_button.custom_minimum_size = Vector2(0, 44)
	_style_hud_button(_buy_button)
	_buy_button.pressed.connect(_buy_turret)
	column.add_child(_buy_button)

	_pack_button = Button.new()
	_pack_button.focus_mode = Control.FOCUS_NONE
	_pack_button.custom_minimum_size = Vector2(0, 44)
	_style_hud_button(_pack_button)
	_pack_button.pressed.connect(_buy_unlimited)
	column.add_child(_pack_button)

	_shop_hint = Label.new()
	_shop_hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_shop_hint.add_theme_font_size_override("font_size", 16)
	_shop_hint.add_theme_color_override("font_color", Color("dff5d4"))
	column.add_child(_shop_hint)

	add_child(_shop_panel)


func _style_hud_button(button: Button) -> void:
	button.add_theme_font_size_override("font_size", 22)
	button.add_theme_color_override("font_color", Color("f4f7ef"))
	button.add_theme_color_override("font_hover_color", Color.WHITE)
	button.add_theme_color_override("font_disabled_color", Color("9aa89a"))
	button.add_theme_stylebox_override("normal", _box(Color("2f6b32")))
	button.add_theme_stylebox_override("hover", _box(Color("3d8540")))
	button.add_theme_stylebox_override("pressed", _box(Color("245528")))
	button.add_theme_stylebox_override("disabled", _box(Color("243328")))
	button.add_theme_stylebox_override("focus", _box(Color("3d8540")))


func _box(color: Color) -> StyleBoxFlat:
	var box := StyleBoxFlat.new()
	box.bg_color = color
	box.set_corner_radius_all(14)
	box.content_margin_left = 16
	box.content_margin_right = 16
	box.content_margin_top = 8
	box.content_margin_bottom = 8
	return box
