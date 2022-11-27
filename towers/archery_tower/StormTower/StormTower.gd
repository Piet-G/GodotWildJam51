extends "res://towers/archery_tower/Thunderdome/Thunderdome.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func shoot_at(dude: Node2D):
	var arrow = preload("res://towers/archery_tower/Thunderdome/Lightning.tscn").instance()
	arrow.is_enemy = is_enemy
	arrow.origin = self
	arrow.bounces = 5
	$ArrowPosition.add_child(arrow)
	arrow.set_target(dude)
	$Fire.play()
	if(dude.health <= arrow_damage):
		dude.targeted = true
