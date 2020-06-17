extends Label

func _ready():
	var tween = get_node("Tween")
	tween.interpolate_property(self, "rect_position",
			rect_position, Vector2(rect_position.x, rect_position.y - 30), 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

