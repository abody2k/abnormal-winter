extends MeshInstance3D



var lands = []


func add_land(land):
	lands.append(land)
	


func _ready():
	pass # Replace with function body.



func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.has_bag:
		body.remove_bag()
		
