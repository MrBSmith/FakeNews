extends Sprite

var Montagnier = preload("res://Scenes/Portraits/Montagnier.png")
var Casasnovas = preload("res://Scenes/Portraits/Casasnovas.png")
var Raoult = preload("res://Scenes/Portraits/Raoult.png")


func set_portrait(portrait_name : String):
	if portrait_name in self:
		set_texture(get(portrait_name))

func appear():
	$AnimationPlayer.play("Appear")

func disappear():
	$AnimationPlayer.play_backwards("Appear")
