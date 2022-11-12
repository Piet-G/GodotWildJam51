tool
extends Node2D

export var farm_weight = 1
export var tower_weight = 1
export var barrack_weight = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	$GridContainer/FarmCount.text = str(farm_weight)
	$GridContainer/TowerCount.text = str(tower_weight)
	$GridContainer/BarCount.text = str(barrack_weight)

func _ready():
	if(Engine.editor_hint):
		return
	
	visible = false
	GridService.enemy_info[GridService.to_grid_position(global_position + Vector2(1,1))] = self
