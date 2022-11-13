extends PopupPanel

signal upgrade_selected(info)

func show_upgrades_for(tower_info: TowerInfo):
	$Control/TextureRect/TowerBuyButton.set_tower_info(tower_info)
	
	for child in $Control/Upgrades.get_children():
		child.visible = false
	
	for i in range(len(tower_info.next_upgrades)):
		var button: TextureButton = $Control/Upgrades.get_child(i).get_node("TowerBuyButton")
		button.get_parent().visible = true
		button.set_tower_info(tower_info.next_upgrades[i])
		button.connect("pressed", self, "_upgrade_pressed", [tower_info.next_upgrades[i]])

	popup_centered()

func _upgrade_pressed(tower_info):
	emit_signal("upgrade_selected", tower_info)
	queue_free()

func _on_Button_pressed():
	queue_free()
