extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_Game_pressed():
	$AudioStreamPlayer.play()

func _on_AudioStreamPlayer_finished():
	Ui.visible = true
	get_tree().change_scene("res://map.tscn")
