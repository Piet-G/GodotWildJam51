extends PathFollow2D


export(SpriteFrames) var regular_sprites_front
export(SpriteFrames) var enemy_sprites_front
export(SpriteFrames) var regular_sprites_back
export(SpriteFrames) var enemy_sprites_back

enum facing {NORMAL,TOP,BOTTOM}
var current_facing = facing.NORMAL




export var health = 1
export var movement_speed = 30
export var is_enemy = false
export var castle_damage = 1

export(SpriteFrames) var regular_sprites
export(SpriteFrames) var enemy_sprites
var targeted = false
var old_pos
var right = true
	
func get_health():
	return health

func damage(amount):
	health -= amount
	if(health <= 0):
		queue_free()

func is_active():
	return true


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