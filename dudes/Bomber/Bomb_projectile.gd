extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ground = 0
export var speed = 180
var active = true

# Called when the node enters the scene tree for the first time.


func _process(delta):
	if(!active):
		return
	if(global_position.y >= ground):
		var explosion = preload("res://dudes/Bomber/ExplosionVerySmall.tscn").instance()
		add_child(explosion)
		active = false
	else:
		global_position.y += speed*delta
