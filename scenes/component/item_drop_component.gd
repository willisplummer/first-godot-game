extends Node

@export_range(0,1) var drop_percent: float = 0.5
@export var item_scene: PackedScene
@export var health_component: HealthComponent

func _ready():
	(health_component as HealthComponent).died.connect(on_died)

func on_died():
	if randf() > drop_percent:
		return

	if item_scene == null:
		return

	if not owner is Node2D:
		return

	var spawn_position = owner.global_position
	var item_instance: Node2D = item_scene.instantiate()
	owner.get_parent().add_child(item_instance)
	item_instance.global_position = spawn_position
