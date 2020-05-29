extends Node2D

var dialogue_index : int = 1

func _ready():
	var _err = $Timer.connect("timeout", self, "on_timer_timeout")
	DIALOGUE.instanciate_dialogue_box(dialogue_index)
	$Timer.start()


func on_timer_timeout():
	dialogue_index += 1
	DIALOGUE.instanciate_dialogue_box(dialogue_index)
