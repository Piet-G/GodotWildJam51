extends PopupPanel

func show_upgrades_for(tower_info: TowerInfo):
	$Control/TextureRect/TowerBuyButton.set_tower_info(tower_info)
	
	for i in range(len(tower_info.next_upgrades)):
		var button: TextureButton = get_node("Control/Upgrade" + str(i) + "/TowerBuyButton")
		
		button.set_tower_info(tower_info.next_upgrades[i])

	popup_centered()


func _on_Button_pressed():
	queue_free()
