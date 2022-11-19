extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 180
var target: Node2D
var is_enemy = false
var origin: Node2D
var active = true

func set_target(target: Node2D):
	self.target = target
	target.targeted = true
	
func _physics_process(delta):
	if(!active):
		return
	if(not is_instance_valid(target) && target != origin):
		destroy()
	else:
		rotation = global_position.angle_to_point(target.global_position) - PI
		global_position += global_position.direction_to(target.global_position) * speed * delta


func _on_Area2D_area_entered(area):
	if(!active):
		return
	if(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy):
		area.get_parent().damage(2)
		area.get_parent().slow()
		if(is_instance_valid(target)):
			self.target.targeted = false
		destroy()

func destroy():
	$Hit.play()
	active = false
	visible = false


func _on_Hit_finished():
	queue_free()
