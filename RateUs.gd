extends Control

func _on_RateUs_pressed():
	$Click.play()
	OS.shell_open("https://piet.itch.io/light-the-way")
