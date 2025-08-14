extends Area2D

@onready var name_label = $"../Label"  

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))  
	input_event.connect(on_area_2d_input_event)

func on_area_2d_input_event(viewport, event, shape_idx): 
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		GameState.increment_clicks2() 
		# on se uvek pomami, osim ako imam rope n cloth
		print(GameState.currently_held_item_name_2)
		if GameState.currently_held_item_name_2 == "rope n' cloth":
			# success
			# zavezi ga 
			$"../../Guard".visible = false
			$"../../GuardLeft".visible = true
			$"../../RopeNCloth".visible = false  
			GameState.guard_beaten = true 
			GameState.currently_held_item_name_2 = ""
		else:
			$"../../GuardAlerted".visible = true
			$"../../Guard".visible = false
			$"../../GuardAlerted/Audio".play() 
			GameState.currently_held_item_name_2 = ""
			await get_tree().create_timer(2.1).timeout
			_on_guard_timeout()

func _on_guard_timeout():
	# game over
	GameState.restarting_level = true
	GameState.current_lvl = 2
	get_tree().change_scene_to_file("res://GameOver/game_over.tscn")
	return
			
func _on_mouse_entered():
	name_label.visible = true

func _on_mouse_exited():
	name_label.visible = false 
