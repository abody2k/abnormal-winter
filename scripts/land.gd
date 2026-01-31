extends Node3D


enum STATES {IDLE, GROWING}



var state : STATES = STATES.IDLE

const PLANT = preload("res://scenes/plant.tscn")
const CHICKEN = preload("res://scenes/chicken.tscn")
const COW = preload("res://scenes/cow.tscn")

func is_idle():
	if state == STATES.IDLE:
		return true
	else:
		return false
		

var animal = 0
func grow(type):
	animal = type
	state = STATES.GROWING
	var plant = PLANT.instantiate()
	add_child(plant)
	
	plant.position = Vector3(0,0.97,0)
	plant.finished_growing.connect(finished)
	
	
func finished():
	state = STATES.IDLE
	get_tree().call_group("machine","update_land",self)
	animal = 1
	match  animal:
		0:
			var chicken = CHICKEN.instantiate()
			get_parent().add_child(chicken)
			chicken.position = position + Vector3(0,.97,0)
		1:
			var chicken = COW.instantiate()
			get_parent().add_child(chicken)
			chicken.position = position	+ Vector3(0,.97,0)
	
func _ready():
	get_tree().call_group("machine","add_land",self)
	pass 
