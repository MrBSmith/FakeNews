extends Label

onready var default_text : String = get_text()
var points : int = 0 setget set_points, get_points

func _ready():
	set_points(0)

func set_points(value: int):
	if value < 0 :
		return
	points = value
	set_text(default_text + String(points))

func get_points() -> int :
	return points

func add_to_points(value: int):
	set_points(get_points() + value)
