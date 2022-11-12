extends GridContainer

var tower_ghost
var clicked_info: TowerInfo

func _ready():
	for info in TowerInfoService.tower_info_list:
		var tower_buy_button = preload("res://ui/buy_ui/tower_buy_button.tscn").instance()
		
		add_child(tower_buy_button)
		tower_buy_button.set_tower_info(info)
		tower_buy_button.connect("pressed", self, "_on_buy_tower_clicked", [info])

func _on_buy_tower_clicked(info: TowerInfo) -> void:
	tower_ghost = load(info.scene).instance()
	clicked_info = info
	add_child(tower_ghost)

func _process(delta):
	if(tower_ghost):
		tower_ghost.global_position = get_viewport().get_mouse_position()
		
		if(Input.is_action_just_pressed("place_tower")):
			tower_ghost = null
			ResourceManager.remove_food(clicked_info.food_cost)
