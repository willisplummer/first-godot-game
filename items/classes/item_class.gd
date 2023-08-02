@tool
extends Resource

class_name Item

@export var item_name: String
@export var item_texture: Texture
@export var quantity: int
@export_multiline var hover_text: String

func add_quantity(quant: int):
	quantity += quant

func get_texture() -> Texture:
	return item_texture

func get_quantity() -> int:
	return quantity
