extends NinePatchRect
class_name ButtonBase

func _ready():
	var _err = $Button.connect("pressed", self, "on_pressed")

func set_text(text: String):
	if text.length() != 1:
		_set_size(Vector2(16 + 8 * text.length(), 16))
		$Button.set_size(Vector2(8 * text.length(), 16))
	$Button.set_text(text)


func on_pressed():
	pass
