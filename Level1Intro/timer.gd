extends Sprite2D

func _process(_delta):
	var timer = get_tree().create_timer(1.4)
	timer.timeout.connect(_on_timeout)

func _on_timeout():
	get_tree().change_scene_to_file("res://Level1/level_1.tscn")
	return 
