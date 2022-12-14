class_name Tower
extends Node2D

enum Type { barracks,archery_tower, farm}

export(Type) var type = Type.farm
export(Texture) var regular_texture
export(Texture) var enemy_texture
export(Resource) var tower_info
export(int) var max_health = 10
export var initially_in_world = false

export var is_enemy = false
var active = false
var health = 0
var buffed = false
var damage = 0
var targeted = false

signal clicked()

func is_active():
	return active

func set_grayscale(value):
	$Sprite.material.set_shader_param("grayscale", value)
	
func set_invalid(value):
	$Sprite.material.set_shader_param("invalid", value)

func _ready():
	health = max_health
	if(is_enemy):
		$Sprite.texture = enemy_texture
	else:
		$Sprite.texture = regular_texture
	
	if(initially_in_world):
		active = true
		GridService.add_to_grid(self, GridService.to_grid_position(global_position + Vector2(1,1)))

var recently_added_to_grid = false

func add_to_recent_grid():
	recently_added_to_grid = true
func added_to_grid():
	active = true
	$HelperTimer.start()
	if(!initially_in_world):
		$Build.play()
	$Area2D.connect("input_event", self, "_on_Area2D_input_event" )

func get_sprites():
	return [$Sprite]
	
func set_selected(value):
	$SelectedIndicator.visible = value

func _on_Area2D_input_event(viewport, event, shape_idx):
	if(event.is_action_pressed("place_tower") and not is_enemy and active and recently_added_to_grid):
		emit_signal("clicked")
		Ui.upgrade_clicked(self)
		
func truly_delete():
	destroy()
	GridService.remove_from_grid(GridService.to_grid_position(global_position + Vector2(1,1)))
	queue_free()

func upgrade_to(tower_info: TowerInfo, is_enemy=false):
	var new_tower = load(tower_info.scene).instance()
	new_tower.is_enemy = is_enemy
	get_tree().current_scene.add_child(new_tower)
	GridService.add_to_grid(new_tower, GridService.to_grid_position(global_position + Vector2(1,1)))
	queue_free()

func damage(amount):
	$AnimationPlayer.play("Hit")
	health -= amount
	$Sprite.modulate = Color(1- (max_health - health)*0.05, 1 - (max_health - health)*0.1, 1- (max_health - health)*0.1, 1)
	if(health <= 0):
		truly_delete()

func _on_HelperTimer_timeout():
	add_to_recent_grid()

func burn():
	$Burn.play()
	$BurningSprite.visible = true
	$BurningSprite.playing = true
	$BurningTimer.start()

func _on_BurningTimer_timeout():
	$Burn.stop()
	$BurningSprite.visible = false
	$BurningSprite.playing = false

func destroy():
	pass

func buff():
	if(!buffed):
		max_health *= 2
		health = max_health
		$Sprite.modulate = Color(1- (max_health - health)*0.05, 1 - (max_health - health)*0.1, 1- (max_health - health)*0.1, 1)
		damage *= 2
		buffed = true

func debuff():
	if(buffed):
		max_health = ceil(max_health/2)
		health = max_health
		$Sprite.modulate = Color(1- (max_health - health)*0.05, 1 - (max_health - health)*0.1, 1- (max_health - health)*0.1, 1)
		damage  = ceil(damage/2)
		buffed = false

func repair():
	if(health < max_health):
		health += 1
		$AnimationPlayer.play("Repair")
		$Sprite.modulate = Color(1- (max_health - health)*0.05, 1 - (max_health - health)*0.1, 1- (max_health - health)*0.1, 1)


func _on_AnimationPlayer_animation_finished(anim_name):
	$Sprite.modulate = Color(1- (max_health - health)*0.05, 1 - (max_health - health)*0.1, 1- (max_health - health)*0.1, 1)
