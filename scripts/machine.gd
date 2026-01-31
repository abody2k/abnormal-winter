extends MeshInstance3D



var lands = []

var no_of_bags = 0


func add_land(land):
	lands.append(land)
	


func _ready():
	pass # Replace with function body.



func _process(delta):
	pass
	
	
func update_land(land):
	
	if no_of_bags > 0:
		land.grow(0)
		#land.grow(randi_range(0,2))
		no_of_bags -=1
		
		

func plant_something():
	
	for land in lands:
		if land.is_idle():
			land.grow(0)
			no_of_bags -=1
			return
			
func _on_area_3d_body_entered(body):
	if body.has_bag:
		body.remove_bag()
		no_of_bags+=1
		
		
