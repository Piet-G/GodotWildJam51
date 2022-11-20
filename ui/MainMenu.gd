extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Ui.visible = false


func _on_Start_Game_pressed():
	$AudioStreamPlayer2.play()
	$Tutorial.visible = true


func _on_Timer_timeout():
	$AnimatedSprite.play()


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.playing = false
