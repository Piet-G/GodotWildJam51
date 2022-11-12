extends GridContainer

func _ready():
	for info in TowerInfoService.tower_info_list:
		var tower_buy_button = preload("res://ui/buy_ui/tower_buy_button.tscn").instance()
		
		add_child(tower_buy_button)
		tower_buy_button.set_tower_info(info)
