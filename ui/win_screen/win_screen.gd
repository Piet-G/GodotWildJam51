extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_MainMenu_pressed():
	visible = false
	get_tree().change_scene("res://ui/MainMenu.tscn")
	$WinSong.stop()
	get_tree().paused = false

