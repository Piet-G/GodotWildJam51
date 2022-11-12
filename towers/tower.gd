class_name Tower
extends Node2D

enum Type { barracks,archery_tower, farm}

export(Type) var type = Type.farm
export(Texture) var regular_texture
export(Texture) var enemy_texture

export var is_enemy = false
var active = false

func is_active():
	return active

func _ready():
	if(is_enemy):
		$Sprite.texture = enemy_texture
	else:
		$Sprite.texture = regular_texture

func added_to_grid():
	active = true
