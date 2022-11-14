extends Node

func _process(delta):
	for node in get_tree().get_nodes_in_group("zindexed"):

		var z = int(node.global_position.y)
		node.z_as_relative = false
		if(node.has_method("get_z_position")):
			z = int(node.get_z_position())

		node.z_index = z
