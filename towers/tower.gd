class_name Tower
extends Node2D

enum Type { barracks,archery_tower, farm}

export(Type) var type = Type.farm
export(Texture) var regular_texture
export(Texture) var enemy_texture

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

func get_sprites():
	return [$Sprite]

func _on_Area2D_input_event(viewport, event, shape_idx):
	if(event.is_action_pressed("select_path")):
		emit_signal("clicked")
