extends Tower


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Range_area_entered(area):
	if(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy):
		create_chicken(area.get_parent())
		area.get_parent().queue_free()

func create_chicken(dude):
	var chicken = preload("res://dudes/Chicken/Chicken.tscn").instance()
	chicken.is_enemy = dude.is_enemy
	
	var closest_distance = 100000000000000
	var closest_path: Path2D
	
	for path in get_tree().get_nodes_in_group("path"):
		if(path.is_enemy == dude.is_enemy):
			var path_node: Path2D = path
			var local_pos = path_node.to_local(dude.global_position)
			var distance = path_node.curve.get_closest_point(local_pos).distance_to(local_pos)
			
			if(distance < closest_distance):
				closest_distance = distance
				closest_path = path_node
	
	closest_path.add_child(chicken)
	var local_pos = closest_path.to_local(dude.global_position)
	chicken.offset = closest_path.curve.get_closest_offset(local_pos)
