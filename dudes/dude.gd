extends PathFollow2D

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
var direction = Vector2.ZERO
var health
var active = false
var slow = false
var hasty

func _ready():
	health = max_health
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

func stop_sneaking():
	$SneakTimer.stop()
	$AnimatedSprite.modulate = Color(1,1,1,1)
	sneaking = false

func damage(amount):
	health -= amount
	if(health <= 0):
		var death = true
		for area in $Area2D.get_overlapping_areas():
			if(area.is_in_group("angel_area")and area.get_parent().is_enemy == is_enemy):
				if(area.get_parent().cast()):
					health = max_health
					$Revive.visible = true
					$Revive.play()
					death = false
		if(death):
			queue_free()
		

func is_active():
	return true
	
func get_z_position():
	return global_position.y - 20

func _physics_process(delta):
	if(not active):
		return
	offset += movement_speed * delta
	
	if(unit_offset >= 1):
		var dude_path: DudePath = get_parent()
		
		if(dude_path.is_final()):
			
			reached_castle()
			return
			
		var next_path = dude_path.get_next_switcher().get_next_path_segment()
		
		unit_offset = 0
		dude_path.remove_child(self)
		position = Vector2()
		next_path.add_child(self)
	
	direction = global_position - old_pos
	if direction.x < -0.1 && right:
		$AnimatedSprite.scale.x = -1
		right = false
	if direction.x > 0.1 && !right:
		$AnimatedSprite.scale.x = 1
		right = true
	
	old_pos = global_position


func _on_SneakTimer_timeout():
	stop_sneaking()

func inspire():
	if(not active):
		return
	max_health *= 2
	health *= 2
	castle_damage *= 2
	movement_speed += 10

func uninspire():
	if(not active):
		return
	max_health *= 2
	health = ceil(health/2)
	castle_damage = ceil(castle_damage/2)
	movement_speed -= 10

func reached_castle():
	CastleService.damage(castle_damage, not is_enemy)
	queue_free()
	return

func heal():
	if(not active):
		return
	if(health < max_health):
		health += 1
	$AnimatedSprite/Healing.visible = true
	$AnimatedSprite/Healing.play()


func _on_Healing_animation_finished():
	$AnimatedSprite/Healing.visible = false
	$AnimatedSprite/Healing.playing = false

func activate():
	active = true

func oil():
	if(!slow):
		movement_speed -= 20
		$AnimatedSprite/Slow.visible = true
		$AnimatedSprite/Slow.play()
		slow = true

func slow():
	if(!slow):
		movement_speed -= 20
		$AnimatedSprite/Slow.visible = true
		$AnimatedSprite/Slow.play()
		$SlowTimer.start()
		slow = true

func stop_slow():
	if(slow):
		movement_speed += 20
		$AnimatedSprite/Slow.visible = false
		$AnimatedSprite/Slow.playing = false
		slow = false
	


func _on_SlowTimer_timeout():
	stop_slow()


func haste():
	if(!hasty):
		movement_speed += 20
		$AnimatedSprite/Haste.visible = true
		$AnimatedSprite/Haste.play()
		$hasteTimer.start()
		hasty = true

func stop_haste():
	if(hasty):
		movement_speed -= 20
		$AnimatedSprite/Haste.visible = false
		$AnimatedSprite/Haste.playing = false
		hasty = false

func _on_HasteTimer_timeout():
	stop_haste()

func bribe():
	is_enemy = !is_enemy
	
	if(not is_enemy):
		$AnimatedSprite.frames = regular_sprites
	else:
		$AnimatedSprite.frames = enemy_sprites
	
	var closest_distance = 100000000000000
	var closest_path: Path2D
	
	for path in get_tree().get_nodes_in_group("path"):
		if(path.is_enemy == is_enemy):
			var path_node: Path2D = path
			var local_pos = path_node.to_local(global_position)
			var distance = path_node.curve.get_closest_point(local_pos).distance_to(local_pos)
			
			if(distance < closest_distance):
				closest_distance = distance
				closest_path = path_node
	
	closest_path.add_child(self)
	var local_pos = closest_path.to_local(global_position)
	offset = closest_path.curve.get_closest_offset(local_pos)


func _on_Revive_animation_finished():
	$Revive.visible = false
	$Revive.playing = false

func burn():
	$BurnTimer1.start()
	$AnimatedSprite/Burn.visible = true
	$AnimatedSprite/Burn.play()


func _on_BurnTimer1_timeout():
	damage(1)
	$BurnTimer2.start()


func _on_BurnTimer2_timeout():
	damage(1)
	$BurnTimer3.start()


func _on_BurnTimer3_timeout():
	damage(1)
	$AnimatedSprite/Burn.visible = false
	$AnimatedSprite/Burn.playing = false

