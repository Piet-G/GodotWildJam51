extends "res://dudes/Rhino/Rhino.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	pass

func shoot_at(tower: Node2D):
	var arrow = preload("res://dudes/Mammoth/Mammoth_projectile.tscn").instance()
	arrow.is_enemy = is_enemy
	get_parent().add_child(arrow)
	arrow.global_position = $AnimatedSprite/Position2D.global_position
	arrow.set_target(tower)
	$Timer.start()



func _on_Timer_timeout():
	for area in $Range.get_overlapping_areas():
		if(area.is_in_group("Tower") and area.get_parent().is_enemy != is_enemy and area.get_parent().is_active()):
			shoot_at(area.get_parent())
			return


func _on_Range_area_entered(area):
	if(not active):
		return
	if($Timer.is_stopped()):
		for area in $Range.get_overlapping_areas():
			if(area.is_in_group("Tower") and area.get_parent().is_enemy != is_enemy and area.get_parent().is_active()):
				shoot_at(area.get_parent())
				return
