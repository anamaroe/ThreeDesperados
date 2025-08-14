extends Area2D

@onready var name_label = $"../Label"  

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))  
	input_event.connect(on_area_2d_input_event)

func on_area_2d_input_event(viewport, event, shape_idx): 
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		GameState.increment_clicks3() 
		# on se uvek pomami, osim ako imam rope n cloth
		print(GameState.currently_held_item_name_3)
		if GameState.currently_held_item_name_3 == "cup":
			# success 
			$"../../SheriffSleepy".visible = false
			$"../../Sheriff".visible = true 
			$"../../Cup2".visible = false 
			$"../../CupFallen".visible = true 
			
			GameState.sheriff_beaten = true 
			GameState.currently_held_item_name_3 = ""
			#name_label.text = "nothin'"
			$"../../CanvasLayer/Panel/item".text = "nothin'"
		else:
			print("tu sam")
			$"../../SheriffSleepy".visible = false
			$"../../SheriffAlerted".visible = true
			$"../../SheriffAlerted/Audio".play() 
			GameState.currently_held_item_name_3 = ""
			await get_tree().create_timer(2).timeout
			_on_sheriff_timeout()
			print("serif tajmoutovao")

func _on_sheriff_timeout():
	# game over
	print("menjam scenu")
	get_tree().change_scene_to_file("res://GameOver3/game_over.tscn")
	print("posle menjanja scene")
	return
			
func _on_mouse_entered():
	name_label.visible = true

func _on_mouse_exited():
	name_label.visible = false 
