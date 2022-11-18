extends "res://dudes/dude.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func activate():
	.activate()
	$Timer.start()
	sneak()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	sneak()
	
	for area in $ShadowArea.get_overlapping_areas():
		if(sneaking and area.is_in_group("dude_area") and !area.get_parent().sneaking and area.get_parent().is_enemy == is_enemy):
			area.get_parent().sneak()
	


func _on_ShadowArea_area_entered(area):
	if(sneaking and area.is_in_group("dude_area") and !area.get_parent().sneaking and area.get_parent().is_enemy == is_enemy):
		area.get_parent().sneak()


func _on_ShadowArea_area_exited(area):
	if(sneaking and area.is_in_group("dude_area") and area.get_parent().sneaking and area.get_parent().is_enemy == is_enemy):
		area.get_parent().stop_sneaking()


func _on_SneakTimer_timeout():
	for area in $ShadowArea.get_overlapping_areas():
		if(area.is_in_group("dude_area") and area.get_parent().sneaking and area.get_parent().is_enemy == is_enemy):
			area.get_parent().stop_sneaking()
