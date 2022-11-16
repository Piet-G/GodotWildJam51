extends Node

var max_hp = {
	true: 100,
	false: 100
}

var hp = {
	true: 100,
	false: 100
}

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
