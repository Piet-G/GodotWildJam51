extends Sprite

export var speed = 250
var target: Node2D
var is_enemy = false
var origin: Node2D
var direction

func set_direction():
	direction = global_position.direction_to(target.global_position)

func set_target(target: Node2D):
	self.target = target
	target.targeted = true
	
func _physics_process(delta):
	global_position += direction * speed * delta


func _on_Area2D_area_entered(area):
	if(area.is_in_group("mirror")):
		target = origin
		set_direction()
	elif(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy):
		area.get_parent().damage(1)
	elif(area.is_in_group("Tower") and area.get_parent().is_enemy == is_enemy and target == origin):
		area.get_parent().damage(1)
		destroy()

func destroy():
	queue_free()


func _on_Timer_timeout():
	if(target != null):
		target.targeted = false
	queue_free()
