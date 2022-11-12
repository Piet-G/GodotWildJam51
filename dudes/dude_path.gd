class_name DudePath
extends Path2D

export(NodePath) var next_switcher
export var is_enemy = false

func _init():
	add_to_group("path")

func get_next_switcher():
	return get_node(next_switcher)

func is_final() -> bool:
	return not has_node(next_switcher)
