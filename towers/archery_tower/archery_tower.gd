extends "res://towers/tower.gd"

func _on_ShootTimer_timeout():
	if(not is_active()):
		return
		
	for area in $Range.get_overlapping_areas():
		if(area.is_in_group("dude_area") and not area.get_parent().targeted and area.get_parent().is_enemy != is_enemy and area.get_parent().is_active()):
			shoot_at(area.get_parent())
			return

func shoot_at(dude: Node2D):
	var arrow = preload("res://towers/archery_tower/arrow.tscn").instance()

	$ArrowPosition.add_child(arrow)
	arrow.set_target(dude)
