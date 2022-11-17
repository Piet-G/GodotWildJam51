extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var is_enemy = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), 8, Tween.TRANS_LINEAR)
	$Tween.start()
	yield($Tween,"tween_completed")
	queue_free()


func _on_Oil_area_entered(area):
	if(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy):
		area.get_parent().oil()


func _on_Oil_area_exited(area):
	if(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy):
		area.get_parent().stop_slow()
