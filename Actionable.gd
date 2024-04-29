extends Area2D

@export var dialogue_resource : DialogueResource
@export var dialogue_start: String = "start"
@onready var player = $"../../player"

func action():
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)
	player.state = "MOVE"
	
