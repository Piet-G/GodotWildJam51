class_name PathSwitcher
extends Node2D

export var current_active = [0]
export(Array, NodePath) var next_paths = []

var index = 0

func get_next_path_segment() -> DudePath:
	index = (index + 1) % len(current_active)
	return get_node(next_paths[current_active[index]]) as DudePath

func is_path_active(index):
	return index in current_active

func togle_path_active(index):
	if(index in current_active):
		if(len(current_active) == 1):
			current_active.append((index + 1) % 2)
		current_active.erase(index)
		
	else:
		current_active.append(index)
	
