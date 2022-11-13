extends Node2D

var wanted_farm_to_other_ratio = 0.5
var wanted_barrack_to_other_ratio = 0.3

var farm_type = preload("res://towers/farm/farm_info.tres")
var tower_type = preload("res://towers/archery_tower/archery_tower_info.tres")
var barrack_type = preload("res://towers/barracks/barracks_info.tres")

var farm_count = 1
var barrack_count = 0
var tower_count = 0

func can_launch_war():
	for barrack in GridService.get_buildings_of_type(Tower.Type.barracks, true):
		if(barrack.count > 5):
			return true
	return false

func launch_war():
	for barrack in GridService.get_buildings_of_type(Tower.Type.barracks, true):
		if(barrack.count > 3 and barrack.can_launch_war() and barrack.is_enemy):
			barrack.launch_war()
func get_building_count():
	return float(farm_count + tower_count + barrack_count)
	
func _on_TickTimer_timeout():
	if(can_launch_war()):
		launch_war()
		return
	
	if(get_building_count() > 23):
		return
	
	if(farm_count / get_building_count() <= wanted_farm_to_other_ratio):
		farm_count += 1
		attempt_build(farm_type, "farm_weight")
	if(barrack_count / get_building_count() <= wanted_barrack_to_other_ratio):
		barrack_count += 1
		attempt_build(barrack_type, "barrack_weight")
	else:
		tower_count += 1
		attempt_build(tower_type, "tower_weight")

func attempt_build(tower_type: TowerInfo, weight_name):
	if(ResourceManager.get_food(true) < tower_type.food_cost):
		return
	var total = GridService.get_weights_total(weight_name)
	
	if(total <= 0):
		return
	
	var pos = GridService.get_position_with_weight(weight_name, rand_range(0, total))
	var tower = load(tower_type.scene).instance()
	tower.is_enemy = true
	add_child(tower)
	GridService.add_to_grid(tower, pos)

