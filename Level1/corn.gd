extends Area2D

@onready var corn_label = $"Label"   
@export var item_name = "corn" 

signal item_picked_up()
signal item_dropped()

@export var is_on_scene = true     
var original_position
 
func _ready(): 
	corn_label.visible = false
	original_position = global_position
	input_event.connect(on_area_2d_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
func on_area_2d_input_event(viewport, event, shape_idx): 
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		GameState.increment_clicks()
		if is_on_scene:
			pick_up()
		else:
			drop()

func pick_up():
	if is_on_scene and get_meta("can_pick_up") == true:
		is_on_scene = false 
		corn_label.visible = false 
		set_meta("item_name", "corn")
		get_parent().global_position.y -= 50
		emit_signal("item_picked_up", item_name)

func drop():
	if not is_on_scene:
		is_on_scene = true 
		corn_label.visible = true 
		set_meta("item_name", "")
		get_parent().global_position = original_position 
		emit_signal("item_dropped") 

func _on_mouse_entered():
	if has_meta("can_hover"):
		if get_meta("can_hover") == true:
			corn_label.visible = true

func _on_mouse_exited():
	if has_meta("can_hover"):
		if get_meta("can_hover") == true:
			corn_label.visible = false
