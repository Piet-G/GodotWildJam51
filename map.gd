extends Node2D

func _init():
	ResourceManager.food = 0
	ResourceManager.enemy_food = 0
	ResourceManager.gold = 0
	ResourceManager.enemy_gold = 0
	GridService.grid_map = {}
	GridService.enemy_info = {}
	GridService.illegal_spaces = {}
	GridService.roads = {}
	CastleService.hp = {true: 1, false: 100}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
