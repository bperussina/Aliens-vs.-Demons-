extends Node

const PATH := "user://progress.save"
const COINS_PER_DEMON := 10
const UNLOCK_LEVEL := 50
const UNLOCK_COINS := 1000
const STARTING_TURRETS := 2
const TURRET_PRICE := 10
const UNLIMITED_PRICE := 2
const MAX_PLACED := 5
const MAX_STOCK := 5

var coins: int = 0
var level: int = 1
var turrets: int = STARTING_TURRETS
var unlimited_turrets := false


func _ready() -> void:
	_load()


func add_coins(amount: int) -> void:
	coins += amount
	_save()


func level_up() -> void:
	level += 1
	_save()


func try_buy_turret() -> bool:
	if not can_buy_turret():
		return false
	coins -= TURRET_PRICE
	turrets += 1
	_save()
	return true


func can_buy_turret() -> bool:
	if coins < TURRET_PRICE:
		return false
	if unlimited_turrets:
		return true
	return turrets < MAX_STOCK


func try_buy_unlimited() -> bool:
	if unlimited_turrets:
		return false
	if coins < UNLIMITED_PRICE:
		return false
	coins -= UNLIMITED_PRICE
	unlimited_turrets = true
	_save()
	return true


func consume_turret() -> bool:
	if turrets <= 0:
		return false
	turrets -= 1
	_save()
	return true


func multiplayer_unlocked() -> bool:
	return level >= UNLOCK_LEVEL and coins >= UNLOCK_COINS


func _save() -> void:
	var file := FileAccess.open(PATH, FileAccess.WRITE)
	if file == null:
		return
	file.store_string(JSON.stringify({
		"coins": coins,
		"level": level,
		"turrets": turrets,
		"unlimited_turrets": unlimited_turrets,
	}))


func _load() -> void:
	if not FileAccess.file_exists(PATH):
		return
	var file := FileAccess.open(PATH, FileAccess.READ)
	if file == null:
		return
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		return
	var data: Dictionary = parsed
	coins = int(data.get("coins", 0))
	level = maxi(1, int(data.get("level", 1)))
	turrets = int(data.get("turrets", STARTING_TURRETS))
	unlimited_turrets = bool(data.get("unlimited_turrets", false))
