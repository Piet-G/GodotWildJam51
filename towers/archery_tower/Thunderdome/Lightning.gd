extends Sprite

export var speed = 180
var target: Node2D
var is_enemy = false
var origin: Node2D
var bounces = 3

func set_target(target: Node2D):
	self.target = target
	target.targeted = true
	
func _physics_process(delta):
	if(not is_instance_valid(target) && target != origin):
		destroy()
	else:
		rotation = global_position.angle_to_point(target.global_position) - PI
		global_position += global_position.direction_to(target.global_position) * speed * delta


func _on_Area2D_area_entered(area):
	if(area.is_in_group("mirror")):
		target = origin
	elif(area.is_in_group("shield")):
		destroy()
		if(is_instance_valid(target)):
			self.target.targeted = false
	elif(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy):
		area.get_parent().damage(1)
		if(is_instance_valid(target)):
			self.target.targeted = false
		bounce()
	elif(area.is_in_group("Tower") and area.get_parent().is_enemy == is_enemy and target == origin):
		area.get_parent().damage(1)
		destroy()

func destroy():
	queue_free()

func bounce():
	if bounces <= 0:
		destroy()
	var found = false
	for area in $Range.get_overlapping_areas():
		if(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy and area.get_parent().active and area.get_parent() != target):
			target = area.get_parent()
			target.targeted = true
			found = true
			break
	if(!found):
		destroy()
