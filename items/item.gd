@tool
extends StaticBody2D

@onready var sprite = $Sprite2D

@export var item: Item :
	set (value):
		item = value
		if sprite != null:
			# man i hate this ternary syntax
			var new_texture = null if value == null else value.get_texture()
			sprite.set_texture(new_texture)

func add_quantity(addedQuant: int):
	item.add_quantity(addedQuant)

func interact():
	GameEvents.emit_item_collected(item)
	# TODO: dont delete if the item can't be picked up
	queue_free()
