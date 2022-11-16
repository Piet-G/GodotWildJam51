extends "res://dudes/dude.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func shoot_at(tower: Node2D):
	$Cast_sprite.visible = true
	$Cast_sprite.play()
	var arrow = preload("res://dudes/Wizard/Wizard_projectile.tscn").instance()
	arrow.is_enemy = is_enemy
	get_parent().add_child(arrow)
	arrow.global_position = $AnimatedSprite/Position2D.global_position
	arrow.set_target(tower)
	$CastCooldown.start()


func _on_CastRange_area_entered(area):
	if(not is_active()):
		return
	if($CastCooldown.is_stopped()):
		for area in $CastRange.get_overlapping_areas():
			if(area.is_in_group("Tower") and area.get_parent().is_enemy != is_enemy and area.get_parent().is_active()):
				shoot_at(area.get_parent())
				return


func _on_Cast_sprite_animation_finished():
	$Cast_sprite.visible = false
	$Cast_sprite.playing = false


func _on_CastCooldown_timeout():
	for area in $CastRange.get_overlapping_areas():
		if(area.is_in_group("Tower") and area.get_parent().is_enemy != is_enemy and area.get_parent().is_active()):
			shoot_at(area.get_parent())
			return
