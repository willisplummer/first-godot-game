extends Node

@onready var dialogue_box_scene = preload("res://ui/dialogue_box.tscn")

var dialogue_lines: Array[String] = []
var current_line_index = 0

var dialogue_box
var dialogue_box_position: Vector2

var is_dialogue_active = false
var can_advance_line = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func start_dialogue(position: Vector2, lines: Array[String]):
	if is_dialogue_active:
		return

	#TODO: is this a bad idea
	get_tree().paused = true

	dialogue_lines = lines
	dialogue_box_position = position
	print(dialogue_box_position)
	_show_dialogue_box()

	is_dialogue_active = true
	
func _show_dialogue_box():
	dialogue_box = dialogue_box_scene.instantiate()
	dialogue_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(dialogue_box)
	dialogue_box.global_position = dialogue_box_position
	dialogue_box.display_text(dialogue_lines[current_line_index])
	can_advance_line = false

func _on_text_box_finished_displaying():
	can_advance_line = true

func _unhandled_input(event):
	if (
		event.is_action_pressed("interact")
	&& is_dialogue_active
	&& can_advance_line
	):
		dialogue_box.queue_free()

		current_line_index += 1
		if current_line_index >= dialogue_lines.size():
			is_dialogue_active = false
			get_tree().paused = false
			current_line_index = 0
			return
		else:
			_show_dialogue_box()
