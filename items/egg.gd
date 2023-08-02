extends StaticBody2D

@onready var item: ITEM = load("res://items/new_milk.tres")

func interact():
	GameEvents.emit_item_collected(item)
	# TODO: dont delete if the item can't be picked up
	queue_free()


