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
	
	if(open == 1):
		$SlideIn.play()
		get_parent().close_to_war()
		get_parent().close_upgrade()
	else:
		$SlideOut.play()
	$AnimationTree.set("parameters/BuyTimeScale/scale", open)
