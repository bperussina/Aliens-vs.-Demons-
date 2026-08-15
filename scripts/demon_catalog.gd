class_name DemonCatalog
extends Object

enum Kind { NORMAL, DRIFTED, DEEP }

const TEX_NORMAL := preload("res://assets/sprites/demon.png")
const TEX_DRIFTED := preload("res://assets/sprites/drifted_demon.png")
const TEX_DEEP := preload("res://assets/sprites/deep_drift_demon.png")


static func roster(turn: int, level: int) -> Array[int]:
	var n := mini(turn, 10) + mini(maxi(level, 1) - 1, 4)
	var kinds: Array[int] = []
	kinds.resize(n)
	kinds.fill(Kind.NORMAL)
	if n <= 0:
		return kinds
	if turn == 1 and level <= 1:
		return kinds
	var drifted := 0
	var deep := 0
	if turn >= 3 or level >= 2:
		drifted = mini(n - 1, 1 + int(turn / 3.0) + int(level / 2.0))
	if turn >= 6 or level >= 4:
		deep = mini(n - 1, int(turn / 5.0) + maxi(level - 3, 0))
	var slot := n - 1
	while deep > 0 and slot >= 0:
		kinds[slot] = Kind.DEEP
		deep -= 1
		slot -= 1
	while drifted > 0 and slot >= 0:
		if kinds[slot] == Kind.NORMAL:
			kinds[slot] = Kind.DRIFTED
			drifted -= 1
		slot -= 1
	if turn == 1:
		kinds[0] = Kind.NORMAL
	return kinds


static func texture(kind: int) -> Texture2D:
	match kind:
		Kind.DRIFTED:
			return TEX_DRIFTED
		Kind.DEEP:
			return TEX_DEEP
		_:
			return TEX_NORMAL


static func display_name(kind: int) -> String:
	match kind:
		Kind.DRIFTED:
			return "Drifted"
		Kind.DEEP:
			return "Deep Drift"
		_:
			return "Demon"


static func hits(kind: int, level: int) -> int:
	var base := 8
	match kind:
		Kind.DRIFTED:
			base = 16
		Kind.DEEP:
			base = 24
	return base + int((maxi(level, 1) - 1) / 2.0)


static func speed(kind: int, level: int) -> float:
	var base := 70.0
	match kind:
		Kind.DRIFTED:
			base = 92.0
		Kind.DEEP:
			base = 78.0
	return base * (1.0 + float(maxi(level, 1) - 1) * 0.03)


static func coins(kind: int) -> int:
	match kind:
		Kind.DRIFTED:
			return 20
		Kind.DEEP:
			return 35
		_:
			return SaveData.COINS_PER_DEMON


static func bite(kind: int) -> int:
	return 2 if kind == Kind.DEEP else 1


static func bite_every(kind: int) -> float:
	match kind:
		Kind.DRIFTED:
			return 0.42
		Kind.DEEP:
			return 0.5
		_:
			return 0.55


static func height(kind: int) -> float:
	match kind:
		Kind.DRIFTED:
			return 128.0
		Kind.DEEP:
			return 150.0
		_:
			return 112.0


static func bar_y(kind: int) -> float:
	match kind:
		Kind.DRIFTED:
			return -84.0
		Kind.DEEP:
			return -98.0
		_:
			return -72.0


static func collision_radius(kind: int) -> float:
	match kind:
		Kind.DRIFTED:
			return 32.0
		Kind.DEEP:
			return 38.0
		_:
			return 28.0


static func floaty(kind: int) -> bool:
	return kind == Kind.DRIFTED or kind == Kind.DEEP


static func wave_label(kinds: Array[int]) -> String:
	if kinds.has(Kind.DEEP):
		return "Deep Drift"
	if kinds.has(Kind.DRIFTED):
		return "Drifted"
	return ""
