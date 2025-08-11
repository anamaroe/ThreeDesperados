extends Sprite2D 

var timer_started = false

func _process(_delta): 
	if not timer_started:
		timer_started = true
		var timer = get_tree().create_timer(1.4)
		timer.timeout.connect(_on_timeout)

func _on_timeout():
	GameState.guard_beaten = false
	get_tree().change_scene_to_file("res://Level2/level_2.tscn")
	return
