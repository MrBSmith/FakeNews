extends RichTextLabel

onready var typein_timer_node = $TypeInTimer
onready var reading_timer_node = $ReadingTimer

export var text_speed : float = 4

var text_head_index : int = -1
var entire_text : String = ""
var paragraphs_array : Array = []
var paragraph : String = ""

signal finished_typing

func _ready():
	var _err = typein_timer_node.connect("timeout", self, "on_timer_timeout")
	_err = reading_timer_node.connect("timeout", self, "on_reading_timer_timeout")
	load_text()


# Starts the progressive typing process
func start_typing():
	text = ""
	text_head_index = -1
	paragraph = paragraphs_array.pop_front()
	typein_timer_node.set_wait_time(0.1 * (1 / text_speed))
	typein_timer_node.start()


# Stops the progressive typing process
func stop_typing():
	if owner.infinite_read_time == false:
		reading_timer_node.start()
	typein_timer_node.stop()
	set_process(false)


# Load the dialogue at its current index, store it in entire_text
func load_text():
	var key = owner.dialogue_key
	entire_text = DIALOGUE.get_current_translation().get_message(key)
	split_in_paragraphs(entire_text)


# Split the given text in printable paragraphs
func split_in_paragraphs(text : String):
	while text.length() > 0:
		var last_point = 0
		var current_point = 0
		
		while current_point < 220 && current_point != -1:
			last_point = current_point
			current_point = find_next_sentence_end(text, last_point + 2)
		
		if last_point == -1 or last_point == 0:
			last_point = text.length()
		
		paragraphs_array.append(text.substr(0, last_point + 2))
		text.erase(0, last_point + 2)
	
	# Debug purpose
#	print_paragraphs_array()


# Find the next end of a sentence in the given string and returns its position
func find_next_sentence_end(text: String, position: int = 0) -> int:
	var sentence_end_array = [". ", "! ", "? "]
	
	var nearest_point : int = -1
	var next_point : int = -1
	
	for point in sentence_end_array:
		next_point = text.findn(point, position)
		if nearest_point == -1 or (next_point != -1 and next_point < nearest_point):
			nearest_point = next_point
	
	return nearest_point


# Debug purpose
# Print the paragaphs in the console
func print_paragraphs_array():
	var i : int = 1
	for par in paragraphs_array:
		print(String(i) + ") " + par)
		i += 1


# Progressively type in the text
func write_text(text_head : int):
	var current_text : String = paragraph[text_head]
	
	if current_text.ends_with(" ") and is_needing_new_line(text_head):
		current_text += "\n"
	
	add_text(current_text)
	
	
	var displayed_text = get_text().strip_escapes()
	
	if displayed_text == paragraph:
		stop_typing()


#### This should be useable in a next version of Godot ####
#### There is currently a bug with get_visible_line_count ####

# Try to add the next word of the paragraph and see if a new line would be needed
# Return true if a new line is needed, false if not
func is_needing_new_line(text_head: int) -> bool:
	
#	var current_text = label_node.text
#	var current_line_count = label_node.get_visible_line_count()
	var last_return = get_text().find_last("\n")
	var next_space = paragraph.findn(" ", text_head)
	
	#### TEMPORARY SOLUTION UNTIL GODOT GOT FIXED ####
	return next_space - last_return > 48
	
#	var new_text = paragraph.substr(0, next_space)
#	label_node.text = new_text
#
#	yield(get_tree(), "idle_frame")
#	var new_line_count = label_node.get_visible_line_count()
#	label_node.text = current_text
#
#	return new_line_count > current_line_count and current_line_count != 0


# Write the next character each time the timer is finished
func on_timer_timeout():
	text_head_index += 1
	if text_head_index > paragraph.length() - 1:
		text_head_index = paragraph.length() - 1
		typein_timer_node.stop()
	
	write_text(text_head_index)


# Starts typing the next paragraph, or close the box if it was the last one
func on_reading_timer_timeout():
	if len(paragraphs_array) == 0:
		text = ""
		emit_signal("finished_typing")
	else:
		start_typing()
