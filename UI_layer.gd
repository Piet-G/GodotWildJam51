extends CanvasLayer

var placing_building = false

func upgrade_clicked(tower):
	if($UI.in_war or placing_building):
		return
	var popup = preload("res://ui/upgrade_ui/TowerUpgradePopup.tscn").instance()
	
	$UI.add_child(popup)
	
	popup.show_upgrades_for(tower.tower_info)
	
