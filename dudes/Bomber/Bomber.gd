extends "res://dudes/Flyer/Flyer.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BombArea_area_entered(area):
	if(not active):
		return
	if($BombCooldown.is_stopped()):
		for area in $BombArea.get_overlapping_areas():
			if(area.is_in_group("Tower") and area.get_parent().is_enemy != is_enemy and area.get_parent().is_active()):
				drop_bomb()
				return

func drop_bomb():
	var bomb = preload("res://dudes/Bomber/Bomb_projectile.tscn").instance()
	get_parent().add_child(bomb)
	bomb.global_position = $AnimatedSprite/Position2D.global_position
	$BombCooldown.start()

