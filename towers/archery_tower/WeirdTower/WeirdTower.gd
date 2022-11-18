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

func create_chicken(dude):
	var chicken = preload("res://dudes/Chicken/Chicken.tscn").instance()
	chicken.is_enemy = dude.is_enemy
	
	dude.get_parent().add_child(chicken)
	chicken.offset = dude.offset
	
	chicken.activate()


func _on_Cooldown_timeout():
	for area in $Range.get_overlapping_areas():
		if(!area.is_in_group("air") and area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy and area.get_parent().is_active()):
			$Cooldown.start()
			create_chicken(area.get_parent())
			area.get_parent().queue_free()
			break
	
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
