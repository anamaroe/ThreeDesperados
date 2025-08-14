extends Node

var num_of_clicks: int = 0
var currently_held_item_name: String = ""

var chick_fed = false
var guard_beaten = false
var sheriff_beaten = false

var current_lvl: int = 1
var restarting_level: bool = false

func _ready():
	num_of_clicks = 0
	currently_held_item_name = ""
	chick_fed = false 
	guard_beaten = false
	sheriff_beaten = false
	
func get_clicks_label():
	if get_tree().current_scene and get_tree().current_scene.has_node("CanvasLayer/Panel/clicks_num"):
		return get_tree().current_scene.get_node("CanvasLayer/Panel/clicks_num") 
	return null
	
func increment_clicks():
	if num_of_clicks + 1 == 4: 
		if GameState.chick_fed == true and GameState.current_lvl == 1:
				return 
		if GameState.guard_beaten == true and GameState.current_lvl == 2:
				return 	
		if GameState.sheriff_beaten == true and GameState.current_lvl == 3:
				return 	 
		var label = get_clicks_label() 
		
		if label: 
			label.text = "too\nmany"
		currently_held_item_name = "" 
		await get_tree().create_timer(1.0).timeout 
		
		if GameState.current_lvl == 1:
			chick_fed = false   
			_on_clicked_timeout1() 
		if GameState.current_lvl == 2:
			guard_beaten = false    
			_on_clicked_timeout2() 
		if GameState.current_lvl == 3:
			sheriff_beaten = false    
			_on_clicked_timeout3()
	else:
		GameState.num_of_clicks += 1
		update_click_label()
	
func _on_clicked_timeout1():
	$"../Level1/Sheriff".visible = true
	$"../Level1/Sheriff/Audio".play() 
	await get_tree().create_timer(2.1).timeout
	_on_sheriff_timeout()

func _on_sheriff_timeout(): 
	GameState.restarting_level = true
	GameState.current_lvl = 1
	get_tree().change_scene_to_file("res://GameOver/game_over.tscn")
	return
 
func _on_clicked_timeout2():
	$"../Level2/GuardAlerted".visible = true
	$"../Level2/Guard".visible = false
	$"../Level2/GuardAlerted/Audio".play() 
	await get_tree().create_timer(2.1).timeout
	_on_guard_timeout()

func _on_guard_timeout(): 
	GameState.restarting_level = true
	GameState.current_lvl = 2
	get_tree().change_scene_to_file("res://GameOver/game_over.tscn")
	return
		
func _on_clicked_timeout3():
	$"../Level3/SheriffSleepy".visible = false
	$"../Level3/SheriffAlerted".visible = true
	$"../Level3/SheriffAlerted/Audio".play() 
	await get_tree().create_timer(2).timeout
	_on_sheriff_timeout3()

func _on_sheriff_timeout3(): 
	GameState.restarting_level = true
	GameState.current_lvl = 3
	get_tree().change_scene_to_file("res://GameOver/game_over.tscn")
	return
	
func update_click_label(): 
	var label = get_clicks_label()
	if label:
		label.text = str(num_of_clicks) 

func reset_clicks():
	num_of_clicks = 0
	update_click_label()
