extends PathFollow2D

export var movement_speed = 50
export var is_enemy = false
export var castle_damage = 1
export var max_health = 1

export(SpriteFrames) var regular_sprites
export(SpriteFrames) var enemy_sprites
var targeted = false
var sneaking = false
var direction = Vector2.ZERO
var target = Vector2(760,40)
var rot = (-PI + 0.5)
var active = false
var health

func _ready():
	health = max_health
	$AnimatedSprite.z_index = 100
	$Sprite.z_index = 100
	if(not is_enemy):
		$AnimatedSprite.frames = regular_sprites
		$AnimatedSprite.position.x = $AnimatedSprite.position.x - 5
	else:
		rot = + 0.7
		target = Vector2(80,520)
		$AnimatedSprite.frames = enemy_sprites
		$AnimatedSprite.position.x = $AnimatedSprite.position.x - 10
	
func get_health():
	return health

func sneak():
	$SneakTimer.start()
	$AnimatedSprite.modulate = Color(0.2,0.2,0.2,0.4)
	sneaking = true

func stop_sneaking():
	$SneakTimer.stop()
	$AnimatedSprite.modulate = Color(1,1,1,1)
	sneaking = false

func damage(amount):
	health -= amount
	if(health <= 0):
		queue_free()

func is_active():
	return active
	
func get_z_position():
	return global_position.y - 20

func _physics_process(delta):
	if(not is_active()):
		return
	var direction = (target - global_position).normalized()
	global_position = global_position + (direction*movement_speed*delta)
	rotation = global_position.angle_to_point(target) + rot
	
	if(global_position.distance_to(target) < 50):
			
			CastleService.damage(castle_damage, not is_enemy)
			free()
			return


func _on_SneakTimer_timeout():
	stop_sneaking()
