extends AnimatedSprite

export var speed = 180
var target: Node2D
var is_enemy = false
var origin: Node2D
var active = true

func set_target(target: Node2D):
	self.target = target
	
func _physics_process(delta):
	if(!active):
		return
	if(not is_instance_valid(target) && target != origin):
		destroy()
	else:
		rotation = global_position.angle_to_point(target.global_position) + PI/2
		global_position += global_position.direction_to(target.global_position) * speed * delta


func _on_Area2D_area_entered(area):
	if(!active):
		return
	if(area.is_in_group("shield")):
		var oil = preload("res://dudes/Bomber/ExplosionVerySmall.tscn").instance()
		oil.is_enemy = is_enemy
		add_child(oil)
		active = false
	elif(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy and area.get_parent() == target):
		var oil = preload("res://dudes/Bomber/ExplosionVerySmall.tscn").instance()
		oil.is_enemy = is_enemy
		add_child(oil)
		active = false

func destroy():
	queue_free()
