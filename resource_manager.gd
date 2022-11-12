extends Node

signal food_added(amount)
signal food_removed(amount)

var food = 0
func add_food(amount: int):
	food += amount
	
	emit_signal("food_added", amount)

func remove_food(amount: int):
	food -= amount
	
	emit_signal("food_removed", amount)
	

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
