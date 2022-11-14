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
	upgrading_tower.upgrade_to(tower_info)
	close_upgrade()

func win():
	$UI/WinScreen.visible = true
	get_tree().paused = true

func lose():
	$UI/GameOver.visible = true
	get_tree().paused = true
	
func open_upgrade(tower_info: TowerInfo):
	$UI/AnimationTree.set("parameters/UpgradeTimeScale/scale", 1)
	$UI/UpgradeUI.show_upgrades_for(tower_info)
	close_buy()

func close_upgrade():
	if(is_instance_valid(upgrading_tower)):
		upgrading_tower.set_selected(false)
	
	$UI/AnimationTree.set("parameters/UpgradeTimeScale/scale", -1)

func close_buy():
	$UI/AnimationTree.set("parameters/BuyTimeScale/scale", -1)
