extends Area2D

@onready var name_label = $"../Label"   
@export var item_name = "key"  

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
		GameState.increment_clicks2() 
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
		get_parent().global_position.y -= 50
		emit_signal("item_picked_up", item_name)
		if GameState.guard_beaten:
			var timer = get_tree().create_timer(1.1) 
			timer.timeout.connect(_on_timeout)
		else:
			# pomami se
			$"../../Guard".visible = false
			$"../../GuardAlerted".visible = true
			$"../../GuardAlerted/Audio".play()
			var timer = get_tree().create_timer(2.1)
			timer.timeout.connect(_on_guard_timeout)

func _on_guard_timeout():
	GameState.restarting_level = true
	GameState.current_lvl = 2
	get_tree().change_scene_to_file("res://GameOver/game_over.tscn")
	return
			
func _on_timeout():
	# change scene - next lvl 
	$"../../CanvasLayer/Completed".visible = true
	var timer = get_tree().create_timer(1.7) 
	timer.timeout.connect(_on_timeout_continue) 

func _on_timeout_continue():
	# changed
	GameState.current_lvl = 3
	get_tree().change_scene_to_file("res://LevelIntro/level_intro.tscn")
	return

func drop():
	if not is_on_scene:
		is_on_scene = true 
		name_label.visible = true 
		get_parent().global_position = original_position 
		emit_signal("item_dropped")
