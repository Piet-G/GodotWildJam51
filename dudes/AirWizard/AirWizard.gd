extends "res://dudes/dude.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _on_CastRange_area_entered(area):
	if(not active):
		return
	if($CastCooldown.is_stopped()):
		var casted = false
		for area in $CastRange.get_overlapping_areas():
			if(area.is_in_group("dude_area") and area.get_parent().is_enemy == is_enemy and area.get_parent().active):
				area.get_parent().haste()
				casted = true
		if casted:
			$Cast_sprite.visible = true
			$Cast_sprite.play()
			$CastCooldown.start()


func _on_Cast_sprite_animation_finished():
	$Cast_sprite.visible = false
	$Cast_sprite.playing = false


func _on_CastCooldown_timeout():
	var casted = false
	for area in $CastRange.get_overlapping_areas():
		if(area.is_in_group("dude_area") and area.get_parent().is_enemy == is_enemy and area.get_parent().active):
			area.get_parent().haste()
			casted = true
	if casted:
		$Cast_sprite.visible = true
		$Cast_sprite.play()
		$CastCooldown.start()
