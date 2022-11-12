class_name Tower
extends Node2D

enum Type { barracks,archery_tower, farm}

export(Type) var type = Type.farm

export var is_enemy = false
