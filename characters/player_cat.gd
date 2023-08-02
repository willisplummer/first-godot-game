extends CharacterBody2D

@export var move_speed: float = 100
@export var starting_direction = Vector2(0, 0.5)

@onready var animation_tree = $AnimationTree
@onready var player_orientation = $PlayerOrientation
@onready var interaction_area = $PlayerOrientation/InteractionArea
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	# maybe combine these two fn calls into handle direction_change
	update_detection_direction(input_direction)
	update_animation_parameters(input_direction)

	#velocity already exists - defined by characterbody2d
	velocity = input_direction * move_speed
	
	move_and_slide()
	pick_new_state()

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		handle_interact()

func handle_interact():
	#TODO: probably do nothing in some cases
	var overlaps = interaction_area.get_overlapping_bodies()
	#todo: get the closest body
	print(overlaps)
	if overlaps.size() > 0 && overlaps[0].has_method("interact"):
		overlaps[0].interact()

func update_animation_parameters(move_input: Vector2):
	# dont change if there's no input
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", move_input)
		animation_tree.set("parameters/walk/blend_position", move_input)

# maintains the interaction area being in front of where the player faces
# probably the ideal is that at the end it snaps to the same dir as animation
# when movement stops (rn if you release both keys at once, the detection circle 
# (animation will prioritize sideways orientation in a tie)
func update_detection_direction(move_input: Vector2):
	var initial_dir = Vector2(0, 1)
	# dont change if there's no input
	if move_input != Vector2.ZERO:
		# todo -- not sure why this has to be doubled
		# and not sure why it doesnt work when going on a downward diagonal
		# (always shows as down when the coordinate is in the bottom half)
		var rotation_angle = (initial_dir - move_input).angle() * 2
		print(move_input)
		print(rotation_angle)
		player_orientation.set("rotation", rotation_angle)

	
func pick_new_state():
	if velocity != Vector2.ZERO:
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
