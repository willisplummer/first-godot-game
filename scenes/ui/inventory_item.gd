extends MarginContainer

@onready var item_scene = $AspectRatioContainer/Item

func set_item(item: ITEM):
	if item_scene == null:
		print("item_scene is null")
		return
	item_scene.my_item = item
