extends CanvasLayer

@onready var progress_bar: ProgressBar = $%ProgressBar

func update_health(new_health: float, max_health: float):
	var percent: float = new_health / max_health
	progress_bar.value = percent
