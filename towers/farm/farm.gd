extends "res://towers/tower.gd"

func _on_timer_timeout():
	ResourceManager.add_food(1)
	
	add_child(preload("res://ui/food_added_label.tscn").instance())
