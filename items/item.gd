@tool
extends TextureRect

@export var my_item: ITEM :
	set (value):
		if value != null:
			my_item = value
			self.texture = value.get_texture()
			$RichTextLabel.bbcode_text = str(value.get_quantity())
		else:
			self.texture = null
			$RichTextLabel.bbcode_text = ""

func add_quantity(addedQuant: int):
	my_item.add_quantity(addedQuant)
