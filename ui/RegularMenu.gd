extends Panel


func _process(delta):
	if(Input.is_action_just_pressed("pause")):
		visible = !visible


func _on_ResumeButton_pressed():
	$Click.play()
	visible = false
	
func _on_BackButton_pressed():
	$Click.play()
	visible = false
	get_tree().change_scene("res://ui/MainMenu.tscn")

var previous_pause = false
func _on_RegularMenu_visibility_changed():
	if(visible):
		previous_pause = get_tree().paused
		get_tree().paused = true
	else:
		get_tree().paused = previous_pause
		
