extends PathFollow2D

export var health = 1
export var movement_speed = 30
export var is_enemy = false
export var castle_damage = 1

export(SpriteFrames) var regular_sprites
export(SpriteFrames) var enemy_sprites
var targeted = false
var old_pos
var right = true
var sneaking = false

func _ready():
	old_pos = global_position
	
	if(not is_enemy):
		$AnimatedSprite.frames = regular_sprites
	else:
		$AnimatedSprite.frames = enemy_sprites
	
func get_health():
	return health

func sneak():
	$SneakTimer.start()
	$AnimatedSprite.modulate = Color(0.2,0.2,0.2,0.4)
	sneaking = true

func damage(amount):
	health -= amount
	if(health <= 0):
		queue_free()

func is_active():
	return true
	
func get_z_position():
	return global_position.y - 20

func _physics_process(delta):
	offset += movement_speed * delta
	
	if(unit_offset >= 1):
		var dude_path: DudePath = get_parent()
		
		if(dude_path.is_final()):
			
			CastleService.damage(castle_damage, not is_enemy)
			free()
			return
			
		var next_path = dude_path.get_next_switcher().get_next_path_segment()
		
		unit_offset = 0
		dude_path.remove_child(self)
		position = Vector2()
		next_path.add_child(self)
	
	var direction = global_position - old_pos
	if direction.x < -0.1 && right:
		$AnimatedSprite.scale.x = -1
		right = false
	if direction.x > 0.1 && !right:
		$AnimatedSprite.scale.x = 1
		right = true
	
	old_pos = global_position


func _on_SneakTimer_timeout():
	$AnimatedSprite.modulate = Color(1,1,1,1)
	sneaking = false
