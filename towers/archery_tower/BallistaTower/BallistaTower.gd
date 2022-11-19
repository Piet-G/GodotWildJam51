extends "res://towers/archery_tower/archery_tower.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(SpriteFrames) var regular_sprites_right
export(SpriteFrames) var enemy_sprites_right
export(SpriteFrames) var regular_sprites_left
export(SpriteFrames) var enemy_sprites_left
export(SpriteFrames) var regular_sprites_down
export(SpriteFrames) var enemy_sprites_down
export(SpriteFrames) var regular_sprites_up
export(SpriteFrames) var enemy_sprites_up

export(SpriteFrames) var regular_sprites_right_up
export(SpriteFrames) var enemy_sprites_right_up
export(SpriteFrames) var regular_sprites_left_up
export(SpriteFrames) var enemy_sprites_left_up
export(SpriteFrames) var regular_sprites_right_down
export(SpriteFrames) var enemy_sprites_right_down
export(SpriteFrames) var regular_sprites_left_down
export(SpriteFrames) var enemy_sprites_left_down

# Called when the node enters the scene tree for the first time.
func _ready():
	if(is_enemy):
		$AnimatedSprite.frames = enemy_sprites_left
	else:
		$AnimatedSprite.frames = regular_sprites_right

func aim(target: Node2D):
	var angle = global_position.angle_to_point(target.global_position)
	
	if(angle < -(7*PI/8)):
		if(is_enemy):
			$AnimatedSprite.frames = enemy_sprites_right
		else:
			$AnimatedSprite.frames = regular_sprites_right
	elif(angle < -5*PI/8):
		if(is_enemy):
			$AnimatedSprite.frames = enemy_sprites_right_down
		else:
			$AnimatedSprite.frames = regular_sprites_right_down
	elif(angle < -3*PI/8):
		if(is_enemy):
			$AnimatedSprite.frames = enemy_sprites_down
		else:
			$AnimatedSprite.frames = regular_sprites_down
	elif(angle < -PI/8):
		if(is_enemy):
			$AnimatedSprite.frames = enemy_sprites_left_down
		else:
			$AnimatedSprite.frames = regular_sprites_left_down
	elif(angle < PI/8):
		if(is_enemy):
			$AnimatedSprite.frames = enemy_sprites_left
		else:
			$AnimatedSprite.frames = regular_sprites_left
	elif(angle < 3*PI/8):
		if(is_enemy):
			$AnimatedSprite.frames = enemy_sprites_left_up
		else:
			$AnimatedSprite.frames = regular_sprites_left_up
	elif(angle < 5*PI/8):
		if(is_enemy):
			$AnimatedSprite.frames = enemy_sprites_up
		else:
			$AnimatedSprite.frames = regular_sprites_up
	elif(angle < 7*PI/8):
		if(is_enemy):
			$AnimatedSprite.frames = enemy_sprites_right_up
		else:
			$AnimatedSprite.frames = regular_sprites_right_up
	else:
		if(is_enemy):
			$AnimatedSprite.frames = enemy_sprites_right
		else:
			$AnimatedSprite.frames = regular_sprites_right

func shoot_at(dude: Node2D):
	aim(dude)
	
	var arrow = preload("res://towers/archery_tower/arrow.tscn").instance()
	arrow.is_enemy = is_enemy
	arrow.origin = self
	arrow.damage = 2

	$ArrowPosition.add_child(arrow)
	arrow.set_target(dude)
	
	$AnimatedSprite.play()


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.playing = false
	$AnimatedSprite.frame = 0

func damage(amount):
	health -= amount
	$AnimationPlayer.play("Hit")
	$AnimationPlayer2.play("BallistaTowerHitBalista")
	$AnimatedSprite.modulate = Color(1- (max_health - health)*0.05, 1 - (max_health - health)*0.1, 1- (max_health - health)*0.1, 1)
	if(health <= 0):
		destroy()
		GridService.remove_from_grid(GridService.to_grid_position(global_position + Vector2(1,1)))
		queue_free()

func repair():
	if(health < max_health):
		health += 1
		$AnimationPlayer.play("Repair")
		$AnimationPlayer2.play("BallistaTowerRepairBalista")
		$Sprite.modulate = Color(1- (max_health - health)*0.05, 1 - (max_health - health)*0.1, 1- (max_health - health)*0.1, 1)


func _on_AnimationPlayer2_animation_finished(anim_name):
	$Sprite.modulate = Color(1- (max_health - health)*0.05, 1 - (max_health - health)*0.1, 1- (max_health - health)*0.1, 1)
