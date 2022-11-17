extends "res://dudes/dude.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func cast():
	if($CastTimer.is_stopped()):
		$AnimatedSprite2.visible = true
		$AnimatedSprite2.play()
		$CastTimer.start()
		return true
	else:
		return false


func _on_AnimatedSprite2_animation_finished():
	$AnimatedSprite2.visible = false
	$AnimatedSprite2.playing = false
