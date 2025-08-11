extends Area2D

@onready var name_label = $"../Label"  

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))  
	input_event.connect(on_area_2d_input_event)

func _on_mouse_entered():
	name_label.visible = true

func _on_mouse_exited():
	name_label.visible = false 

func on_area_2d_input_event(viewport, event, shape_idx):  
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		GameState.increment_clicks()
		# if the rooster is idle it will scream
		if $"../../RoosterIdle".visible == true:
			$"../../RoosterIdle".visible = false
			$"../../Screamo".visible = true 
			var timer = get_tree().create_timer(1.1) 
			timer.timeout.connect(_on_rooster_timeout)
	  
func _on_rooster_timeout():
	$"../../Sheriff".visible = true
	$"../../Sheriff/Audio".play()
	var timer = get_tree().create_timer(2.1)
	timer.timeout.connect(_on_sheriff_timeout)

func _on_sheriff_timeout():
	get_tree().change_scene_to_file("res://GameOver/game_over.tscn")
	return 
