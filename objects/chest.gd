extends StaticBody2D

@export var contents: PackedScene = null

@onready var animation_player = $AnimationPlayer
@onready var is_open: bool = false

func interact():
	if !is_open:
		print("open sesame")
		is_open = true
		animation_player.play("open")
		drop_contents()

func drop_contents():
	var item: Node2D = contents.instantiate()

	owner.add_child(item)

	#TODO; still havvent figured out how to have item show in front of chest lid when it pops out
	item.set_z_index(5)
	item.set_y_sort_enabled(false)
	item.set("visibility_layer", 4)

	var tween: Tween = create_tween()
	var duration: float = 0.3
	var bounce_position: Vector2 = position + Vector2(0, -7.5)
	var final_position: Vector2 = position + Vector2(0, 5)

	# tweens automatically run in series
	tween.tween_property(item, "position", bounce_position, duration).from(position).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(item, "position", final_position, duration).from(bounce_position).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)

	item.set_z_index(0)
