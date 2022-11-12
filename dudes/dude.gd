extends PathFollow2D

export var health = 1
export var movement_speed = 30
var targeted = false
var old_pos

func _ready():
	old_pos = global_position

func damage(amount):
	health -= amount
	if(health <= 0):
		queue_free()

func _physics_process(delta):
	offset += movement_speed * delta
	
	if(unit_offset >= 1):
		var dude_path: DudePath = get_parent()
		
		if(dude_path.is_final()):
			free()
			return
			
		var next_path = dude_path.get_next_switcher().get_next_path_segment()
		
		unit_offset = 0
		dude_path.remove_child(self)
		position = Vector2()
		next_path.add_child(self)
	
	var direction = global_position - old_pos
	if direction.x < -0.1 :
		$AnimatedSprite.scale.x = -1
	else:
		$AnimatedSprite.scale.x = 1
	
	old_pos = global_position
