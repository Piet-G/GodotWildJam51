class_name Tower
extends Node2D

enum Type { barracks,archery_tower, farm}

export(Type) var type = Type.farm
export(Texture) var regular_texture
export(Texture) var enemy_texture
export(Resource) var tower_info

export var is_enemy = false
var active = false

signal clicked()

func is_active():
	return active

func set_grayscale(value):
	$Sprite.material.set_shader_param("grayscale", value)

func _ready():
	if(is_enemy):
		$Sprite.texture = enemy_texture
	else:
		$Sprite.texture = regular_texture

func added_to_grid():
	active = true
	
	$Area2D.connect("input_event", self, "_on_Area2D_input_event" )

func get_sprites():
	return [$Sprite]
	
func set_selected(value):
	$SelectedIndicator.visible = value

func _on_Area2D_input_event(viewport, event, shape_idx):
	print(active, is_enemy,event.is_action_pressed("place_tower"))
	if(event.is_action_pressed("place_tower") and not is_enemy and active):
		emit_signal("clicked")
		Ui.upgrade_clicked(self)
