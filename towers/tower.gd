class_name Tower
extends Node2D

enum Type { barracks,archery_tower, farm}

export(Type) var type = Type.farm
export(Texture) var regular_texture
export(Texture) var enemy_texture
export(Resource) var tower_info
export(int) var max_health = 10

export var is_enemy = false
var active = false
var health

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

var recently_added_to_grid = false

func add_to_recent_grid():
	recently_added_to_grid = true
func added_to_grid():
	active = true
	$HelperTimer.start()
	
	$Area2D.connect("input_event", self, "_on_Area2D_input_event" )

func get_sprites():
	return [$Sprite]
	
func set_selected(value):
	$SelectedIndicator.visible = value

func _on_Area2D_input_event(viewport, event, shape_idx):
	print(active, is_enemy,event.is_action_pressed("place_tower"))
	if(event.is_action_pressed("place_tower") and not is_enemy and active and recently_added_to_grid):
		emit_signal("clicked")
		Ui.upgrade_clicked(self)
		
func upgrade_to(tower_info: TowerInfo, is_enemy=false):
	print("Spawning", tower_info.name)
	var new_tower = load(tower_info.scene).instance()
	new_tower.is_enemy = is_enemy
	get_tree().current_scene.add_child(new_tower)
	GridService.add_to_grid(new_tower, GridService.to_grid_position(global_position + Vector2(1,1)))
	queue_free()

func damage(amount):
	health -= amount
	$Sprite.modulate = Color(1- (max_health - health)*0.05, 1 - (max_health - health)*0.1, 1- (max_health - health)*0.1, 1)
	if(health <= 0):
		GridService.remove_from_grid(GridService.to_grid_position(global_position + Vector2(1,1)))
		queue_free()

func _on_HelperTimer_timeout():
	add_to_recent_grid()

func burn():
	$BurningSprite.visible = true
	$BurningSprite.playing = true
	$BurningTimer.start()

func _on_BurningTimer_timeout():
	$BurningSprite.visible = false
	$BurningSprite.playing = false
