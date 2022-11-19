extends Sprite

export var speed = 180
var target: Node2D
var is_enemy = false
var origin: Node2D
var active = true
export var damage = 1

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
	if(area.is_in_group("mirror")):
		target = origin
	elif(area.is_in_group("shield")):
		destroy()
		if(is_instance_valid(target)):
			self.target.targeted = false
	elif(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy):
		area.get_parent().damage(damage)
		if(is_instance_valid(target)):
			self.target.targeted = false
		destroy()
	elif(area.is_in_group("Tower") and area.get_parent().is_enemy == is_enemy and target == origin):
		area.get_parent().damage(damage)
		destroy()

func destroy():
	active = false
	visible = false
	$Hit.play()


func _on_Hit_finished():
	queue_free()
