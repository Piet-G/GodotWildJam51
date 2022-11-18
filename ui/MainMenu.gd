extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Ui.visible = false


func _on_Start_Game_pressed():
	Ui.visible = true
	get_tree().change_scene("res://map.tscn")
