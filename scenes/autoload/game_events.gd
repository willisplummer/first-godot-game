extends Node

signal item_collected(item: ITEM)

func emit_item_collected(item: ITEM):
	item_collected.emit(item)
