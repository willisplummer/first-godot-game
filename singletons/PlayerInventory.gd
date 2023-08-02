extends Node

var items: Array[PackedScene] = [] 

func add_item(item: PackedScene):
	items.push_back(item)

func use_item(idx: int):
	if idx <= items.size():
		var item = items[idx]
		# TBD: are all items going to implement use()
		# Should we check if use is implemented first
		item.use()
		item.pop_at(idx)
	else:
		print("invalid idx")

#TODO
func show_inv():
	print(items)

# TODO: my intuition is that we'll need a data structure
# where we can keep track of if items are equipped or not
# and a way to know if items are equippable/usable etc
#func equip_item(idx: int):
