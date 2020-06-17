extends Control


# Return true if at least one answer is pressed
func is_one_answer_pressed() -> bool:
	for answer in get_children():
		if answer is AnswerButton && answer.is_pressed:
			return true
	
	return false

# Return the number of good answers the player found
func count_good_answers() -> int:
	var count : int = 0
	for answer in get_children():
		if answer is AnswerButton && answer.is_pressed && answer.is_valid:
			count += 1
	
	return count
