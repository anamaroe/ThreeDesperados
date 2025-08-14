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
		#sta trenutno drzim u ruci; ako je corn onda pobedaaa; else loss
		print(GameState.currently_held_item_name)
		if GameState.currently_held_item_name == "corn":
			# success
			$"../../RoosterIdle".visible = false
			$"../../Corn".visible = false
			$"../../RoosterEating".visible = true 
			$"../../RoosterEating/Corn".visible = true 
			GameState.chick_fed = true
			var timer = get_tree().create_timer(1.1) 
			timer.timeout.connect(_on_timeout)
		elif GameState.currently_held_item_name == "chilli":
			# burned
			if GameState.chick_fed == true:
				return
			$"../../RoosterIdle".visible = false
			$"../../Corn".visible = false
			$"../../Chilli".visible = false  
			$"../../Screamo".visible = true  
			$"../../Screamo/Chilli".visible = true  
			$"../../Screamo/Fire".visible = true  
			var timer = get_tree().create_timer(1.1) 
			timer.timeout.connect(_on_rooster_timeout)
		else: 
			# too many clicks
			if GameState.chick_fed == true:
				return
			print("kliknut rooster")
			$"../../RoosterIdle".visible = false
			$"../../Screamo".visible = true 
			$"../../Screamo/Fire".visible = false 
			$"../../Screamo/Chilli".visible = false
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

func _on_timeout():
	# change scene - next lvl 
	$"../../CanvasLayer/PanelCompleted".visible = true
	var timer = get_tree().create_timer(1.7) 
	timer.timeout.connect(_on_timeout_continue) 

func _on_timeout_continue():
	get_tree().change_scene_to_file("res://Level2Intro/level_2_intro.tscn")
	return
