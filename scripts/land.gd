extends Node3D


enum STATES {IDLE, GROWING}

var state : STATES = STATES.IDLE

func is_idle():
	if state == STATES.IDLE:
		return true
	else:
		return false

func _ready():
	get_tree().call_group("machine","add_land",self)
	pass 
