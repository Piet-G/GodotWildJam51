extends Panel


func _process(delta):
	if(Input.is_action_just_pressed("pause")):
		visible = !visible


func _on_ResumeButton_pressed():
	visible = false
	
func _on_BackButton_pressed():
	visible = false
	get_tree().change_scene("res://ui/MainMenu.tscn")
