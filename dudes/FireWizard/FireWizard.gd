extends "res://dudes/Wizard/Wizard.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func shoot_at(tower: Node2D):
	$Cast_sprite.visible = true
	$Cast_sprite.play()
	var arrow = preload("res://dudes/FireWizard/FireWizard_projectile.tscn").instance()
	arrow.is_enemy = is_enemy
	get_parent().add_child(arrow)
	arrow.global_position = $AnimatedSprite/Position2D.global_position
	arrow.set_target(tower)
	$CastCooldown.start()
