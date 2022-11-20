extends AnimatedSprite

export(SpriteFrames) var red_no_animation
export(SpriteFrames) var blue_no_animation
export(SpriteFrames) var red_animation
export(SpriteFrames) var blue_animation

export var is_enemy = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

var on_fire = false

func _ready():
	show_not_animating()
	
func show_not_animating():
	on_fire = false
	if(is_enemy):
		frames = red_no_animation
	else:
		frames = blue_no_animation

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_grayscale(value):
	material.set_shader_param("grayscale", value)
	

func set_on_fire():
	on_fire = true
	$Burn.play()
	$Coin.play()
	
	if(is_enemy):
		add_child(preload("res://ui/FoodAddedLabel.tscn").instance())
	
	ResourceManager.add_gold(3, not is_enemy)
	if(is_enemy):
		frames = red_animation
	else:
		frames = blue_animation
	
	$Timer.start()

func _on_Area2D_area_entered(area):
	var dude = area.get_parent()
	if(area.is_in_group("dude_area") and dude.is_in_group("dude") and is_enemy != dude.is_enemy and not on_fire):
		set_on_fire()
		


func _on_Timer_timeout():
	$Burn.stop()
	show_not_animating()
