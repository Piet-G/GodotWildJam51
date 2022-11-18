extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var damage = 8
var is_enemy = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_ExplosionSmall_area_entered(area):
	if(!area.is_in_group("air") && (area.is_in_group("dude_area") || area.is_in_group("Tower")) and area.get_parent().is_enemy != is_enemy):
		area.get_parent().damage(8)


func _on_AnimatedSprite_animation_finished():
	get_parent().queue_free()
