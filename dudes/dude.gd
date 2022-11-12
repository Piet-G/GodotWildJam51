extends PathFollow2D

export var movement_speed = 30

func _physics_process(delta):
	offset += movement_speed * delta
