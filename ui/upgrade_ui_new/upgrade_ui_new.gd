extends NinePatchRect

var tower_info

signal button_pressed()

func show_upgrades_for(tower_info: TowerInfo):
	self.tower_info = tower_info
	
	$TextureRect/TowerBuyButton.set_tower_info(tower_info)
	
	for child in $Upgrades.get_children():
		child.visible = false
		child.get_node("TowerBuyButton").disconnect("pressed", Ui, "upgrade_selected")
	
	for i in range(len(tower_info.next_upgrades)):
		var button: TextureButton = $Upgrades.get_child(i).get_node("TowerBuyButton")
		button.get_parent().visible = true
		button.set_tower_info(tower_info.next_upgrades[i])
		button.connect("pressed", Ui, "upgrade_selected", [tower_info.next_upgrades[i]])
	
	$TextureButton.show_behind_parent
	
func _process(delta):
	if(tower_info):
		$TextureRect.visible = true
		$Upgrades.visible = true
		$Label.visible = false
	else:
		$TextureRect.visible = false
		$Upgrades.visible = false
		$Label.visible = true
		
func _on_TextureButton_pressed():
	emit_signal("button_pressed")
	
