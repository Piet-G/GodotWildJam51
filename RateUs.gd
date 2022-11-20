extends Control

func _on_RateUs_pressed():
	$Click.play()
	OS.shell_open("https://itch.io/jam/godot-wild-jam-51/rate/1799987")
