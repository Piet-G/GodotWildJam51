class_name SpaceOccupier
extends Node2D

export var road = false

func _ready():
	GridService.add_illegal_space(GridService.to_grid_position(global_position + Vector2(1,1)))
	
	if(road):
		GridService.add_road(GridService.to_grid_position(global_position + Vector2(1,1)))
		print("added")
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
