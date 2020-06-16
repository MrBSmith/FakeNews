extends Control

onready var answer_node = $Answers

signal submit


func _ready():
	var _err = connect("submit", owner, "on_submit")


func on_submit():
	var found_valid_answer : int = 0
	var total_valid_answer : int = 0
	
	
	# Count the number of answers to find, and the number of found answers
	for answer in answer_node.get_children():
		if not answer is AnswerButton:
			continue
		
		if answer.is_valid:
			total_valid_answer += 1
			
			if answer.is_pressed:
				found_valid_answer += 1
	
	var right_answer : bool = found_valid_answer == total_valid_answer
	
	emit_signal("submit", right_answer)
