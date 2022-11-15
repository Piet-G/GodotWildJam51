extends Node2D

var wanted_farm_to_other_ratio = 0.5
var wanted_barrack_to_other_ratio = 0.3

var farm_type = preload("res://towers/farm/farm_info.tres")
var tower_type = preload("res://towers/archery_tower/archery_tower_info.tres")
var barrack_type = preload("res://towers/barracks/barracks_info.tres")
var rino_type = preload("res://towers/barracks/RhinoField/RhinoField_info.tres")
var farm_count = 1
var barrack_count = 0
var tower_count = 0

var ai_tree = {"type": farm_type, "weight": 1, "next": [
			{"type": farm_type, "weight": 6, "next": []},
			{"type": tower_type, "weight": 3, "next": [
				{"type": farm_type, "weight": 2, "next": [
					{"type": farm_type, "weight": 2, "next": []},
					{"type": tower_type, "weight": 6, "next": []},
				]}
			]},
			{"type": barrack_type, "weight": 4, "next": [
				{"type": farm_type, "weight": 1, "next": [
					{"type": rino_type, "weight": 3, "from": barrack_type, "next": []}
				]}
			]}
		]}


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
	
var current_options = []
var next_option = ai_tree

func can_build(tower_info: TowerInfo):
	return ResourceManager.get_food(true) >= tower_info.food_cost

func _on_TickTimer_timeout():
	if(can_launch_war()):
		launch_war()
		return
		
	if(not next_option):
		return
	
	if(can_build(next_option.type)):
		if(next_option.has("from")):
			attempt_upgrade(next_option)
		else:
			attempt_build(next_option.type, "farm_weight")
		current_options.append_array(next_option.next)
		next_option = null
		
		if(len(current_options) == 0):
			return
			
		var max_weight = 0
		
		for option in current_options:
			max_weight += option.weight
			
		var chosen_weight = rand_range(0, max_weight)
		var counter = 0
		for option in current_options:
			counter += option.weight
			if(counter >= chosen_weight):
				next_option = option
				break
		
		current_options.erase(next_option) 

func attempt_upgrade(option):
	var list = GridService.get_buildings_of_info(option.from, true)
	
	var chosen = list[randi() % len(list)]
	
	chosen.upgrade_to(option.type, true)

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

