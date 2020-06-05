extends ButtonBase

var key : String = "" setget set_key, get_key
var is_valid : bool = false

func set_key(value: String):
	key = value
	var text = DIALOGUE.get_current_translation().get_message(key)
	var tag_pos = text.findn("[v]")
	if tag_pos != -1:
		is_valid = true
		text.erase(tag_pos, 3)
	set_text(text)


func get_key() -> String:
	return key
