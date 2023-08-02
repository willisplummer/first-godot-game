extends CharacterBody2D

enum COW_STATE { IDLE, WALK }

@export var move_speed: float = 20
@export var idle_time: float = 1
@export var walk_time: float = 0.6

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var health = $HealthComponent

var move_direction: Vector2 = Vector2.ZERO
var current_state : COW_STATE = COW_STATE.IDLE

func _ready():
	pick_new_state()

func _physics_process(_delta):
	if current_state == COW_STATE.WALK:		
		#velocity already exists - defined by characterbody2d
		velocity = move_direction * move_speed
		
		move_and_slide()

func update_animation_parameters(move_input: Vector2):
	# dont change if there's no input
	if move_input != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", move_input)
		animation_tree.set("parameters/walk/blend_position", move_input)

func select_new_direction():
	move_direction = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1)
	)

	if move_direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func interact():
	DialogueManager.start_dialogue(get_global_position(), ["Mooooo"])
	health.damage(1)

func pick_new_state():
	if current_state == COW_STATE.IDLE:
		select_new_direction()
		state_machine.travel("walk_right")
		current_state = COW_STATE.WALK
		timer.start(walk_time)
	else:
		state_machine.travel("idle_right")
		current_state = COW_STATE.IDLE
		timer.start(idle_time)


func _on_timer_timeout():
	pick_new_state()
