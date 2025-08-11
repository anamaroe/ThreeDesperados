extends Label

var blink_timer := 0.0
var blink_interval := 0.5

func _process(_delta):
	blink_timer += _delta
	if blink_timer >= blink_interval:
		blink_timer = 0
		visible = not visible
