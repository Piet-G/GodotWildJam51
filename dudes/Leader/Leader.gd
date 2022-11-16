extends "res://dudes/dude.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Range_area_entered(area):
	if(area.is_in_group("dude_area") and area.get_parent().is_enemy == is_enemy):
		area.get_parent().inspire()


func _on_Range_area_exited(area):
	if(area.is_in_group("dude_area") and area.get_parent().is_enemy == is_enemy):
		area.get_parent().stop_inspire()
