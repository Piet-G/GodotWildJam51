class_name Tower
extends Node2D

enum Type { barracks,archery_tower, farm}

export(Type) var type = Type.farm

export var is_enemy = false
var active = false

func is_active():
	return active

func added_to_grid():
	active = true
