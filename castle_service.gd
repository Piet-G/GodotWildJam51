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
	print(hp[is_enemy], damage_amount)
	hp[is_enemy] -= damage_amount
