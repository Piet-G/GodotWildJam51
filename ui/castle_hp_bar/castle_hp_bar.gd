extends TextureProgress

export var is_enemy = false

func _process(delta):
	value = CastleService.get_hp_ratio(is_enemy)
