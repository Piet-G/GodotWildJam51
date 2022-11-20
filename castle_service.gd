extends Node

var max_hp = {
	true: 50,
	false: 50
}

var hp = {
	true: 100,
	false: 100
}

var difficulty = 1

func get_max_hp(is_enemy):
	return max_hp[is_enemy]

func get_hp_ratio(is_enemy):
	return hp[is_enemy] / float(get_max_hp(is_enemy))

func damage(damage_amount, is_enemy):
	hp[is_enemy] -= damage_amount
	
	if(hp[is_enemy] <= 0):
		if(is_enemy):
			Ui.win()
		else:
			Ui.lose()
	
	ResourceManager.add_gold(5, not is_enemy)

func repair(repair_amount, is_enemy):
	if(hp[is_enemy] + repair_amount <= max_hp[is_enemy]):
		hp[is_enemy] += repair_amount

func set_difficulty(number):
	difficulty = number
