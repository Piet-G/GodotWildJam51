extends Sprite

export var speed = 60
var target: Node2D
func set_target(target: Node2D):
	self.target = target
	target.targeted = true
	
func _physics_process(delta):
	if(not is_instance_valid(target)):
		queue_free()
	else:
		global_position += global_position.direction_to(target.global_position) * speed * delta


func _on_Area2D_area_entered(area):
	if(area.is_in_group("dude_area")):
		area.get_parent().damage(1)
		self.target.targeted = false
		queue_free()
