extends Sprite2D

@onready var level_num_label = $Label 

func _ready():
	level_num_label.text = "Level " + str(GameState.current_lvl)
	GameState.reset_clicks()
	GameState.currently_held_item_name = ""
	var timer = get_tree().create_timer(1.4)
	timer.timeout.connect(_on_timeout)

func _on_timeout():
	if GameState.restarting_level == true: 
		GameState.restarting_level = false 
	match GameState.current_lvl:
		1: get_tree().change_scene_to_file("res://Level1/level_1.tscn")
		2: get_tree().change_scene_to_file("res://Level2/level_2.tscn")
		3: get_tree().change_scene_to_file("res://Level3/level_3.tscn")
		_: print("Intro scene called in wrong timeee") 
