extends CanvasLayer

var placing_building = false



var upgrading_tower
func upgrade_clicked(tower):
	if($UI.in_war or placing_building):
		return
	
	Ui.open_upgrade(tower.tower_info)
	tower.set_selected(true)
	upgrading_tower = tower

func upgrade_selected(tower_info):
	if(is_instance_valid(upgrading_tower)):
		upgrading_tower.upgrade_to(tower_info)
		
	close_upgrade()

func win():
	$UI/WinScreen.visible = true
	get_tree().paused = true

func lose():
	$UI/GameOver.visible = true
	get_tree().paused = true
	
var upgrade_open = false
func open_upgrade(tower_info: TowerInfo):
	$UI/AnimationTree.set("parameters/UpgradeTimeScale/scale", 1)
	$UI/UpgradeUI.show_upgrades_for(tower_info)
	upgrade_open = true
	close_buy()

func close_upgrade():
	upgrade_open = false
	if(is_instance_valid(upgrading_tower)):
		upgrading_tower.set_selected(false)
	
	$UI/AnimationTree.set("parameters/UpgradeTimeScale/scale", -1)

func close_buy():
	$UI.open = -1
	$UI/AnimationTree.set("parameters/BuyTimeScale/scale", -1)

func _on_UpgradeUI_button_pressed():
	if(upgrade_open):
		close_upgrade()
	else:
		$UI/AnimationTree.set("parameters/UpgradeTimeScale/scale", 1)
		$UI/UpgradeUI.tower_info = null
		upgrade_open = true
