extends Node2D

var wanted_farm_to_other_ratio = 0.2

var farm_type = preload("res://towers/farm/farm_info.tres")

func get_next_building_type() -> TowerInfo:
	return farm_type
	
func _on_TickTimer_timeout():
	pass # Replace with function body.
