extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var open = -1
func _on_TowerBuyUI_open_toggled():
	open = -1 * open
	$AnimationTree.set("parameters/BuyTimeScale/scale", open)
	print($AnimationTree.get("parameters/BuyTimeScale/scale"))

func _on_ToWarButton_pressed():
	if(in_war):
		for barrack in to_war_barracks:
			barrack.launch_war()
		stop_war_mode()
	else:
		get_tree().paused = true
		$VBoxContainer/CancelWar.visible = true
		in_war = true
		to_war_barracks = []
		for tower in get_tree().get_nodes_in_group("tower"):
			if(tower.is_in_group("barracks") and tower.get_dude_count() > 0 and not tower.is_enemy):
				tower.connect("clicked", self, "_on_barracks_clicked", [tower])
			else:
				tower.set_grayscale(true)

var in_war = false
var to_war_barracks = []

func _on_barracks_clicked(barracks):
	if(barracks in to_war_barracks):
		barracks.set_selected(false)
		return
	barracks.set_selected(true)
	to_war_barracks.append(barracks)

func stop_war_mode():
	$VBoxContainer/CancelWar.visible = false
	in_war = false
	for barrack in to_war_barracks:
		barrack.set_selected(false)
	to_war_barracks = []
	get_tree().paused = false
	for tower in get_tree().get_nodes_in_group("tower"):
		tower.set_grayscale(false)	

func _on_CancelWar_pressed():
	stop_war_mode()
