extends "res://dudes/Leader/Leader.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Range_area_entered(area):
	if($ConvertTimer.is_stopped()):
		if(active and area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy and area.get_parent().is_active()):
			area.get_parent().bribe()
			$AnimatedSprite/ConvertEffect.visible = true
			$AnimatedSprite/ConvertEffect.play()
			$ConvertTimer.start()


func _on_ConvertTimer_timeout():
	for area in $Range.get_overlapping_areas():
		if(area.is_in_group("dude_area")and area.get_parent().is_enemy != is_enemy and area.get_parent().is_active()):
			area.get_parent().bribe()
			$AnimatedSprite/ConvertEffect.visible = true
			$AnimatedSprite/ConvertEffect.play()
			$ConvertTimer.start()


func _on_ConvertEffect_animation_finished():
	$AnimatedSprite/ConvertEffect.visible = false
	$AnimatedSprite/ConvertEffect.playing = false
