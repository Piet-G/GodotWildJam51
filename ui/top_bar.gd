extends HBoxContainer

func _ready():
	ResourceManager.connect("food_added", self, "_on_food_added")
	ResourceManager.connect("food_removed", self, "_on_food_removed")
	
	_food_amount_changed()

func _food_amount_changed():
	$FoodCount.text = str(ResourceManager.food)
	
func _on_food_added(amount):
	_food_amount_changed()

func _on_food_removed(amount):
	_food_amount_changed()

func _process(delta):
	$GoldCount.text = str(ResourceManager.get_gold(false))
	_food_amount_changed()
