extends Label

signal pressed

const PRESSED = Color.green
const OVER = Color.red
const DISSABLED = Color.gray
const NORMAL = Color.black

var mouse_inside : bool = false
var is_pressed : bool = false

func _ready():
	set_modulate(NORMAL)
	var _err = connect("mouse_entered", self, "on_mouse_entered")
	_err = connect("mouse_exited", self, "on_mouse_exited")


func on_mouse_entered():
	if !is_pressed:
		set_modulate(OVER)
	
	mouse_inside = true


func on_mouse_exited():
	if !is_pressed:
		set_modulate(NORMAL)
	
	mouse_inside = false


func _input(event):
	if mouse_inside && event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if owner.toggle_mode:
				is_pressed = !is_pressed
				
			emit_signal("pressed")
			
			if is_pressed && owner.toggle_mode:
				set_modulate(PRESSED)
			else:
				set_modulate(OVER)
