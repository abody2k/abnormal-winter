extends MeshInstance3D



var lands = []

var no_of_bags = 0


func add_land(land):
	lands.append(land)
	


func _ready():
	pass # Replace with function body.



func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.has_bag:
		body.remove_bag()
		no_of_bags+=1
		
		
