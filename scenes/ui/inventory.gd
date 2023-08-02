extends CanvasLayer

class_name Inventory

@export var inventory_manager: InventoryManager
@export var inventory_item_scene: PackedScene
@onready var hbox_container = $HBoxContainer

func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()

func _ready():
	inventory_manager.inventory_updated.connect(on_inventory_updated)

func add_item(_item: ITEM):
	return

func on_inventory_updated(inv: Array[ITEM]):
	print("inventory component receiving inventory updated")
	if inventory_item_scene == null:
		return

	if not owner is Node2D:
		return

	# TODO: how inefficient is this?
	delete_children(hbox_container)
	for item in inv:
		var inventory_item_instance = inventory_item_scene.instantiate()
		hbox_container.add_child(inventory_item_instance)
		inventory_item_instance.set_item(item)
	pass
