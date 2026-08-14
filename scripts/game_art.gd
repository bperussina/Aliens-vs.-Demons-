class_name GameArt
extends Object

static func attach(host: Node2D, texture: Texture2D, world_height: float, offset := Vector2.ZERO) -> Sprite2D:
	var sprite := Sprite2D.new()
	sprite.name = "Art"
	sprite.texture = texture
	sprite.centered = true
	sprite.position = offset
	if texture:
		sprite.scale = Vector2.ONE * (world_height / float(maxi(texture.get_height(), 1)))
	host.add_child(sprite)
	return sprite


static func muzzle_offset(world_height: float, offset := Vector2.ZERO) -> Vector2:
	return offset + Vector2(0.0, -world_height * 0.48)
