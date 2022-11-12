extends "res://towers/tower.gd"

func _on_ShootTimer_timeout():
	for area in $Range.get_overlapping_areas():
		if(area.is_in_group("dude_area")):
			shoot_at(area)
			return
			
func shoot_at(dude: Node2D):
	var arrow = preload("res://towers/archery_tower/arrow.tscn").instance()
	
	add_child(arrow)
	arrow.set_target(dude)
