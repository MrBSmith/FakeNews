extends NinePatchRect

var margin = Vector2(8, 8)

onready var animation_player_node = $AnimationPlayer
onready var tween_node = $Tween

var dialogue_key : String = ""

func _ready():
	appear()
	$RichTextLabel.start_typing()
	yield($RichTextLabel, "finished_typing")
	disappear()


func appear():
	# Fade in the bubble
	animation_player_node.play_backwards("Fade")
	
	# Resize the box dynamicly based on the button size
	tween_node.interpolate_property(self, "rect_size",
		Vector2(24, 24), rect_size,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween_node.start()
	
	yield(tween_node, "tween_all_completed")



func disappear():
	animation_player_node.play("Fade", -1, 3)
	
	yield(animation_player_node, "animation_finished")
	queue_free()
