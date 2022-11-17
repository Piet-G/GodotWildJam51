extends "res://towers/tower.gd"

export(String, FILE, "*.tscn") var unit_scene
export var max_dudes = 5

var to_war_count = 0
var closest_path: Path2D
var closest_distance = 100000000000000

func added_to_grid():
	.added_to_grid()
	
	$Timer.start()
	for path in get_tree().get_nodes_in_group("path"):
		if(path.is_enemy == is_enemy):
			var path_node: Path2D = path
			var local_pos = path_node.to_local($DudeSpawnLocation.global_position)
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
	
func set_invalid(value):
	.set_invalid(value)
	
	$Label.visible = value
var dudes = []
var count = 0
func _on_Timer_timeout():
	if(get_dude_count() < max_dudes):
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

func upgrade_to(tower_info: TowerInfo, is_enemy=false):
	free_dudes()
	.upgrade_to(tower_info, is_enemy)

func destroy():
	.destroy()
	
	free_dudes()

func free_dudes():
	while(get_dude_count() > 0):
		spawn_dude(rand_range(0, 20))

func spawn_dude(rando_offset):
	var dude = dudes.pop_front()
	if(not is_instance_valid(dude)):
		return
	$DudeSpawnLocation.remove_child(dude)
	closest_path.add_child(dude)
	dude.activate()
	var local_pos = closest_path.to_local(global_position)
	dude.offset = closest_path.curve.get_closest_offset(local_pos) + rando_offset
	
	if(len(dudes) <= 0):
		$WarTimer.stop()

func _on_WarTimer_timeout():
	spawn_dude(0)
	
