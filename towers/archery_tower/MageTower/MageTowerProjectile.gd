extends Sprite

export var speed = 180
var target: Node2D
var is_enemy = false
var origin: Node2D
var direction
var old_pos
var passed_enemy = false
var active =true

func _ready():
	old_pos = global_position

func set_direction():
	direction = ($Position2D.global_position - global_position).normalized()

func set_target(target: Node2D):
	self.target = target
	
func _physics_process(delta):
	if(!active):
		return
	if(not is_instance_valid(target) && target != origin && !passed_enemy):
		passed_enemy = true
		set_direction()
	if passed_enemy:
		global_position += direction * speed * delta
	else:
		rotation = global_position.angle_to_point(target.global_position) - PI
		global_position += global_position.direction_to(target.global_position) * speed * delta
		old_pos = global_position


func _on_Area2D_area_entered(area):
	if(!active):
		return
	if(area.is_in_group("mirror")):
		target = origin
	elif(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy):
		$Hit.play()
		area.get_parent().damage(2)
		set_direction()
		passed_enemy = true
	elif(area.is_in_group("Tower") and area.get_parent().is_enemy == is_enemy and target == origin):
		area.get_parent().damage(2)
		destroy()

func destroy():
	$Hit.play()
	active = false
	visible = false


func _on_Hit_finished():
	$Hit.stop()
	if(!active):
		queue_free()


func _on_Timer_timeout():
	queue_free()
