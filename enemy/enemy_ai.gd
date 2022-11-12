extends Node2D

var wanted_farm_to_other_ratio = 0.9

var farm_type = preload("res://towers/farm/farm_info.tres")
var tower_type = preload("res://towers/archery_tower/archery_tower_info.tres")


var farm_count = 1
var tower_count = 0

func get_building_count():
	return float(farm_count + tower_count)
	
func get_next_building_type() -> TowerInfo:
	if(farm_count / get_building_count() <= wanted_farm_to_other_ratio):
		print(farm_count / get_building_count())
		return farm_type
	else:
		return tower_type
	
func _on_TickTimer_timeout():
	var next_type: TowerInfo = get_next_building_type()
	
	print(ResourceManager.get_food(true))
	if(ResourceManager.get_food(true) < next_type.food_cost):
		return
	
	ResourceManager.remove_food(next_type.food_cost, true)
	if(next_type == farm_type):
		var total = GridService.get_weights_total("farm_weight")
		
		if(total <= 0):
			return
		
		var pos = GridService.get_position_with_weight("farm_weight", rand_range(0, total))
		var farm = load(next_type.scene).instance()
		farm.is_enemy = true
		add_child(farm)
		GridService.add_to_grid(farm, pos)

		farm_count += 1
	elif(next_type == tower_type):
		var total = GridService.get_weights_total("tower_weight")
		
		if(total <= 0):
			return
		
		var pos = GridService.get_position_with_weight("tower_weight", rand_range(0, total))
		var tower = load(next_type.scene).instance()
		tower.is_enemy = true

		add_child(tower)
		
		GridService.add_to_grid(tower, pos)
		tower_count += 1
