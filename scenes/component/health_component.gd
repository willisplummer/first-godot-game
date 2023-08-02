extends Node

class_name  HealthComponent

signal died

@export var max_health: float = 10
@onready var current_health: float = max_health

func damage(amount: float):
	current_health = max(0, current_health - amount)
	Callable(check_death).call_deferred()

func check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()

	
