extends TextureRect

func popup_for_tower(tower_info: TowerInfo):
	if !tower_info:
		return
	$TextureButton.texture_normal = load(tower_info.icon)
	$NameLabel.text = tower_info.name
	$FoodCost.text = str(tower_info.food_cost)
	$GoldCost.text = str(tower_info.gold_cost)
	$RichTextLabel.text = str(tower_info.flavour_text)
