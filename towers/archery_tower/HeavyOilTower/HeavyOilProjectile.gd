extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 180
var target: Node2D
var is_enemy = false
var origin: Node2D
var active =true

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
	if(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy and area.get_parent() == target):
		var oil = preload("res://Effects/Oil/Oil.tscn").instance()
		get_parent().add_child(oil)
		oil.global_position = global_position
		area.get_parent().damage(1)
		destroy()

func destroy():
	$Hit.play()
	active = false
	visible = false


func _on_Hit_finished():
	$Hit.stop()
	queue_free()
