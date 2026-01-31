extends Node3D


enum STATES {IDLE, GROWING}



var state : STATES = STATES.IDLE

const PLANT = preload("res://scenes/plant.tscn")
func is_idle():
	if state == STATES.IDLE:
		return true
	else:
		return false
		

func grow():
	state = STATES.GROWING
	var plant = PLANT.instantiate()
	add_child(plant)
	
	plant.position = Vector3(0,0.97,0)
	plant.finished_growing.connect(finished)
	
	
func finished():
	get_tree().call_group("machine","update_land",self)

	
func _ready():
	get_tree().call_group("machine","add_land",self)
	pass 
