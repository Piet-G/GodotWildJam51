extends Sprite

export var speed = 180
var target: Node2D
var is_enemy = false
var active = true

func set_target(target: Node2D):
	self.target = target
	
func _physics_process(delta):
	if(!active):
		return
	if(not is_instance_valid(target)):
		queue_free()
	else:
		rotation = global_position.angle_to_point(target.global_position) - PI
		global_position += global_position.direction_to(target.global_position) * speed * delta


func _on_Area2D_area_entered(area):
	if(!active):
		return
	if(area.is_in_group("Tower") and area.get_parent().is_enemy != is_enemy):
		area.get_parent().damage(1)
		destroy()


func destroy():
	active = false
	visible = false
	$Hit.play()


func _on_Hit_finished():
	queue_free()
