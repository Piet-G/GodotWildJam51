extends "res://dudes/dude.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Range_area_entered(area):
	if(active and area.is_in_group("dude_area") and area.get_parent().is_enemy == is_enemy):
		area.get_parent().inspire()


func _on_Range_area_exited(area):
	if(active and area.is_in_group("dude_area") and area.get_parent().is_enemy == is_enemy):
		area.get_parent().uninspire()
