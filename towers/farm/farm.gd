extends "res://towers/tower.gd"

export var food_gained = 5

func _on_timer_timeout():
	ResourceManager.add_food(food_gained, is_enemy)
	
	if(not is_enemy):
		add_child(preload("res://ui/food_added_label.tscn").instance())
