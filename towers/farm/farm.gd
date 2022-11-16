extends "res://towers/tower.gd"

func _on_timer_timeout():
	ResourceManager.add_food(5, is_enemy)
	
	if(not is_enemy):
		add_child(preload("res://ui/food_added_label.tscn").instance())
