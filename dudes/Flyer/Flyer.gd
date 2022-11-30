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
var slow = false
var hasty = false
var discovered = false

func activate():
	active = true

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
	if discovered:
		return
	$SneakTimer.start()
	$AnimatedSprite.modulate = Color(0.2,0.2,0.2,0.4)
	sneaking = true

func stop_sneaking():
	$SneakTimer.stop()
	$AnimatedSprite.modulate = Color(1,1,1,1)
	sneaking = false

func damage(amount):
	$AnimationPlayer.play("Hit")
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
	
	if(targeted and $TargetedHotFix.is_stopped()):
		$TargetedHotFix.start()
	
	var direction = (target - global_position).normalized()
	global_position = global_position + (direction*movement_speed*delta)
	rotation = global_position.angle_to_point(target) + rot
	
	if(global_position.distance_to(target) < 50):
			
			CastleService.damage(castle_damage, not is_enemy)
			free()
			return


func _on_SneakTimer_timeout():
	stop_sneaking()

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

func oil():
	if(!slow):
		movement_speed -= 20
		slow = true

func slow():
	if(!slow):
		movement_speed -= 20
		slow = true
		$SlowTimer.start()

func stop_slow():
	if(slow):
		movement_speed += 20
		slow = false

func _on_SlowTimer_timeout():
	stop_slow()

func haste():
	if(!hasty):
		movement_speed += 20
		$hasteTimer.start()
		hasty = true

func stop_haste():
	if(hasty):
		movement_speed -= 20
		hasty = false

func _on_HasteTimer_timeout():
	stop_haste()

func bribe():
	is_enemy = !is_enemy
	
	if(not is_enemy):
		target = Vector2(760,40)
		rot = (-PI + 0.5)
		$AnimatedSprite.frames = regular_sprites
		$AnimatedSprite.position.x = $AnimatedSprite.position.x - 5
	else:
		rot = + 0.7
		target = Vector2(80,520)
		$AnimatedSprite.frames = enemy_sprites
		$AnimatedSprite.position.x = $AnimatedSprite.position.x - 10
	
func burn():
	pass

func discover():
	if sneaking:
		stop_sneaking()
		discovered = true


func _on_TargetedHotFix_timeout():
	$TargetedHotFix.stop()
	targeted = false
