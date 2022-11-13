extends "res://towers/tower.gd"

export(String, FILE, "*.tscn") var unit_scene

var to_war_count = 0
var closest_path: Path2D
var closest_distance = 100000000000000

func _ready():
	pass

func added_to_grid():
	for path in get_tree().get_nodes_in_group("path"):
		if(path.is_enemy == is_enemy):
			var path_node: Path2D = path
			var local_pos = path_node.to_local(global_position)
			var distance = path_node.curve.get_closest_point(local_pos).distance_to(local_pos)
			
			if(distance < closest_distance):
				closest_distance = distance
				closest_path = path_node

func _on_WarButton_pressed():
	launch_war()

func can_launch_war():
	return len(dudes) <= 0 or count > 0
	
func launch_war():
	count = 0
	$WarTimer.start()
	
	_count_updated()
	
var dudes = []
var count = 0
func _on_Timer_timeout():
	count += 1
	var dude = load(unit_scene).instance()
	dude.position = Vector2(randf(), randf()) * 10
	dude.is_enemy = is_enemy
	dudes.append(dude)
	$DudeSpawnLocation.add_child(dude)
	_count_updated()
	
func get_dude_count():
	return len(dudes)
func _count_updated():
	return

func _on_WarTimer_timeout():
	var dude = dudes.pop_front()
	if(not is_instance_valid(dude)):
		return
	$DudeSpawnLocation.remove_child(dude)
	closest_path.add_child(dude)
	var local_pos = closest_path.to_local(global_position)
	dude.offset = closest_path.curve.get_closest_offset(local_pos)
	
	if(len(dudes) <= 0):
		$WarTimer.stop()
	
