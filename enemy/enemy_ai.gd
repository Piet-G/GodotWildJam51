extends Node2D

var wanted_farm_to_other_ratio = 0.5
var wanted_barrack_to_other_ratio = 0.3

var farm_type = preload("res://towers/farm/farm_info.tres")
var tower_type = preload("res://towers/archery_tower/archery_tower_info.tres")
var barrack_type = preload("res://towers/barracks/barracks_info.tres")
var rino_type = preload("res://towers/barracks/RhinoField/RhinoField_info.tres")
var knight_type = preload("res://towers/barracks/KnightCamp/KnightCamp_info.tres")
var rogue_type = preload("res://towers/barracks/RogueCamp/RogueCampInfo.tres")
var thief_type = preload("res://towers/barracks/ThievesGuild/ThievesGuild_info.tres")
var flyer_type = preload("res://towers/barracks/Airfield/Airfield_info.tres")
var mage_type = preload("res://towers/barracks/MageGuild/MageGuild_info.tres")
var shield_type = preload("res://towers/barracks/ShieldHall/ShieldHall_info.tres")

var catapult_type = preload("res://towers/archery_tower/CatapultTower/CatapulTower_info.tres")
var ballista_type = preload("res://towers/archery_tower/BallistaTower/BallistaTower_info.tres")
var mage_tower_type = preload("res://towers/archery_tower/MageTower/MageTower_info.tres")

var mill_type = preload("res://towers/farm/Mill/Mill_info.tres")
var treasury_type = preload("res://towers/farm/Treasury/Treasury_info.tres")
var workshop_type = preload("res://towers/farm/Workshop/Workshop_info.tres")

var mammoth_type = preload("res://towers/barracks/MammothField/MammothField_info.tres")
var tank_type = preload("res://towers/barracks/TankFactory/TankFactory_info.tres")
var bomb_type = preload("res://towers/barracks/BigBombBay/BigBombBay_info.tres")

var mech_mammoth_type = preload("res://towers/barracks/MechMammothFactory/MechMammothFactory_info.tres")

var farm_count = 1
var barrack_count = 0
var tower_count = 0


var wait_time_after_building = 1

var ai_tree = {"type": farm_type, "weight": 1, "next": [
			{"type": farm_type, "weight": 100, "next": [
				{"type": workshop_type, "weight": 10, "from": farm_type, "next": []},
			]},
			{"type": farm_type, "weight": 100, "next": [
				{"type": mill_type, "weight": 10, "from": farm_type, "next": []},
			]},
			{"type": farm_type, "weight": 100, "next": [
				{"type": treasury_type, "weight": 3, "from": farm_type, "next": []},
			]},
			{"type": farm_type, "weight": 100, "next": [
				{"type": mill_type, "weight": 10, "from": farm_type, "next": []},
			]},
			{"type": tower_type, "weight": 20, "next": [
				{"type": farm_type, "weight": 2, "next": [
					{"type": farm_type, "weight": 2, "next": []},
					{"type": tower_type, "weight": 6, "next": []},
				]},
				{"type": mage_tower_type, "weight": 6, "from": tower_type, "next": []},
			]},
			{"type": tower_type, "weight": 5, "next": [
				{"type": ballista_type, "weight": 6, "from": tower_type, "next": []},
			]},
			{"type": tower_type, "weight": 5, "next": [
				{"type": catapult_type, "weight": 6, "from": tower_type, "next": []},
			]},
			{"type": barrack_type, "weight": 4, "next": [
				{"type": rino_type, "weight": 3, "from": barrack_type, "next": [
					{"type": mammoth_type, "weight": 10, "from": rino_type, "next": [
						{"type": mech_mammoth_type, "weight": 40, "from": mammoth_type, "next": [
							
						]}
					]}
				]}
			]},
			{"type": barrack_type, "weight": 4, "next": [
				{"type": rino_type, "weight": 3, "from": barrack_type, "next": [
					{"type": tank_type, "weight": 10, "from": rino_type, "next": []}
				]}
			]},
			{"type": barrack_type, "weight": 4, "next": [
				{"type": rino_type, "weight": 3, "from": barrack_type, "next": [
					{"type": bomb_type, "weight": 5, "from": rino_type, "next": []}
				]}
			]},
			{"type": barrack_type, "weight": 4, "next": [
				{"type": knight_type, "weight": 6, "from": barrack_type, "next": [
					{"type": shield_type, "weight": 6, "from": knight_type, "next": []}
				]}
			]},
			{"type": barrack_type, "weight": 4, "next": [
				{"type": rogue_type, "weight": 6, "from": barrack_type, "next": [
					{"type": thief_type, "weight": 6, "from": rogue_type, "next": []}
				]}
			]},
			{"type": barrack_type, "weight": 4, "next": [
				{"type": rogue_type, "weight": 6, "from": barrack_type, "next": [
					{"type": flyer_type, "weight": 6, "from": rogue_type, "next": []}
				]}
			]},
			{"type": barrack_type, "weight": 4, "next": [
				{"type": rogue_type, "weight": 6, "from": barrack_type, "next": [
					{"type": mage_type, "weight": 6, "from": rogue_type, "next": []}
				]}
			]}
			
		]}


func can_launch_war():
	for barrack in GridService.get_buildings_of_type(Tower.Type.barracks, true):
		if(barrack.count >= barrack.max_dudes):
			return true
	return false

func launch_war():
	for barrack in GridService.get_buildings_of_type(Tower.Type.barracks, true):
		if(barrack.count > 1 and barrack.can_launch_war() and barrack.is_enemy):
			barrack.launch_war()
func get_building_count():
	return float(farm_count + tower_count + barrack_count)
	
var current_options = []
var next_option = ai_tree

func can_build(tower_info: TowerInfo):
	return ResourceManager.get_food(true) >= tower_info.food_cost and ResourceManager.get_gold(true) >= tower_info.gold_cost

func get_weight_name(type):
	if(Tower.Type.farm == type):
		return "farm_weight"
	elif(Tower.Type.barracks == type):
		return "barrack_weight"
	elif(Tower.Type.archery_tower == type):
		return "tower_weight"
		
	return "farm_weight"

func _on_TickTimer_timeout():
	$TickTimer.wait_time = 1
	if(can_launch_war()):
		launch_war()
		
	if(not next_option):
		return
	
	if(can_build(next_option.type)):
		if(next_option.has("from")):
			attempt_upgrade(next_option)
		else:
			attempt_build(next_option.type)
		
		ResourceManager.remove_food(next_option.type.food_cost, true)
		ResourceManager.remove_gold(next_option.type.gold_cost, true)
		current_options.append_array(next_option.next)
		next_option = null
		$TickTimer.wait_time = wait_time_after_building
		
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
	
	if(len(list) > 0):
		var chosen = list[randi() % len(list)]
	
		chosen.upgrade_to(option.type, true)

func attempt_build(tower_type: TowerInfo):
	var tower = load(tower_type.scene).instance()
	
	var total = GridService.get_weights_total(get_weight_name(tower.type))
	
	if(total <= 0):
		print("NO VALID SPACES")
		return
	
	var pos = GridService.get_position_with_weight(get_weight_name(tower.type), rand_range(0, total))

	tower.is_enemy = true
	add_child(tower)
	GridService.add_to_grid(tower, pos)

