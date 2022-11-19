extends "res://towers/archery_tower/archery_tower.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func shoot_at(dude: Node2D):
	var arrow = preload("res://towers/archery_tower/MageTower/MageTowerProjectile.tscn").instance()
	arrow.is_enemy = is_enemy
	arrow.origin = self
	$Fire.play()
	$ArrowPosition.add_child(arrow)
	arrow.set_target(dude)
	arrow.set_direction()
