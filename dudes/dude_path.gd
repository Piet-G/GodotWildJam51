class_name DudePath
extends Path2D

export(NodePath) var next_switcher

func get_next_switcher():
	return get_node(next_switcher)

func is_final() -> bool:
	return not has_node(next_switcher)
