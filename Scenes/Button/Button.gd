extends NinePatchRect
class_name ButtonBase

export var max_chars_lenght : int = 50
export var toggle_mode = false

func _ready():
	var _err = $Label.connect("pressed", self, "on_pressed")

func set_text(text: String):
	text = split_in_lines(text, max_chars_lenght)
	var nb_line = text.count("\n", 0, 0) + 1
	var text_box_size := Vector2.ZERO
	
	if text.length() != 1:
		text_box_size = Vector2(5 * clamp(text.length(), 1, max_chars_lenght), 12 * nb_line)
		_set_size(text_box_size)
		rect_size.y = 12 * (nb_line + 1)
		$Label.set_size(text_box_size)
	
	$Label.set_text(text)
	$Label.rect_position = get_size() / 2 - text_box_size / 2


func split_in_lines(text : String, line_max_lenght: int) -> String:
	var lines_array : Array = []
	
	while text.length() > 0:
		var last_point = find_split_point(text, line_max_lenght)
		
		if last_point == -1 or last_point == 0:
			last_point = text.length()
		
		lines_array.append(text.substr(0, last_point))
		text.erase(0, last_point)
	
	var new_text = ""
	
	for line in lines_array:
		new_text += line + "\n"
	
	return new_text


# Find the next end of a sentence in the given string and returns its position
func find_split_point(text: String, line_max_lenght: int = 30) -> int:
	if text.length() < line_max_lenght:
		return -1
	
	var current_point : int = 0
	var last_point : int = 0
	
	while(current_point < line_max_lenght && current_point != -1):
		last_point = current_point
		current_point = text.find(" ", current_point + 1)
	
	return last_point


func on_pressed():
	pass
