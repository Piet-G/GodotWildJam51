extends "res://towers/archery_tower/BallistaTower/BallistaTower.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func shoot_at(dude: Node2D):
	aim(dude)
	
	var arrow = preload("res://towers/archery_tower/CatapultTower/Rock.tscn").instance()
	arrow.is_enemy = is_enemy
	arrow.origin = self
	arrow.is_enemy = is_enemy
	$Fire.play()
	$ArrowPosition.add_child(arrow)
	arrow.set_target(dude)
	if(dude.health <= arrow_damage):
		dude.targeted = true
	
	$AnimatedSprite.play()

func damage(amount):
	health -= amount
	$Sprite.modulate = Color(1- (max_health - health)*0.05, 1 - (max_health - health)*0.1, 1- (max_health - health)*0.1, 1)
	$AnimatedSprite.modulate = Color(1- (max_health - health)*0.05, 1 - (max_health - health)*0.1, 1- (max_health - health)*0.1, 1)
	if(health <= 0):
		destroy()
		GridService.remove_from_grid(GridService.to_grid_position(global_position + Vector2(1,1)))
		queue_free()
