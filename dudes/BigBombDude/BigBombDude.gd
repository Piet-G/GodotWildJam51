extends "res://dudes/BombDude/BombDude.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func damage(amount):
	health -= amount
	if(health <= 0):
		var explosion = preload("res://dudes/BigBombDude/ExplosionBig.tscn").instance()
		call_deferred("add_child", explosion)
		$AnimatedSprite.visible = false
		active = false

func reached_castle():
	CastleService.damage(castle_damage, not is_enemy)
	var explosion = preload("res://dudes/BigBombDude/ExplosionBig.tscn").instance()
	get_parent().add_child(explosion)
	queue_free()
	return
