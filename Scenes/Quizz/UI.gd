extends Control

onready var answer_node = $Answers

signal submit


func _ready():
	var _err = connect("submit", owner, "on_submit")


func on_submit():
	emit_signal("submit")
