extends CanvasLayer

var placing_building = false

var upgrading_tower
func upgrade_clicked(tower):
	if($UI.in_war or placing_building):
		return
	var popup = preload("res://ui/upgrade_ui/TowerUpgradePopup.tscn").instance()
	
	$UI.add_child(popup)
	
	popup.connect("upgrade_selected", self, "_upgrade_selected")
	popup.show_upgrades_for(tower.tower_info)
	upgrading_tower = tower

func _upgrade_selected(tower_info):
	upgrading_tower.upgrade_to(tower_info)

func win():
	$UI/WinScreen.visible = true
	get_tree().paused = true

func lose():
	$UI/GameOver.visible = true
	get_tree().paused = true
