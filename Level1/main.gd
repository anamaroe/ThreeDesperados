extends Node2D
  
@onready var item_name_label = $CanvasLayer/Panel/predmet 
# new 
@onready var clicks_label = $CanvasLayer/Panel/clicks_num 
var currently_held_item_name = "" 

func _ready(): 
	var chilli_area_2d = $Chilli/Area2D 
	var corn_area_2d = $Corn/Area2D
	
	chilli_area_2d.item_picked_up.connect(on_item_picked_up)
	chilli_area_2d.item_dropped.connect(on_item_dropped)
	
	corn_area_2d.item_picked_up.connect(on_item_picked_up)
	corn_area_2d.item_dropped.connect(on_item_dropped)
	
	item_name_label.text = "nothin'"

func on_item_picked_up(item_name): 
	item_name_label.text = item_name
	currently_held_item_name = item_name 
	GameState.currently_held_item_name = item_name

func on_item_dropped():
	item_name_label.text = "nothin'"
	currently_held_item_name = "" 
	GameState.currently_held_item_name = ""
	 
