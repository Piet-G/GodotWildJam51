extends "res://towers/tower.gd"

export var arrow_damage = 1
export var air = false

func _ready():
	damage = arrow_damage

func _on_ShootTimer_timeout():
	if(not is_active()):
		return
		
	for area in $Range.get_overlapping_areas():
		if((air && area.is_in_group("air")) || (!air && !area.is_in_group("air"))):
			if(area.is_in_group("dude_area") and not area.get_parent().targeted and area.get_parent().is_enemy != is_enemy and area.get_parent().is_active() and !area.get_parent().sneaking):
				shoot_at(area.get_parent())
				return

func shoot_at(dude: Node2D):
	var arrow = preload("res://towers/archery_tower/arrow.tscn").instance()
	arrow.is_enemy = is_enemy
	arrow.origin = self
	$Fire.play()
	
	$ArrowPosition.add_child(arrow)
	arrow.set_target(dude)
	if(dude.health <= arrow_damage):
		dude.targeted = true

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
