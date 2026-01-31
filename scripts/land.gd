extends Node3D


func _ready():
	get_tree().call_group("machine","add_land",self)
	pass 
