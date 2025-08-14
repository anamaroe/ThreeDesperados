extends Button

var blink_timer := 0.0
var blink_interval := 0.5

@onready var label_txt = $"../Label"

func _ready():
	match GameState.current_lvl:
		1:
			GameState.num_of_clicks = 0 
			label_txt.text = "You woke up the sheriff!" 
		2:
			GameState.num_of_clicks_2 = 0 
			label_txt.text = "The Guard woke up\nand you got caught!" 
		3:
			GameState.num_of_clicks_3 = 0 
			label_txt.text = "The Sheriff woke up\nand you got caught!" 
		_:
			print("Game over scene called in wrong timeee") 

func _pressed():   
	get_tree().change_scene_to_file("res://LevelIntro/level_intro.tscn")

func _process(_delta):
	blink_timer += _delta
	if blink_timer >= blink_interval:
		blink_timer = 0
		visible = not visible
