extends Area2D

@onready var label = $"../Label"   
@export var item_name = "chilli" 

@export var is_on_scene = true     
var original_position

signal item_picked_up(item_name)
signal item_dropped()

func _ready():
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	label.visible = false
	original_position = global_position
	input_event.connect(on_area_2d_input_event)
	
func _on_mouse_entered():
	label.visible = true

func _on_mouse_exited():
	label.visible = false 
	
func on_area_2d_input_event(viewport, event, shape_idx): 
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		GameState.increment_clicks()
		if is_on_scene:
			pick_up()
		else:
			drop()

func pick_up():
	if is_on_scene:
		is_on_scene = false 
		label.visible = false 
		get_parent().global_position.y -= 50
		emit_signal("item_picked_up", item_name)

func drop():
	if not is_on_scene:
		is_on_scene = true 
		label.visible = true 
		get_parent().global_position = original_position 
		emit_signal("item_dropped")
