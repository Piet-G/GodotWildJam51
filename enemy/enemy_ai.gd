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
var bomb_type = preload("res://towers/barracks/BombBay/BombBay_info.tres")

var anti_air_type = preload("res://towers/archery_tower/AntiAirTower/AntiAir_info.tres")

var mech_mammoth_type = preload("res://towers/barracks/MechMammothFactory/MechMammothFactory_info.tres")

var fire_mage_type = preload("res://towers/barracks/FireMageGuild/FireMageGuild_info.tres")
var air_mage_type = preload("res://towers/barracks/AirMageGuild/AirMageGuild_info.tres")
var earth_mage_type = preload("res://towers/barracks/EarthMageGuild/EarthMageGuild_info.tres")

var fire_tower_type = preload("res://towers/archery_tower/FireTower/FireTower_info.tres")
var fire_wall_tower_type = preload("res://towers/archery_tower/FirewallTower/FirewallTower_info.tres")

var machine_gun_type = preload("res://towers/archery_tower/MachineGunTower/MachineGunTower.tres")
var heavy_machine_gun_type = preload("res://towers/archery_tower/HeavyMachineGunTower/HeavyMachineGunTower_info.tres")

var air_bomber_type = preload("res://towers/barracks/BomberAirfield/BomberAirfield_info.tres")
var zeppelin_type = preload("res://towers/barracks/ZeppelinBay/ZeppelinBay_info.tres")

var rocket_type = preload("res://towers/archery_tower/RocketTower/RocketTower_info.tres")
var buff_type = preload("res://towers/archery_tower/BuffTower/BuffTower_info.tres")
var big_buff_type = preload("res://towers/archery_tower/BigBuffTower/BigBuffTower_info.tres")
var listening_post_type = preload("res://towers/archery_tower/ListeningPost/ListeningPost_info.tres")

var shield_hall_type = preload("res://towers/barracks/ShieldHall/ShieldHall_info.tres")
var mirror_hall_type = preload("res://towers/barracks/MirrorHall/MirrorHall_info.tres")

var keep_type = preload("res://towers/barracks/Keep/Keep_info.tres")
var throne_type = preload("res://towers/barracks/Throne/Throne_info.tres")

var church_type = preload("res://towers/barracks/Church/Church_info.tres")
var altar_type = preload("res://towers/barracks/Altar/Altar_info.tres")

var fire_tank_type = preload("res://towers/barracks/FireTankFactory/FireTankFactory_info.tres")
var big_bomb_type = preload("res://towers/barracks/BigBombBay/BigBombBay_info.tres")

var thunder_type = preload("res://towers/archery_tower/Thunderdome/Thunderdome_info.tres")
var storm_type = preload("res://towers/archery_tower/StormTower/StormTower_info.tres")
var necromancy_type = preload("res://towers/archery_tower/NecromancerTower/NecromancerTower_info.tres")
var dark_type = preload("res://towers/archery_tower/DarkTower/DarkTower_info.tres")
var oil_type = preload("res://towers/archery_tower/OilTower/OilTower_info.tres")
var heavy_oil_type = preload("res://towers/archery_tower/HeavyOilTower/HeavyOilTower_info.tres")

var farm_count = 1
var barrack_count = 0
var tower_count = 0


var wait_time_after_building = 1
var cost_reduction = 0.8

var ai_tree = {"type": farm_type, "weight": 1, "next": [
			{"type": farm_type, "weight": 100, "next": [
				{"type": workshop_type, "weight": 10, "from": farm_type, "next": []},
			]},
			{"type": farm_type, "weight": 100, "next": [
				{"type": mill_type, "weight": 5, "from": farm_type, "next": []},
			]},
			{"type": farm_type, "weight": 100, "next": [
				{"type": treasury_type, "weight": 5, "from": farm_type, "next": []},
			]},
			{"type": farm_type, "weight": 100, "next": [
				{"type": mill_type, "weight": 5, "from": farm_type, "next": []},
			]},
			{"type": farm_type, "weight": 5, "next": [
				{"type": mill_type, "weight": 5, "from": farm_type, "next": []},
			]},
			{"type": farm_type, "weight": 5, "next": [
				{"type": mill_type, "weight": 5, "from": farm_type, "next": []},
			]},
			{"type": farm_type, "weight": 5, "next": [
				{"type": mill_type, "weight": 5, "from": farm_type, "next": []},
			]},
			{"type": farm_type, "weight": 5, "next": [
				{"type": mill_type, "weight": 5, "from": farm_type, "next": []},
			]},
			{"type": farm_type, "weight": 5, "next": [
				{"type": treasury_type, "weight": 5, "from": farm_type, "next": []},
			]},
			{"type": tower_type, "weight": 5, "next": [
				{"type": barrack_type, "weight": 4, "next": [
					{"type": mage_tower_type, "weight": 6, "from": tower_type, "next": [
						{"type": rino_type, "weight": 3, "from": barrack_type, "next": [
							{"type": thunder_type, "weight": 6, "from": mage_tower_type, "next": [
								{"type": bomb_type, "weight": 5, "from": rino_type, "next": [
									{"type": storm_type, "weight": 20, "from": thunder_type, "next": [
										{"type": big_bomb_type, "weight": 5, "from": bomb_type, "next": []}
									]}
								]}
							]}
						]}	
					]},
				]}
			]},
			{"type": tower_type, "weight": 5, "next": [
				{"type": barrack_type, "weight": 4, "next": [
					{"type": mage_tower_type, "weight": 6, "from": tower_type, "next": [
						{"type": rino_type, "weight": 3, "from": barrack_type, "next": [
							{"type": necromancy_type, "weight": 6, "from": mage_tower_type, "next": [
								{"type": tank_type, "weight": 5, "from": rino_type, "next": [
									{"type": dark_type, "weight": 20, "from": necromancy_type, "next": [
										{"type": fire_tank_type, "weight": 5, "from": tank_type, "next": []}
									]}
								]}
							]}
						]}	
					]},
				]}
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
						{"type": tower_type, "weight": 5, "next": [
							{"type": catapult_type, "weight": 6, "from": tower_type, "next": [
								{"type": mech_mammoth_type, "weight": 40, "from": mammoth_type, "next": []}
							]},
						]},
					]}
				]}
			]},
			{"type": barrack_type, "weight": 4, "next": [
				{"type": rino_type, "weight": 3, "from": barrack_type, "next": [
					{"type": tank_type, "weight": 10, "from": rino_type, "next": []}
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
					{"type": flyer_type, "weight": 10, "from": rogue_type, "next": [
						{"type": barrack_type, "weight": 20, "next": [
							{"type": rogue_type, "weight": 20, "from": barrack_type, "next": [
								{"type": flyer_type, "weight": 20, "from": rogue_type, "next": [
									{"type": barrack_type, "weight": 20, "next": [
										{"type": rogue_type, "weight": 20, "from": barrack_type, "next": [
											{"type": flyer_type, "weight": 20, "from": rogue_type, "next": []}
										]}
									]},
									{"type": barrack_type, "weight": 20, "next": [
										{"type": rogue_type, "weight": 20, "from": barrack_type, "next": [
											{"type": flyer_type, "weight": 20, "from": rogue_type, "next": []}
										]}
									]},
									{"type": zeppelin_type, "from": flyer_type, "weight": 10, "next": []}
								]}
							]}
						]},
						{"type": air_bomber_type, "from": flyer_type, "weight": 10, "next": []}
					]}
				]}
			]},
			{"type": tower_type, "weight": 6, "next": [
				{"type": barrack_type, "weight": 4, "next": [
					{"type": rogue_type, "weight": 6, "from": barrack_type, "next": [
						{"type": ballista_type, "weight": 6, "from": tower_type, "next": [
							{"type": mage_type, "weight": 6, "from": rogue_type, "next": [
								{"type": machine_gun_type, "weight": 6, "from": ballista_type, "next": [
									{"type": fire_mage_type, "weight": 20, "from": rogue_type, "next": [
										{"type": heavy_machine_gun_type, "weight": 6, "from": machine_gun_type, "next": []}
									]}
								]}
							]}
						]}
					]},
				]},
			]},
			{"type": tower_type, "weight": 6, "next": [
				{"type": barrack_type, "weight": 4, "next": [
					{"type": rogue_type, "weight": 6, "from": barrack_type, "next": [
						{"type": ballista_type, "weight": 6, "from": tower_type, "next": [
							{"type": mage_type, "weight": 6, "from": rogue_type, "next": [
								{"type": machine_gun_type, "weight": 6, "from": ballista_type, "next": [
									{"type": air_mage_type, "weight": 20, "from": rogue_type, "next": [
										{"type": heavy_machine_gun_type, "weight": 6, "from": machine_gun_type, "next": []}
									]}
								]}
							]}
						]}
					]},
				]},
			]},
			{"type": tower_type, "weight": 6, "next": [
				{"type": barrack_type, "weight": 4, "next": [
					{"type": rogue_type, "weight": 6, "from": barrack_type, "next": [
						{"type": ballista_type, "weight": 6, "from": tower_type, "next": [
							{"type": mage_type, "weight": 6, "from": rogue_type, "next": [
								{"type": fire_tower_type, "weight": 6, "from": ballista_type, "next": [
									{"type": earth_mage_type, "weight": 20, "from": rogue_type, "next": [
										{"type": fire_wall_tower_type, "weight": 6, "from": machine_gun_type, "next": []}
									]}
								]}
							]}
						]}
					]},
				]},
			]},
			{"type": tower_type, "weight": 6, "next": [
				{"type": barrack_type, "weight": 4, "next": [
					{"type": knight_type, "weight": 6, "from": barrack_type, "next": [
						{"type": catapult_type, "weight": 6, "from": tower_type, "next": [
							{"type": shield_hall_type, "weight": 6, "from": knight_type, "next": [
								{"type": rocket_type, "weight": 20, "from": catapult_type, "next": [
									{"type": mirror_hall_type, "weight": 6, "from": shield_hall_type, "next": [
									]}
								]}
							]}
						]}
					]},
				]},
			]},
			{"type": tower_type, "weight": 6, "next": [
				{"type": barrack_type, "weight": 4, "next": [
					{"type": knight_type, "weight": 6, "from": barrack_type, "next": [
						{"type": catapult_type, "weight": 6, "from": tower_type, "next": [
							{"type": shield_hall_type, "weight": 6, "from": knight_type, "next": [
								{"type": rocket_type, "weight": 20, "from": catapult_type, "next": [
									{"type": mirror_hall_type, "weight": 6, "from": shield_hall_type, "next": [
									]}
								]}
							]}
						]}
					]},
				]},
			]},
			{"type": tower_type, "weight": 6, "next": [
				{"type": barrack_type, "weight": 4, "next": [
					{"type": knight_type, "weight": 6, "from": barrack_type, "next": [
						{"type": catapult_type, "weight": 6, "from": tower_type, "next": [
							{"type": keep_type, "weight": 6, "from": knight_type, "next": [
								{"type": listening_post_type, "weight": 20, "from": catapult_type, "next": [
									{"type": throne_type, "weight": 20, "from": keep_type, "next": []}
								]}
							]}
						]}
					]},
				]},
			]},
			{"type": tower_type, "weight": 6, "next": [
				{"type": barrack_type, "weight": 4, "next": [
					{"type": knight_type, "weight": 6, "from": barrack_type, "next": [
						{"type": catapult_type, "weight": 6, "from": tower_type, "next": [
							{"type": church_type, "weight": 6, "from": knight_type, "next": [
								{"type": buff_type, "weight": 6, "from": catapult_type, "next": [
									{"type": altar_type, "weight": 6, "from": church_type, "next": [
										{"type": big_buff_type, "weight": 6, "from": buff_type, "next": []}
									]}
								]}
							]}
						]}
					]},
				]},
			]},
		]}


func can_launch_war():
	for barrack in GridService.get_buildings_of_type(Tower.Type.barracks, true):
		if(barrack.count >= barrack.max_dudes):
			return true
	return false

func launch_war():
	for barrack in GridService.get_buildings_of_type(Tower.Type.barracks, true):
		if(barrack.count >= barrack.max_dudes / 2.0 and barrack.can_launch_war() and barrack.is_enemy):
			barrack.launch_war()
func get_building_count():
	return float(farm_count + tower_count + barrack_count)
	
var current_options = []
var next_option = ai_tree

func can_build(tower_info: TowerInfo):
	return ResourceManager.get_food(true) >= tower_info.food_cost * cost_reduction and ResourceManager.get_gold(true) >= tower_info.gold_cost * cost_reduction

func get_weight_name(type):
	if(Tower.Type.farm == type):
		return "farm_weight"
	elif(Tower.Type.barracks == type):
		return "barrack_weight"
	elif(Tower.Type.archery_tower == type):
		return "tower_weight"
		
	return "farm_weight"

func _on_TickTimer_timeout():
	if(not next_option):
		return
	
	if(can_build(next_option.type)):
		if(next_option.has("from")):
			attempt_upgrade(next_option)
		else:
			attempt_build(next_option.type)
		
		ResourceManager.remove_food(next_option.type.food_cost * cost_reduction, true)
		ResourceManager.remove_gold(next_option.type.gold_cost * cost_reduction, true)
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



func _on_LaunchWarTimer_timeout():
	if(can_launch_war()):
		launch_war()
		
