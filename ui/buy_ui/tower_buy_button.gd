extends TextureButton

var tower_info: TowerInfo

func _process(delta):
	disabled = not (ResourceManager.food >= tower_info.food_cost and ResourceManager.gold >= tower_info.gold_cost)

func set_tower_info(info: TowerInfo):
	self.tower_info = info
	$NameLabel.text = info.name
	texture_normal = load(info.icon)
	$VBoxContainer/Food/FoodCount.text = str(info.food_cost)
	$VBoxContainer/Gold/GoldCount.text = str(info.gold_cost)
