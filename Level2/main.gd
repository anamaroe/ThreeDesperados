extends Node2D 
  
@onready var item_name_label = $CanvasLayer/Panel/item
@onready var clicks_label = $CanvasLayer/Panel/clicks_num 
var currently_held_item_name2 = "" 

func _ready():  
	var rope_area_2d = $RopeNCloth/Area2D 
	var key_area_2d = $Key/Area2D
	
	rope_area_2d.item_picked_up.connect(on_item_picked_up)
	rope_area_2d.item_dropped.connect(on_item_dropped)
	
	key_area_2d.item_picked_up.connect(on_item_picked_up)
	key_area_2d.item_dropped.connect(on_item_dropped)
	
	item_name_label.text = "nothin'"

func on_item_picked_up(item_name): 
	item_name_label.text = item_name
	print("picked up ", item_name)
	currently_held_item_name2 = item_name 
	GameState.currently_held_item_name_2 = item_name

func on_item_dropped():
	item_name_label.text = "nothin'"
	currently_held_item_name2 = "" 
	GameState.currently_held_item_name_2 = ""
	 
