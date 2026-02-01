extends CharacterBody3D



var target : Vector3 = Vector3()
const TIME = 4.0 

#func _ready():
	#compute_xz()
	
func compute_xz():
	#target = global_position + Vector3(10,10,10)
	velocity.x =(target.x - global_position.x)/TIME
	velocity.z =(target.z - global_position.z)/TIME
	velocity.y = ((target.y - global_position.y) + (1.0/2.0 * (9.8) * pow(TIME,2)))/ TIME

func _physics_process(delta):
	velocity.y = velocity.y + delta * (-9.8)
	var obj = move_and_collide(velocity* delta)
	if obj :
		
		$Area3D.monitoring= true
	
func _on_area_3d_body_entered(body):
	print("hola")
	body.queue_free()
	queue_free()
	
	pass # Replace with function body.


func _on_timer_timeout():
	queue_free()
