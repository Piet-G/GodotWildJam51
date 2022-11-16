extends Sprite

export var speed = 180
var target: Node2D
var is_enemy = false
func set_target(target: Node2D):
	self.target = target
	target.targeted = true
	
func _physics_process(delta):
	if(not is_instance_valid(target)):
		queue_free()
	else:
		rotation = global_position.angle_to_point(target.global_position) - PI
		global_position += global_position.direction_to(target.global_position) * speed * delta


func _on_Area2D_area_entered(area):
	if(area.is_in_group("shield")):
		queue_free()
		if(is_instance_valid(target)):
			self.target.targeted = false
	if(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy):
		area.get_parent().damage(1)
		if(is_instance_valid(target)):
			self.target.targeted = false
		queue_free()
