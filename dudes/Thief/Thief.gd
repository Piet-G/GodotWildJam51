extends "res://dudes/dude.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	sneak()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func stop_sneaking():
	print($Timer.get_time_left())
	if($Timer.get_time_left()>5.5):
		$SneakTimer.stop()
		$SneakTimer.wait_time = $Timer.get_time_left() - 5
		sneak()
	else:
		$SneakTimer.stop()
		$AnimatedSprite.modulate = Color(1,1,1,1)
		sneaking = false


func _on_Timer_timeout():
	$SneakTimer.wait_time = 5
	sneak()
