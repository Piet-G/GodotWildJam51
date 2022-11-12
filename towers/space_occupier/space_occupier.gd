class_name SpaceOccupier
extends Node2D

func _ready():
	GridService.add_illegal_space(GridService.to_grid_position(global_position + Vector2(1,1)))
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
