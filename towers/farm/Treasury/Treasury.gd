extends "res://towers/tower.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func added_to_grid():
	.added_to_grid()
	
	ResourceManager.gold_bonus += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func destroy():
	ResourceManager.gold_bonus -= 1
