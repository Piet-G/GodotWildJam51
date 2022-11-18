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


func _on_Range_area_entered(area):
	if(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy):
		area.get_parent().discover()


func _on_Range_area_exited(area):
	if(area.is_in_group("dude_area") and area.get_parent().is_enemy != is_enemy):
		area.get_parent().discovered = false

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
