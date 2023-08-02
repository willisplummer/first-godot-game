extends Node

signal item_collected(item: Item)

func emit_item_collected(item: Item):
	item_collected.emit(item)
