extends NinePatchRect

var tower_ghost
var clicked_info: TowerInfo

signal open_toggled()

func _ready():
	for info in TowerInfoService.tower_info_list:
		var tower_buy_button = preload("res://ui/buy_ui/tower_buy_button.tscn").instance()
		
		var tower_button_panel = preload("res://ui/buy_ui/tower_buy_panel.tscn").instance()
		tower_button_panel.add_child(tower_buy_button)
		
		$TowerBuyUI.add_child(tower_button_panel)
		tower_buy_button.set_tower_info(info)
		tower_buy_button.connect("pressed", self, "_on_buy_tower_clicked", [info])

func _on_buy_tower_clicked(info: TowerInfo) -> void:
	if(not Ui.placing_building):
		tower_ghost = load(info.scene).instance()
		tower_ghost.set_invalid(true)
		clicked_info = info
		get_tree().current_scene.add_child(tower_ghost)
		Ui.placing_building = true
	
func check_if_next_to_road(position):
	if(not tower_ghost.type == Tower.Type.barracks):
		return true
	var positions = [position + Vector2(1,0), position - Vector2(1,0), position + Vector2(0,1), position - Vector2(0,1)]
	
	for pos in positions:
		if(GridService.has_road(pos.floor())):
			return true
	
	return false

func _process(delta):
	if(is_instance_valid(tower_ghost)):
		tower_ghost.global_position = GridService.snap_to_grid_position(get_viewport().get_mouse_position())
		
		var grid_position = GridService.to_grid_position(tower_ghost.global_position)
		tower_ghost.set_invalid(GridService.is_grid_position_occupied_for_player(grid_position) or not check_if_next_to_road(grid_position))
		tower_ghost.z_index = 3000
		if((Input.is_action_just_pressed("place_tower") or Input.is_action_just_released("place_tower")) and not GridService.is_grid_position_occupied_for_player(grid_position) and check_if_next_to_road(grid_position)):
			tower_ghost.set_invalid(false)
			GridService.add_to_grid(tower_ghost,grid_position)
			tower_ghost = null
			Ui.placing_building = false
			ResourceManager.remove_food(clicked_info.food_cost, false)


func _on_ToggleButton_pressed():
	emit_signal("open_toggled")
	
	if(Ui.placing_building):
		if(is_instance_valid(tower_ghost)):
			tower_ghost.queue_free()
			tower_ghost = null
		Ui.placing_building = false


