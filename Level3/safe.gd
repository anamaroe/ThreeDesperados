extends Area2D

@onready var name_label = $"../Label"   
@export var item_name = "safe"  

@export var is_on_scene = true     
var original_position

signal item_picked_up(item_name)
signal item_dropped()

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))  
	input_event.connect(on_area_2d_input_event)
	name_label.visible = false
	original_position = global_position
	input_event.connect(on_area_2d_input_event) 
	 
func on_area_2d_input_event(viewport, event, shape_idx): 
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		GameState.increment_clicks3() 
		if is_on_scene:
			pick_up()
		else:
			drop()
			
func _on_mouse_entered():
	name_label.visible = true

func _on_mouse_exited():
	name_label.visible = false 

func pick_up():
	if is_on_scene:
		is_on_scene = false 
		name_label.visible = false  
		emit_signal("item_picked_up", item_name)
		if GameState.sheriff_beaten:
			GameState.currently_held_item_name = "gold"
			$"../../CanvasLayer/Panel/item".text = "gold"
			var timer = get_tree().create_timer(0.7) 
			timer.timeout.connect(_on_timeout)
		else:
			# pomami se
			$"../../SheriffSleepy".visible = false
			$"../../SheriffAlerted".visible = true
			$"../../SheriffAlerted/Audio".play()
			var timer = get_tree().create_timer(2.1)
			timer.timeout.connect(_on_sheriff_timeout)

func _on_sheriff_timeout():
	get_tree().change_scene_to_file("res://GameOver3/game_over.tscn")
	return
	
func _on_timeout():
	# change scene - next lvl 
	$"../../Completed/Panel".visible = true
	var timer = get_tree().create_timer(1.6) 
	timer.timeout.connect(_on_timeout_continue) 

func _on_timeout_continue():
	get_tree().change_scene_to_file("res://Outro/outro.tscn")
	return

func drop():
	if not is_on_scene:
		is_on_scene = true 
		name_label.visible = true 
		get_parent().global_position = original_position 
		emit_signal("item_dropped")
