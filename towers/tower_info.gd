class_name TowerInfo
extends Resource

export var name = "Tower"
export var food_cost = 1
export var gold_cost = 1
export(String, FILE, "*.png") var icon = "res://icon.png"
export(String, FILE, "*.tscn") var scene
export(Array, Resource) var next_upgrades = []
export(String) var flavour_text = "This is flavour text, edit me"
export var icon_offset = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
