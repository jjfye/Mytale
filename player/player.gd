extends CharacterBody2D

@export var ACCELERATION = 500
@export var FRICTION = 200
@export var MAX_SPEED = 200

@onready var actionable_finder: Area2D = $Direction/ActionableFinder
@onready var animationTree = $AnimationTree

enum {
	MOVE,
	PAUSE
}

var state = MOVE

func _ready():
	DialogueManager.connect("dialogue_ended", dialogue_exited)
	
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		PAUSE:
			pass

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
		
	move_and_slide()

func _unhandled_input(_event: InputEvent):
	if Input.is_action_just_pressed("ui_accept"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return
		
func dialogue_exited():
	state = MOVE
