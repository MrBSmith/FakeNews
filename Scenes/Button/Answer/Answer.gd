extends ButtonBase
class_name AnswerButton

var key : String = "" setget set_key, get_key
var is_valid : bool = false
var is_pressed : bool = false

func set_key(value: String):
	key = value
	var text = DIALOGUE.get_current_translation().get_message(key)
	
	# Search for a valid tag in the string
	var tag_pos = text.findn("[v]")
	if tag_pos != -1:
		is_valid = true
		text.erase(tag_pos, 3)
	
	set_text(text)


func get_key() -> String:
	return key

func on_pressed():
	is_pressed = !is_pressed
