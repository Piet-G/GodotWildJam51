extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction: Vector2
var speed = 200
var is_enemy = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position += direction*delta*speed


func _on_Timer_timeout():
	if(direction.x != 0):
		var laser = preload("res://dudes/MechMammoth/LaserTrail_Horizontal.tscn").instance()
		get_parent().add_child(laser)
		laser.global_position = global_position
	else:
		var laser = preload("res://dudes/MechMammoth/LaserTrail_Vertical.tscn").instance()
		get_parent().add_child(laser)
		laser.global_position = global_position


func _on_Area2D_area_entered(area):
	if(area.is_in_group("Tower") and area.get_parent().is_enemy != is_enemy):
		area.get_parent().damage(5)


func _on_DeathTimer_timeout():
	queue_free()
