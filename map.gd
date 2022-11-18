extends Node2D

var old_hp_blue = 100
var old_hp_red = 100

func _init():
	ResourceManager.food = 0
	ResourceManager.enemy_food = 0
	ResourceManager.gold = 0
	ResourceManager.enemy_gold = 0
	GridService.grid_map = {}
	GridService.enemy_info = {}
	GridService.illegal_spaces = {}
	GridService.roads = {}
	CastleService.hp = {true: 100, false: 100}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if CastleService.hp[false] < old_hp_blue:
		$AnimationPlayer.play("BlueHit")
	elif CastleService.hp[false] > old_hp_blue:
		$AnimationPlayer.play("BlueRepair")
	
	old_hp_blue = CastleService.hp[false]
	
	if CastleService.hp[true] < old_hp_red:
		$AnimationPlayer2.play("RedHit")
	elif CastleService.hp[true] > old_hp_red:
		$AnimationPlayer2.play("RedRepair")
	
	old_hp_red = CastleService.hp[true]
