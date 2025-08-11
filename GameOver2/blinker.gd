extends Button

var blink_timer := 0.0
var blink_interval := 0.5

func _pressed(): 
	GameState.num_of_clicks_2 = 0
	get_tree().change_scene_to_file("res://Level2/level_2.tscn")

func _process(_delta):
	blink_timer += _delta
	if blink_timer >= blink_interval:
		blink_timer = 0
		visible = not visible
