extends CanvasLayer

var labels = []
var current_index = 0
var all_labels_shown = false

func _ready():
	labels = [$Label1, $Label2, $Label3, $Label4] 
 
	for i in range(1, labels.size()):
		labels[i].visible = false

	$Timer.wait_time = 1.3 
	$Timer.start()
	
func _on_Timer_timeout():
	if current_index < labels.size() - 1:  
		current_index += 1
		labels[current_index].visible = true
		$Timer.start()   
	else:
		if not all_labels_shown:   
			all_labels_shown = true
			$Timer.wait_time = 1.8
			$Timer.start()
		else: 
			get_tree().change_scene_to_file("res://IntroSceneCharacters/intro_scene_characters.tscn")
