extends Area2D

@onready var name_label = $"../Label"  
@onready var corn_area = $"/root/Level1/Corn/Area2D"
@onready var sprite = get_parent()   
 
var is_collected = false 

func _ready():
	corn_area.set_meta("can_hover", false)
	corn_area.set_meta("can_pick_up", false)
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))
	connect("input_event", Callable(self, "_on_input_event")) 

func _on_mouse_entered():
	if not is_collected:
		name_label.visible = true 

func _on_mouse_exited():
	name_label.visible = false

func _on_input_event(viewport, event, shape_idx):
	if is_collected:
		print("pile collected")
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#GameState.increment_clicks()
		start_fly_away_animation()

func start_fly_away_animation():
	is_collected = true
	set_process_input(false)
	name_label.visible = false
	 
	var viewport_size = get_viewport_rect().size
	var sprite_center = sprite.global_position
	var direction_to_corner
	 
	if sprite_center.x < viewport_size.x/2:
		direction_to_corner = Vector2(-1, -0.6)   
	else:
		direction_to_corner = Vector2(2, 0.6)  
	
	direction_to_corner = direction_to_corner.normalized()
	 
	var end_position = sprite.position + direction_to_corner * (viewport_size.length() * 1.5)
	var animation_duration = 0.5
	var rotation_speed = 720  
	var tween = create_tween()
	tween.set_parallel(false)
	 
	tween.tween_property(sprite, "position", sprite.position + Vector2(0, -40), 0.15)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	 
	tween.tween_property(sprite, "position", end_position, animation_duration)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	 
	var fly_tween = create_tween().set_parallel(true)
	fly_tween.tween_property(sprite, "rotation_degrees", sprite.rotation_degrees + rotation_speed, animation_duration)
	fly_tween.tween_property(sprite, "scale", sprite.scale * 0.5, animation_duration)
	fly_tween.tween_property(sprite, "modulate:a", 0.0, animation_duration * 0.8)
	 
	var flap_tween = create_tween().set_loops(3)
	flap_tween.tween_property(sprite, "scale:y", sprite.scale.y * 1.05, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	flap_tween.tween_property(sprite, "scale:y", sprite.scale.y * 0.95, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# corn label
	tween.tween_callback(func(): 
		corn_area.set_meta("can_hover", true)
		corn_area.set_meta("can_pick_up", true)
		queue_free()
	)
