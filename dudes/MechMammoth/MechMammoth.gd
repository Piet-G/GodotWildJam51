extends "res://dudes/Mammoth/Mammoth.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var old_facing = facing.NORMAL

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	if(old_facing != current_facing):
		if(current_facing == facing.NORMAL):
			if(!right):
				$Range.scale.x = -1
			else:
				$Range.scale.x = 1
		elif(current_facing == facing.BOTTOM):
				$RangeUp.scale.y = -1
		else:
			$RangeUp.scale.y = 1
	

func shoot_at_front():
	var laser = preload("res://dudes/MechMammoth/MechMammoth_projectile.tscn").instance()
	if(right):
		laser.direction = Vector2(1,0)
	else:
		laser.direction = Vector2(-1,0)
	laser.is_enemy = is_enemy
	get_parent().add_child(laser)
	laser.global_position = $AnimatedSprite/Position2D.global_position
	$Timer.start()
	$AnimatedSprite/Shoot.visible = true
	$AnimatedSprite/Shoot.play()

func shoot_at_top():
	var laser = preload("res://dudes/MechMammoth/Mechmammoth_projectile.tscn").instance()
	laser.is_enemy = is_enemy
	get_parent().add_child(laser)
	$Timer.start()
	if(current_facing == facing.BOTTOM):
		laser.direction = Vector2(0,1)
		laser.global_position = $AnimatedSprite2/Position2D.global_position
		$ShootFront.visible = true
		$ShootFront.play()
	else:
		laser.direction = Vector2(0,-1)
		laser.global_position = $AnimatedSprite3/Position2D.global_position
		$ShootBack.visible = true
		$ShootBack.play()



func _on_Timer_timeout():
	if(current_facing == facing.NORMAL):
		for area in $Range.get_overlapping_areas():
			if(area.is_in_group("Tower") and area.get_parent().is_enemy != is_enemy and area.get_parent().is_active()):
				shoot_at_front()
				return
	else:
		for area in $RangeUp.get_overlapping_areas():
			if(area.is_in_group("Tower") and area.get_parent().is_enemy != is_enemy and area.get_parent().is_active()):
				shoot_at_top()
				return


func _on_Range_area_entered(area):
	if(not active || !(current_facing == facing.NORMAL)):
		return
	if($Timer.is_stopped()):
		for area in $Range.get_overlapping_areas():
			if(area.is_in_group("Tower") and area.get_parent().is_enemy != is_enemy):
				shoot_at_front()
				return


func _on_RangeUp_area_entered(area):
	if(not active || (current_facing == facing.NORMAL)):
		return
	if($Timer.is_stopped()):
		for area in $RangeUp.get_overlapping_areas():
			if(area.is_in_group("Tower") and area.get_parent().is_enemy != is_enemy):
				shoot_at_top()
				return


func _on_ShootFront_animation_finished():
	$ShootFront.visible = false
	$ShootFront.playing = false


func _on_ShootBack_animation_finished():
	$ShootBack.visible = false
	$ShootBack.playing = false


func _on_Shoot_animation_finished():
	$AnimatedSprite/Shoot.visible = false
	$AnimatedSprite/Shoot.playing = false
