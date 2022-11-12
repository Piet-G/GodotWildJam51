extends Node

signal food_added(amount)
signal food_removed(amount)

var food = 0
var gold = 0

var enemy_food = 0
var enemy_gold = 0

func get_food(is_enemy):
	if(is_enemy):
		return enemy_food
	else:
		return gold
	
func get_gold(is_enemy):
	if(is_enemy):
		return enemy_gold
	else:
		return gold

func add_food(amount: int, is_enemy):
	food += amount
	
	emit_signal("food_added", amount)

func remove_food(amount: int, is_enemy):
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
