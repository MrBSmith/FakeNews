extends ButtonBase

onready var UI_node = get_parent().get_parent()

signal submit


func _ready():
	var _err = connect("submit", UI_node, "on_submit")


func on_pressed():
	if get_parent().is_one_answer_pressed():
		emit_signal("submit")
