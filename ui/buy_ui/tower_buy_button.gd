extends TextureButton

var tower_info: TowerInfo

func _process(delta):
	disabled = not (ResourceManager.food >= tower_info.food_cost and ResourceManager.gold >= tower_info.gold_cost)
	material.set_shader_param("grayscale", disabled)
	
func set_tower_info(info: TowerInfo):
	self.tower_info = info
	texture_normal = load(info.icon)

var popup
func _on_TowerBuyButton_mouse_entered():
	popup = preload("res://ui/tower_info_popup.tscn").instance()
	popup.rect_position += Vector2(100, 0)
	add_child(popup)
	popup.popup_for_tower(tower_info)

func _on_TowerBuyButton_mouse_exited():
	popup.queue_free()
