@tool
extends Resource

class_name ITEM

@export var ITEM_NAME: String
@export var ITEM_TEXTURE: Texture
@export var QUANTITY: int
@export_multiline var HOVER_TEXT: String

func add_quantity(quant: int):
	QUANTITY += quant

func get_texture() -> Texture:
	return ITEM_TEXTURE

func get_quantity() -> int:
	return QUANTITY
