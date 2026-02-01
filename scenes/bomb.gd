extends CharacterBody3D



var target : Vector3 = Vector3()
const TIME = 2.0 

	
func compute_xz():

	velocity.x =(target.x - global_position.x)/TIME
	velocity.z =(target.z - global_position.z)/TIME
	velocity.y = ((target.y - global_position.y) + (1.0/2.0 * (9.8) * pow(TIME,2)))/ TIME

func _physics_process(delta):
	velocity.y = velocity.y + delta * (-9.8)
	var obj = move_and_collide(velocity* delta)
	if obj :
		
		$Area3D.monitoring= true
	
func _on_area_3d_body_entered(body):
	body.queue_free()
	queue_free()
	


func _on_timer_timeout():
	queue_free()
