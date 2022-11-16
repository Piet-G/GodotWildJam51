extends "res://dudes/dude.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func activate():
	$HealTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HealTimer_timeout():
	$AnimatedSprite/HealingEffect.visible = true
	$AnimatedSprite/HealingEffect.play()
	for area in $HealRange.get_overlapping_areas():
		if(area.is_in_group("dude_area") and area.get_parent().is_enemy == is_enemy):
			area.get_parent().heal()


func _on_HealingEffect_animation_finished():
	$AnimatedSprite/HealingEffect.visible = false
	$AnimatedSprite/HealingEffect.playing = false
