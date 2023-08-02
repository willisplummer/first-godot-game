extends Node

#@export var inventory_bar: Inventory
#@export var inventory_item_scene: PackedScene
class_name InventoryManager

@onready var items: Array[ITEM] = []

signal inventory_updated(items: Array[ITEM])

func _ready():
	GameEvents.item_collected.connect(on_item_collected)

# TBD: if the inventory is full, how do i let the colleted item know
# that it should not destroy itself?
func add_item(item: ITEM):
	items.push_back(item)
	inventory_updated.emit(items)

func on_item_collected(item: ITEM):
	add_item(item)
