extends Label

var mouse_inside : bool = false

signal pressed

const PRESSED = Color.green
const OVER = Color.red
const DISSABLED = Color.green
const NORMAL = Color.black

func _ready():
	set_modulate(NORMAL)
	var _err = connect("mouse_entered", self, "on_mouse_entered")
	_err = connect("mouse_exited", self, "on_mouse_exited")


func on_mouse_entered():
	set_modulate(OVER)
	mouse_inside = true


func on_mouse_exited():
	set_modulate(NORMAL)
	mouse_inside = false


func _input(event):
	if !event is InputEventMouseButton:
		 return
	
	if mouse_inside:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("pressed")
			set_modulate(NORMAL)
