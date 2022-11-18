extends CanvasLayer

var placing_building = false

func _ready():
	randomize()

var upgrading_tower
func upgrade_clicked(tower):
	if(war_open or placing_building):
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
	close_to_war()

var war_open = false

func open_to_war():
	war_open = true
	$UI/AnimationTree.set("parameters/WarTimeScale/scale", 1)
	close_upgrade()
	close_buy()
	get_tree().paused = true
	to_war_barracks = []
	
	for node in get_tree().get_nodes_in_group("make_gray"):
		node.set_grayscale(true)
	
	for tower in get_tree().get_nodes_in_group("tower"):
		if(tower.is_in_group("barracks") and tower.get_dude_count() > 0 and not tower.is_enemy):
			to_war_barracks.append(tower)
			tower.set_selected(true)
			tower.connect("clicked", self, "_on_barracks_clicked", [tower])
		else:
			tower.set_grayscale(true)
	
func close_to_war():
	if(war_open):
		for node in get_tree().get_nodes_in_group("make_gray"):
			node.set_grayscale(false)
		for barrack in to_war_barracks:
			barrack.set_selected(false)
			to_war_barracks = []
		get_tree().paused = false
		for tower in get_tree().get_nodes_in_group("tower"):
			tower.set_grayscale(false)
			
	war_open = false
	$UI/AnimationTree.set("parameters/WarTimeScale/scale", -1)
	
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
		close_to_war()
		close_buy()


func _on_ToWarButton_pressed():
	for barrack in to_war_barracks:
		barrack.launch_war()
	close_to_war()

var to_war_barracks = []

func _on_barracks_clicked(barracks):
	if(barracks in to_war_barracks):
		barracks.set_selected(false)
		to_war_barracks.erase(barracks)
		return
	barracks.set_selected(true)
	to_war_barracks.append(barracks)

func _process(delta):
	$UI/ToWar/ToWarButton.disabled = to_war_barracks.empty()
	
	if(to_war_barracks.empty()):
		$UI/ToWar/ToWarButton.hint_tooltip = "No troops to attack with"
	else:
		$UI/ToWar/ToWarButton.hint_tooltip = ""
func _on_TextureRect_pressed():
	if(war_open):
		close_to_war()
	else:
		open_to_war()
