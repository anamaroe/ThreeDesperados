extends Node

var num_of_clicks: int = 0
var currently_held_item_name: String = ""
var chick_fed = false

# lvl 2
var num_of_clicks_2: int = 0
var guard_beaten = false
var currently_held_item_name_2: String = ""

# lvl 3
var num_of_clicks_3: int = 0
var safe_opened = false
var sheriff_beaten = false
var currently_held_item_name_3: String = ""

# both
func _ready():
	num_of_clicks = 0
	currently_held_item_name = ""
	chick_fed = false 
	
	num_of_clicks_2 = 0
	currently_held_item_name_2 = ""
	guard_beaten = false
	
	num_of_clicks_3 = 0
	currently_held_item_name_3 = ""
	safe_opened = false
	
func get_clicks_label():
	if get_tree().current_scene and get_tree().current_scene.has_node("CanvasLayer/Panel/clicks_num"):
		return get_tree().current_scene.get_node("CanvasLayer/Panel/clicks_num") 
	return null
	
# first
func increment_clicks():
	if num_of_clicks + 1 == 4: 
		if GameState.chick_fed == true:
				return 
		var label = get_clicks_label() 
		if label: 
			label.text = "too\nmany"
		currently_held_item_name = ""
		chick_fed = false  
		await get_tree().create_timer(1.0).timeout
		_on_clicked_timeout()
	else:
		num_of_clicks += 1
		update_click_label()

func _on_clicked_timeout():
	$"../Level1/Sheriff".visible = true
	$"../Level1/Sheriff/Audio".play() 
	await get_tree().create_timer(2.1).timeout
	_on_sheriff_timeout()

func _on_sheriff_timeout():
	# game over
	get_tree().change_scene_to_file("res://GameOver/game_over.tscn")
	return

func reset_clicks():
	num_of_clicks = 0
	update_click_label()
	
func update_click_label():
	print("update click label") 
	var label = get_clicks_label()
	if label:
		label.text = str(num_of_clicks)
		print("clicks updated to ", num_of_clicks)
 
# level 2
func increment_clicks2():
	if num_of_clicks_2 + 1 == 4: 
		if GameState.guard_beaten == true:
				return 
		var label = get_clicks_label() 
		if label: 
			label.text = "too\nmany"
		currently_held_item_name_2 = ""
		guard_beaten = false   
		await get_tree().create_timer(1.0).timeout
		_on_clicked_timeout2()
	else:
		print("clicked on ", currently_held_item_name_2)
		num_of_clicks_2 += 1
		update_click_label2()
		
func _on_clicked_timeout2():
	$"../Level2/GuardAlerted".visible = true
	$"../Level2/Guard".visible = false
	$"../Level2/GuardAlerted/Audio".play() 
	await get_tree().create_timer(2.1).timeout
	_on_guard_timeout()

func _on_guard_timeout():
	# game over
	get_tree().change_scene_to_file("res://GameOver2/game_over.tscn")
	return
	
func reset_clicks2():
	num_of_clicks_2 = 0
	update_click_label2()

func update_click_label2():
	print("update click label 2") 
	var label = get_clicks_label()
	if label:
		label.text = str(num_of_clicks_2)
		print("clicks updated to ", num_of_clicks_2)
		
		
		
# third
func increment_clicks3():
	if num_of_clicks_3 + 1 == 4: 
		if GameState.safe_opened == true:
				return 
		var label = get_clicks_label() 
		if label: 
			label.text = "too\nmany"
		currently_held_item_name_3 = ""
		safe_opened = false   
		sheriff_beaten = false
		await get_tree().create_timer(1.0).timeout
		_on_clicked_timeout3()
	else:
		print("clicked on ", currently_held_item_name_3)
		num_of_clicks_3 += 1
		update_click_label3()
		
func _on_clicked_timeout3():
	$"../Level3/SheriffSleepy".visible = false
	$"../Level3/SheriffAlerted".visible = true
	$"../Level3/SheriffAlerted/Audio".play() 
	await get_tree().create_timer(2).timeout
	_on_sheriff_timeout3()

func _on_sheriff_timeout3():
	# game over
	get_tree().change_scene_to_file("res://GameOver3/game_over.tscn")
	return
	
func reset_clicks3():
	num_of_clicks_3 = 0
	update_click_label3()

func update_click_label3():
	print("update click label 3") 
	var label = get_clicks_label()
	if label:
		label.text = str(num_of_clicks_3)
		print("clicks updated to ", num_of_clicks_3)
		
