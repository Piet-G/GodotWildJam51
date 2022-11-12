extends Label

func _ready():
	var animation_length = 30
	$Tween.targeting_property(self, "rect_position", self, "rect_position", rect_position - Vector2(0, 30), animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.targeting_property(self, "modulate:a", self, "modulate:a", 0, animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.5)
	$Tween.start()
