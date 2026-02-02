extends Node3D


const WORM = preload("res://scenes/worm.tscn")
const TOUNGE = preload("res://scenes/tounge.tscn")
const FOOD = preload("res://scenes/bag.tscn")


var global_worms = 0 
var global_tounge = 0

const MAXIMUM_NO_OF_WORMS = 30
const MAXIMUM_NO_OF_TOUNGES = 30



func _ready():
	pass # Replace with function body.



func _process(delta):
	pass


func _on_timer_timeout():
	if global_worms < MAXIMUM_NO_OF_WORMS :
		var worm = WORM.instantiate()
		add_child(worm)
		#worm.position = $loc.position
		global_worms+=1
	
	if global_tounge < MAXIMUM_NO_OF_TOUNGES :
		var tounge = TOUNGE.instantiate()
		add_child(tounge)
		#tounge.position = $loc.position
		global_tounge+=1

func worm_died():
	global_worms-=1
	
func tounge_died():
	global_tounge-=1

func _on_materials_timeout():
	var bag = FOOD.instantiate()
	add_child(bag)
	bag.position = $house/drop.position
	pass # Replace with function body.
