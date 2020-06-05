extends Node2D

onready var dialogue_box_scene = preload("res://Scenes/Bubble/Bubble.tscn")
onready var answer_scene = preload("res://Scenes/Button/Answer/Answer.tscn")

var dialogue_index : int = 0

func _ready():
	var _err = $Timer.connect("timeout", self, "on_timer_timeout")
	generate_question()


func on_timer_timeout():
	generate_question()


func generate_question():
	dialogue_index += 1
	instanciate_dialogue_box(dialogue_index)
	instanciate_responses(dialogue_index)
	$Timer.start()


func instanciate_dialogue_box(index : int):
	var box_node = dialogue_box_scene.instance()
	box_node.dialogue_key = DIALOGUE.get_dialogue_key(index)
	
	var questions_node = get_tree().get_current_scene().find_node("Questions")
	var container_size : Vector2 = questions_node.get_size()
	var box_size : Vector2 = box_node.get_size()
	
	box_node.set_position(container_size / 2 - box_size / 2)
	
	questions_node.call_deferred("add_child", box_node)


func instanciate_responses(dial_index : int):
	var answer_container_node = get_tree().get_current_scene().find_node("Answers")
	var container_size : Vector2 = answer_container_node.get_size()
	
	var index : int = 0
	
	for i in range(2):
		for j in range(2):
			var answer_button = answer_scene.instance()
			
			var answer_key = DIALOGUE.get_answer_key(dial_index, index)
			answer_button.set_key(answer_key)
			
			var button_size = answer_button.get_size()
			var button_pos = container_size * (Vector2((j + 1), (i + 1)) / 3) - button_size / 2
			
			answer_button.set_position(button_pos)
			answer_container_node.call_deferred("add_child", answer_button)
			
			index += 1 
