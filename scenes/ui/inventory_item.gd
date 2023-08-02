extends MarginContainer

@onready var item_texture: TextureRect = $AspectRatioContainer/ItemTexture
@onready var item: Item

func set_item(new_item: Item):
	item = new_item
	if item != null && item_texture != null:
		item_texture.set_texture(item.get_texture())
