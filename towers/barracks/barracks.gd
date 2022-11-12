extends "res://towers/tower.gd"

onready var progress = $HBoxContainer/TextureProgress
onready var count_label = $HBoxContainer/VBoxContainer/CountLabel

var to_war_count = 0
var closest_path: Path2D
var closest_distance = 100000000000000

func _ready():
	for path in get_tree().get_nodes_in_group("path"):
		var path_node: Path2D = path
		var local_pos = path_node.to_local(global_position)
		var distance = path_node.curve.get_closest_point(local_pos).distance_to(local_pos)
		
		if(distance < closest_distance):
			closest_distance = distance
			closest_path = path_node

func _on_WarButton_pressed():
	to_war_count = count
	count = 0
	$WarTimer.start()
	
	_count_updated()

func _process(delta):
	progress.value = $Timer.time_left / $Timer.wait_time
	$HBoxContainer/VBoxContainer/WarButton.disabled = to_war_count != 0

var count = 0
func _on_Timer_timeout():
	count += 1
	_count_updated()
	
func _count_updated():
	count_label.text = str(count)

func _on_WarTimer_timeout():
	to_war_count -= 1
	
	var dude = preload("res://dudes/dude.tscn").instance()
	var local_pos = closest_path.to_local(global_position)
	dude.offset = closest_path.curve.get_closest_offset(local_pos)
	closest_path.add_child(dude)
	
	if(to_war_count <= 0):
		$WarTimer.stop()
	
