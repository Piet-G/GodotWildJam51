extends "res://towers/archery_tower/arrow.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func destroy():
	var explosion = preload("res://towers/archery_tower/CatapultTower/RockHit.tscn").instance()
	add_child(explosion)
	active = false
