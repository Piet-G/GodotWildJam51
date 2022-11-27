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

func cast():
	if($Timer.is_stopped()):
		$Timer.start()
		return true
	else:
		return false

func show_range(value):
	$RangeSprite.visible = value

func _process(delta):
	if(not active):
		show_range(true)

func added_to_grid():
	.added_to_grid()
	
	show_range(false)

func set_selected(value):
	.set_selected(value)
	show_range(value)
