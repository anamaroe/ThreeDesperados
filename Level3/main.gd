extends Node2D 
  
@onready var item_name_label = $CanvasLayer/Panel/item
@onready var clicks_label = $CanvasLayer/Panel/clicks_num 
var currently_held_item_name = "" 

func _ready():  
	var poster_area_2d = $Wanted2/Area2D 
	var cup_area_2d = $Cup2/Area2D
	
	poster_area_2d.item_picked_up.connect(on_item_picked_up)
	poster_area_2d.item_dropped.connect(on_item_dropped)
	
	cup_area_2d.item_picked_up.connect(on_item_picked_up)
	cup_area_2d.item_dropped.connect(on_item_dropped)
	
	item_name_label.text = "nothin'"

func on_item_picked_up(item_name): 
	item_name_label.text = item_name
	print("picked up ", item_name)
	currently_held_item_name = item_name 
	GameState.currently_held_item_name = item_name

func on_item_dropped():
	item_name_label.text = "nothin'"
	currently_held_item_name = "" 
	GameState.currently_held_item_name = ""
