extends PathFollow2D


export(SpriteFrames) var regular_sprites_front
export(SpriteFrames) var enemy_sprites_front
export(SpriteFrames) var regular_sprites_back
export(SpriteFrames) var enemy_sprites_back

enum facing {NORMAL,TOP,BOTTOM}
var current_facing = facing.NORMAL




export var max_health = 1
export var movement_speed = 30
export var is_enemy = false
export var castle_damage = 1

export(SpriteFrames) var regular_sprites
export(SpriteFrames) var enemy_sprites
var targeted = false
var old_pos
var right = true
var sneaking = false
var health = max_health
	
func get_health():
	return health

func damage(amount):
	health -= amount
	if(health <= 0):
		queue_free()

func is_active():
	return true

func sneak():
	$SneakTimer.start()
	$AnimatedSprite.modulate = Color(0.2,0.2,0.2,0.4)
	$AnimatedSprite3.modulate = Color(0.2,0.2,0.2,0.4)
	$AnimatedSprite2.modulate = Color(0.2,0.2,0.2,0.4)
	sneaking = true

func stop_sneaking():
	$SneakTimer.stop()
	_on_SneakTimer_timeout()


# Called when the node enters the scene tree for the first time.
func _ready():
	old_pos = global_position
	if(not is_enemy):
		$AnimatedSprite.frames = regular_sprites
		$AnimatedSprite3.frames = regular_sprites_front
		$AnimatedSprite2.frames = regular_sprites_back
	else:
		$AnimatedSprite.frames = enemy_sprites
		$AnimatedSprite3.frames = enemy_sprites_front
		$AnimatedSprite2.frames = enemy_sprites_back


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
	
	if direction.y < -0.1 && current_facing != facing.TOP:
		$AnimatedSprite.visible = false
		$AnimatedSprite2.visible = true
		$AnimatedSprite3.visible = false
		current_facing = facing.TOP
	
	if direction.y > 0.1 && current_facing != facing.BOTTOM:
		$AnimatedSprite.visible = false
		$AnimatedSprite2.visible = false
		$AnimatedSprite3.visible = true
		current_facing = facing.BOTTOM
	
	if direction.x < -0.1 && (right || current_facing != facing.NORMAL):
		$AnimatedSprite.visible = true
		$AnimatedSprite2.visible = false
		$AnimatedSprite3.visible = false
		$AnimatedSprite.scale.x = -1
		right = false
		current_facing = facing.NORMAL
		
	if direction.x > 0.1 && (!right || current_facing != facing.NORMAL):
		$AnimatedSprite.visible = true
		$AnimatedSprite2.visible = false
		$AnimatedSprite3.visible = false
		$AnimatedSprite.scale.x = 1
		right = true
		current_facing = facing.NORMAL
		
	old_pos = global_position


func _on_SneakTimer_timeout():
	$AnimatedSprite.modulate = Color(1,1,1,1)
	$AnimatedSprite2.modulate = Color(1,1,1,1)
	$AnimatedSprite3.modulate = Color(1,1,1,1)
	sneaking = false

func inspire():
	max_health *= 2
	health *= 2
	castle_damage *= 2
	movement_speed += 10

func uninspire():
	max_health *= 2
	health = ceil(health/2)
	castle_damage = ceil(castle_damage/2)
	movement_speed -= 10

func heal():
	pass
