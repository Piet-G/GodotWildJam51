extends "res://dudes/Rhino/Rhino.gd"

var oilposition_right
var oilposition_left
var oil_position_up
var oil_position_down
export var fire = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	if(not is_enemy):
		oilposition_right = $Left_Top
		oilposition_left = $Right_Bottom
		oil_position_up = $Left_Top
		oil_position_down = $Right_Top
	else:
		oilposition_right = $Left_Top
		oilposition_left = $Right_Bottom
		oil_position_up = $Left_Bottom
		oil_position_down = $Right_Top

# Called when the node enters the scene tree for the first time.
func activate():
	.activate()
	$OilTimer.start()
	$TankSound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_OilTimer_timeout():
	var oil = preload("res://Effects/Oil/Oil.tscn").instance()
	oil.is_enemy = is_enemy
	get_parent().add_child(oil)
	if(current_facing == facing.NORMAL):
		if(right):
			oil.global_position = oilposition_right.global_position
		else:
			oil.global_position = oilposition_left.global_position
	elif(current_facing == facing.TOP):
		oil.global_position = oil_position_up.global_position
		oil.global_rotation = oil_position_up.global_rotation
	else:
		oil.global_position = oil_position_down.global_position
		oil.global_rotation = oil_position_down.global_rotation
	if(fire):
		oil.burn()
