extends Panel

@onready var name_label = $Label   
@onready var text_label = $Label2   
@onready var portrait = $TextureRect

@onready var continue_button = $Button

var dialogues = [
	{"name": "Angel Eyes", "text": "Alright, desperados.\nWe hit em tonight.", "image": preload("res://characters/black.png")},
	{"name": "Angel Eyes", "text": "The sheriff's holdin enough\ngold to set us for life.", "image": preload("res://characters/black.png")},
	{"name": "Tuco", "text": "When the moon is high, no one\nwill see us comin.", "image": preload("res://characters/dark brown left.png")},
	{"name": "Man with no Name", "text": "But remember... We only got 3\nmoves in each room.", "image": preload("res://characters/light brown left.png")},
	{"name": "Tuco", "text": "3 moves, no more. Else the guard\nand sheriff wake up.", "image": preload("res://characters/dark brown left.png")},
	{"name": "Angel Eyes", "text": "And once they're up, we're\ndone for.", "image": preload("res://characters/black.png")},
	{"name": "Man with no Name", "text": "Then it's settled.\nWe strike at midnight.", "image": preload("res://characters/light brown left.png")}
]

var current_index = 0
var typing_speed := 0.03
var typing_timer := Timer.new()
var current_text := ""
var char_index := 0
  
func _ready():
	add_child(typing_timer)
	typing_timer.timeout.connect(_on_typing_timer_timeout)
	show_dialogue(current_index)

func show_dialogue(index):
	if index >= dialogues.size():
		queue_free() 
		get_tree().change_scene_to_file("res://ReadyToPlay/ready_to_play.tscn")
		return
		
	var d = dialogues[index]
	name_label.text = d["name"]
	portrait.texture = d["image"]
	
	current_text = d["text"]
	char_index = 0
	text_label.text = ""
	
	typing_timer.start(typing_speed)

func _on_typing_timer_timeout():
	if char_index < current_text.length():
		text_label.text += current_text[char_index]
		char_index += 1
	else:
		typing_timer.stop()
		await get_tree().create_timer(2.0).timeout   
		current_index += 1
		show_dialogue(current_index)
 
