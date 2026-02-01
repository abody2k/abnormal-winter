extends Node3D


const WORM = preload("res://scenes/worm.tscn")
const TOUNGE = preload("res://scenes/tounge.tscn")
const FOOD = preload("res://scenes/bag.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	pass


func _on_timer_timeout():
	var worm = WORM.instantiate()
	add_child(worm)
	worm.position = $loc.position
	var tounge = TOUNGE.instantiate()
	add_child(tounge)
	tounge.position = $loc.position
	pass # Replace with function body.


func _on_materials_timeout():
	var bag = FOOD.instantiate()
	add_child(bag)
	bag.position = $house/drop.position
	pass # Replace with function body.
