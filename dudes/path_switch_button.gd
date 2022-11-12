extends Sprite

export var active_path = 0

func _process(delta):
	if(get_parent().is_path_active(active_path)):
		texture = preload("res://assets/UI/arrow_active.png")
	else:
		texture = preload("res://assets/UI/arrow_non_active.png")

func _on_Area2D_input_event(viewport, event, shape_idx):
	if(event.is_action_pressed("select_path")):
		get_parent().togle_path_active(active_path)
